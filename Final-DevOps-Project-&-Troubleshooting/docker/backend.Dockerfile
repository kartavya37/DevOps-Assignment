# TaskBoard API image (FastAPI + Uvicorn).
# Build context: application/backend
#   docker build -f docker/backend.Dockerfile -t taskboard-backend:1.0.0 application/backend

# Stage 1: install the Python packages into a virtual environment.
FROM python:3.13-slim AS build
ENV PIP_NO_CACHE_DIR=1 PIP_DISABLE_PIP_VERSION_CHECK=1
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"
COPY requirements.txt .
# Remove pip from the virtual environment after the install: the application does not need it.
RUN pip install -r requirements.txt && pip uninstall -y pip

# Stage 2: runtime image without pip caches and build files.
FROM python:3.13-slim AS runtime
ARG APP_VERSION=1.0.0
ARG GIT_SHA=local
LABEL org.opencontainers.image.title="taskboard-backend" \
      org.opencontainers.image.version="${APP_VERSION}" \
      org.opencontainers.image.revision="${GIT_SHA}"
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PATH="/opt/venv/bin:$PATH" \
    APP_VERSION=${APP_VERSION}
# Remove pip from the base image too, then add the non-root user.
RUN pip uninstall -y pip setuptools wheel 2>/dev/null || true \
    && useradd --uid 10001 --no-create-home --shell /usr/sbin/nologin appuser
WORKDIR /app
COPY --from=build /opt/venv /opt/venv
COPY alembic.ini ./
COPY alembic ./alembic
COPY app ./app
# Run as a non-root user (numeric UID, so Kubernetes runAsNonRoot can check it).
USER 10001
EXPOSE 8000
HEALTHCHECK --interval=15s --timeout=3s --start-period=20s --retries=3 \
  CMD ["python", "-c", "import urllib.request,sys; sys.exit(0 if urllib.request.urlopen('http://127.0.0.1:8000/health', timeout=2).status == 200 else 1)"]
# Apply the database migrations, then start the API.
CMD ["sh", "-c", "alembic upgrade head && exec uvicorn app.main:app --host 0.0.0.0 --port 8000 --proxy-headers"]
