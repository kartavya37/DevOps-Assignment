"""TaskBoard API: a small task tracker for a DevOps team.

Endpoints:
  GET /           service information
  GET /health     liveness: the process is alive (no database call)
  GET /ready      readiness: the database answers
  GET /metrics    Prometheus metrics
  GET /api/info   version and environment (for the frontend)
  GET/POST/PUT/DELETE /api/tasks...   task CRUD and statistics
"""
import logging
from contextlib import asynccontextmanager

from fastapi import Depends, FastAPI, HTTPException, Response, status
from fastapi.middleware.cors import CORSMiddleware
from prometheus_client import Counter, Gauge
from prometheus_fastapi_instrumentator import Instrumentator
from sqlalchemy import func, select, text
from sqlalchemy.exc import SQLAlchemyError
from sqlalchemy.orm import Session

from .config import settings
from .db import Base, engine, get_db
from .models import Task
from .schemas import StatsOut, TaskCreate, TaskOut, TaskUpdate

logging.basicConfig(level=settings.log_level.upper(), format="%(asctime)s %(levelname)s %(name)s %(message)s")
log = logging.getLogger("taskboard")

# Business metrics (the instrumentator adds the HTTP metrics).
BUILD_INFO = Gauge("taskboard_build_info", "Build information of the API", ["version", "env"])
TASKS_CREATED = Counter("taskboard_tasks_created_total", "Tasks created", ["priority"])
TASKS_DELETED = Counter("taskboard_tasks_deleted_total", "Tasks deleted")
TASK_STATUS_CHANGES = Counter("taskboard_task_status_changes_total", "Task status changes", ["status"])


@asynccontextmanager
async def lifespan(_app: FastAPI):
    if settings.auto_create_tables:
        Base.metadata.create_all(bind=engine)
    BUILD_INFO.labels(version=settings.app_version, env=settings.app_env).set(1)
    log.info("TaskBoard API %s started (env=%s)", settings.app_version, settings.app_env)
    yield
    log.info("TaskBoard API stopped")


app = FastAPI(title=settings.app_name, version=settings.app_version, lifespan=lifespan)
app.add_middleware(CORSMiddleware, allow_origins=["*"], allow_methods=["*"], allow_headers=["*"])
# Finer latency buckets than the default (0.1, 0.5, 1) give a useful p95/p99 in Grafana.
Instrumentator(excluded_handlers=["/metrics"]).instrument(
    app, latency_lowr_buckets=(0.005, 0.01, 0.025, 0.05, 0.1, 0.25, 0.5, 1, 2.5)
).expose(app, endpoint="/metrics", include_in_schema=False)


@app.get("/")
def root():
    return {"service": settings.app_name, "version": settings.app_version, "env": settings.app_env, "docs": "/docs"}


@app.get("/api/info")
def info():
    """Version and environment for the frontend footer (the Ingress sends only /api to the backend)."""
    return {"version": settings.app_version, "env": settings.app_env}


@app.get("/health")
def health():
    return {"status": "UP"}


@app.get("/ready")
def ready(response: Response, db: Session = Depends(get_db)):
    try:
        db.execute(text("SELECT 1"))
    except SQLAlchemyError as err:
        log.error("readiness check failed: database is not available: %s", err.__class__.__name__)
        response.status_code = status.HTTP_503_SERVICE_UNAVAILABLE
        return {"status": "NOT_READY", "database": "DOWN"}
    return {"status": "READY", "database": "UP"}


@app.get("/api/tasks", response_model=list[TaskOut])
def list_tasks(db: Session = Depends(get_db)):
    return list(db.scalars(select(Task).order_by(Task.id.desc())))


@app.get("/api/tasks/stats", response_model=StatsOut)
def stats(db: Session = Depends(get_db)):
    rows = db.execute(select(Task.status, func.count(Task.id)).group_by(Task.status)).all()
    counts = {task_status: count for task_status, count in rows}
    return StatsOut(
        total=sum(counts.values()),
        todo=counts.get("TODO", 0),
        inProgress=counts.get("IN_PROGRESS", 0),
        done=counts.get("DONE", 0),
    )


def _get_or_404(db: Session, task_id: int) -> Task:
    task = db.get(Task, task_id)
    if not task:
        raise HTTPException(status_code=404, detail="Task not found")
    return task


@app.get("/api/tasks/{task_id}", response_model=TaskOut)
def get_task(task_id: int, db: Session = Depends(get_db)):
    return _get_or_404(db, task_id)


@app.post("/api/tasks", response_model=TaskOut, status_code=status.HTTP_201_CREATED)
def create_task(payload: TaskCreate, db: Session = Depends(get_db)):
    task = Task(**payload.model_dump())
    db.add(task)
    db.commit()
    db.refresh(task)
    TASKS_CREATED.labels(priority=task.priority).inc()
    log.info("task created id=%s priority=%s", task.id, task.priority)
    return task


@app.put("/api/tasks/{task_id}", response_model=TaskOut)
def update_task(task_id: int, payload: TaskUpdate, db: Session = Depends(get_db)):
    task = _get_or_404(db, task_id)
    changes = payload.model_dump(exclude_unset=True)
    if "status" in changes and changes["status"] != task.status:
        TASK_STATUS_CHANGES.labels(status=changes["status"]).inc()
    for key, value in changes.items():
        setattr(task, key, value)
    db.commit()
    db.refresh(task)
    return task


@app.delete("/api/tasks/{task_id}", status_code=status.HTTP_204_NO_CONTENT)
def delete_task(task_id: int, db: Session = Depends(get_db)):
    task = _get_or_404(db, task_id)
    db.delete(task)
    db.commit()
    TASKS_DELETED.inc()
