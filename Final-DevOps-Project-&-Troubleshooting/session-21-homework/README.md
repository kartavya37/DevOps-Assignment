# Session 21 Homework: Run the TaskBoard Application with Docker Compose

**Name:** Kartavya Panchal  
**Roll No.:** 24BCS10343

This homework runs the TaskBoard application in two ways:

1. **Manual run:** PostgreSQL, the backend and the frontend run as three separate processes.
2. **Docker Compose run:** one command builds the images and starts all three parts as containers.

For each run, I tested the application in the browser and tested all backend APIs. All output in this file comes from commands that I ran on my Mac (macOS, Apple Silicon) on 7 October 2026.

The full Final DevOps Project (Kubernetes, Helm, CI/CD, monitoring and GitOps) is in the [main README](../README.md) of this folder.

## Contents

- [Application](#application)
- [Part 1: Run the application manually](#part-1-run-the-application-manually)
- [Part 2: Dockerfiles and docker-compose.yml](#part-2-dockerfiles-and-docker-composeyml)
- [Part 3: Run with docker compose up -d --build](#part-3-run-with-docker-compose-up--d---build)
- [Part 4: Test the application and the backend APIs](#part-4-test-the-application-and-the-backend-apis)
- [Part 5: Stop the stack](#part-5-stop-the-stack)
- [Summary](#summary)

## Application

TaskBoard is a small task manager with three parts:

| Part | Technology | Source |
|---|---|---|
| Frontend | React + Vite (served by Nginx in Docker) | [`application/frontend/`](../application/frontend/) |
| Backend | Python FastAPI + SQLAlchemy + Alembic | [`application/backend/`](../application/backend/) |
| Database | PostgreSQL 16 | `postgres:16-alpine` image |

```mermaid
flowchart LR
    U[Browser] --> F[Frontend<br/>React UI]
    F -->|/api/*| B[Backend<br/>FastAPI :8000]
    B -->|SQL| D[(PostgreSQL<br/>:5432)]
```

The backend API has these endpoints:

| Method | Path | Use |
|---|---|---|
| GET | `/health` | liveness check |
| GET | `/ready` | readiness check (also checks the database) |
| GET | `/api/info` | version and environment |
| GET | `/api/tasks` | list all tasks |
| POST | `/api/tasks` | create a task |
| GET | `/api/tasks/{id}` | get one task |
| PUT | `/api/tasks/{id}` | update a task |
| DELETE | `/api/tasks/{id}` | delete a task |
| GET | `/api/tasks/stats` | count the tasks for each status |

---

## Part 1: Run the application manually

In this part, each component runs as its own process. PostgreSQL runs in one container, because I do not have PostgreSQL installed on the Mac. The backend runs with Python on the Mac, and the frontend runs with Node.js on the Mac.

| Component | How it runs | Address |
|---|---|---|
| PostgreSQL | `docker run` (one container) | `localhost:5433` |
| Backend | `uvicorn` in a Python virtual environment | `http://localhost:8000` |
| Frontend | `npm run dev` (Vite development server) | `http://localhost:5173` |

### Step 1: Start PostgreSQL

1. Start a PostgreSQL 16 container. Use port 5433 on the Mac.
2. Wait until PostgreSQL accepts connections.

![manual postgres](screenshots/01-manual-postgres.png)

```console
$ docker run -d --name taskboard-postgres -e POSTGRES_DB=taskboard -e POSTGRES_USER=taskboard -e POSTGRES_PASSWORD=demo-password-123 -p 5433:5432 postgres:16-alpine
9631a3ede2e40dc39686615ce314761d10d08a1c8d7f1795a79bf6b0fb60f8ae

$ until docker exec taskboard-postgres pg_isready -U taskboard -d taskboard; do sleep 2; done
/var/run/postgresql:5432 - no response
/var/run/postgresql:5432 - accepting connections

$ docker ps --filter name=taskboard-postgres --format "table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}"
NAMES                IMAGE                STATUS         PORTS
taskboard-postgres   postgres:16-alpine   Up 2 seconds   0.0.0.0:5433->5432/tcp, [::]:5433->5432/tcp
```

The first `pg_isready` call got "no response", because the server was still starting. The second call got "accepting connections".

**CAUTION:** The password `demo-password-123` is a demo value for a local laptop. Do not use it on a real server.

### Step 2: Install the backend and create the database tables

Run these commands in `application/backend`.

1. Create a Python virtual environment and install the packages from `requirements.txt`.
2. Set `DATABASE_URL` to the PostgreSQL container.
3. Run the Alembic migration. It creates the `tasks` table.

![manual backend install](screenshots/02-manual-backend-install.png)

```console
$ python3 --version
Python 3.13.15

$ python3 -m venv .venv && source .venv/bin/activate && pip install -q -r requirements.txt && pip list 2>/dev/null | grep -i -E "^(fastapi|uvicorn|sqlalchemy|psycopg|alembic) "
alembic                           1.20.0
fastapi                           0.142.2
psycopg                           3.3.6
SQLAlchemy                        2.1.3
uvicorn                           0.54.0

$ source .venv/bin/activate && export DATABASE_URL="postgresql+psycopg://taskboard:demo-password-123@localhost:5433/taskboard" && alembic upgrade head
INFO  [alembic.runtime.migration] Context impl PostgresqlImpl.
INFO  [alembic.runtime.migration] Will assume transactional DDL.
INFO  [alembic.runtime.migration] Running upgrade  -> 0001_create_tasks

$ docker exec taskboard-postgres psql -U taskboard -d taskboard -c "\dt"
              List of relations
 Schema |      Name       | Type  |   Owner   
--------+-----------------+-------+-----------
 public | alembic_version | table | taskboard
 public | tasks           | table | taskboard
(2 rows)
```

### Step 3: Start the backend

1. Start the API with `uvicorn` on port 8000.
2. Send requests to `/health`, `/ready` and `/api/info`.

![manual backend start](screenshots/03-manual-backend-start.png)

```console
$ export DATABASE_URL="postgresql+psycopg://taskboard:demo-password-123@localhost:5433/taskboard" APP_ENV=manual
$ uvicorn app.main:app --host 127.0.0.1 --port 8000
INFO:     Started server process [73983]
INFO:     Waiting for application startup.
2026-10-07 20:56:16,461 INFO taskboard TaskBoard API 1.0.0 started (env=manual)
INFO:     Application startup complete.
INFO:     Uvicorn running on http://127.0.0.1:8000 (Press CTRL+C to quit)
```

![manual backend health](screenshots/04-manual-backend-health.png)

```console
$ curl -s http://localhost:8000/health; echo
{"status":"UP"}

$ curl -s http://localhost:8000/ready; echo
{"status":"READY","database":"UP"}

$ curl -s http://localhost:8000/api/info; echo
{"version":"1.0.0","env":"manual"}
```

`/ready` shows `"database":"UP"`, so the backend can connect to PostgreSQL. The version is `1.0.0`, because the manual run does not set `APP_VERSION`.

### Step 4: Install and start the frontend

Run these commands in `application/frontend`.

1. Install the packages with `npm ci`. This command uses the exact versions in `package-lock.json`.
2. Start the Vite development server.

![manual frontend install](screenshots/05-manual-frontend-install.png)

```console
$ node --version; npm --version
v24.19.0
11.17.0

$ npm ci 2>&1 | grep -E "added|audited|vulnerabilit"
added 20 packages, and audited 21 packages in 609ms
found 0 vulnerabilities
```

![manual frontend start](screenshots/06-manual-frontend-start.png)

```console
$ npm run dev -- --host 127.0.0.1

> taskboard-frontend@1.0.0 dev
> vite --host 127.0.0.1


  VITE v8.3.3  ready in 548 ms

  ➜  Local:   http://127.0.0.1:5173/
```

The Vite configuration ([`vite.config.js`](../application/frontend/vite.config.js)) sends each `/api` request to the backend on port 8000.

### Step 5: Test the backend APIs (manual run)

1. Create three tasks with `POST /api/tasks`.
2. List the tasks with `GET /api/tasks`.

![manual api create](screenshots/07-manual-api-create.png)

```console
$ curl -s -X POST http://localhost:8000/api/tasks -H 'Content-Type: application/json' -d '{"title":"Write Dockerfiles","priority":"HIGH","assignee":"Kartavya"}'; echo
{"title":"Write Dockerfiles","description":"","priority":"HIGH","status":"TODO","assignee":"Kartavya","id":1,"created_at":"2026-10-07T15:27:06.269248Z"}

$ curl -s -X POST http://localhost:8000/api/tasks -H 'Content-Type: application/json' -d '{"title":"Run docker compose","priority":"MEDIUM","assignee":"Kartavya"}'; echo
{"title":"Run docker compose","description":"","priority":"MEDIUM","status":"TODO","assignee":"Kartavya","id":2,"created_at":"2026-10-07T15:27:06.291268Z"}

$ curl -s -X POST http://localhost:8000/api/tasks -H 'Content-Type: application/json' -d '{"title":"Delete me","priority":"LOW"}'; echo
{"title":"Delete me","description":"","priority":"LOW","status":"TODO","assignee":"Unassigned","id":3,"created_at":"2026-10-07T15:27:06.305631Z"}

$ curl -s http://localhost:8000/api/tasks | python3 -m json.tool --compact
[{"title":"Delete me","description":"","priority":"LOW","status":"TODO","assignee":"Unassigned","id":3,"created_at":"2026-10-07T15:27:06.305631Z"},{"title":"Run docker compose","description":"","priority":"MEDIUM","status":"TODO","assignee":"Kartavya","id":2,"created_at":"2026-10-07T15:27:06.291268Z"},{"title":"Write Dockerfiles","description":"","priority":"HIGH","status":"TODO","assignee":"Kartavya","id":1,"created_at":"2026-10-07T15:27:06.269248Z"}]
```

3. Get one task, update two tasks and delete one task.
4. Get the deleted task again. The API must return HTTP 404.
5. Get the statistics directly from the backend, and also through the frontend server on port 5173.

![manual api update delete](screenshots/08-manual-api-update-delete.png)

```console
$ curl -s http://localhost:8000/api/tasks/1; echo
{"title":"Write Dockerfiles","description":"","priority":"HIGH","status":"TODO","assignee":"Kartavya","id":1,"created_at":"2026-10-07T15:27:06.269248Z"}

$ curl -s -X PUT http://localhost:8000/api/tasks/1 -H 'Content-Type: application/json' -d '{"status":"DONE"}'; echo
{"title":"Write Dockerfiles","description":"","priority":"HIGH","status":"DONE","assignee":"Kartavya","id":1,"created_at":"2026-10-07T15:27:06.269248Z"}

$ curl -s -X PUT http://localhost:8000/api/tasks/2 -H 'Content-Type: application/json' -d '{"status":"IN_PROGRESS"}'; echo
{"title":"Run docker compose","description":"","priority":"MEDIUM","status":"IN_PROGRESS","assignee":"Kartavya","id":2,"created_at":"2026-10-07T15:27:06.291268Z"}

$ curl -s -o /dev/null -w 'DELETE /api/tasks/3 -> HTTP %{http_code}\n' -X DELETE http://localhost:8000/api/tasks/3
DELETE /api/tasks/3 -> HTTP 204

$ curl -s -w '  <- HTTP %{http_code}\n' http://localhost:8000/api/tasks/3
{"detail":"Task not found"}  <- HTTP 404

$ curl -s http://localhost:8000/api/tasks/stats; echo
{"total":2,"todo":0,"inProgress":1,"done":1}

$ curl -s http://localhost:5173/api/tasks/stats; echo
{"total":2,"todo":0,"inProgress":1,"done":1}
```

All operations work. The last command gives the same result as the command before it. This shows that the frontend server sends `/api` requests to the backend.

### Step 6: Test the application in the browser (manual run)

Open `http://localhost:5173` in the browser.

![manual app in browser](screenshots/09-manual-app-browser.png)

The dashboard shows the two tasks that are in the database, with the correct status and priority. The counters show 2 tasks in total, 1 in progress and 1 completed. The footer shows `API v1.0.0 · manual`, so the page gets its data from the backend of the manual run.

### Step 7: Stop the manual run

1. Stop the frontend and the backend with `Ctrl+C` in their terminals.
2. Remove the PostgreSQL container.

![manual stop](screenshots/10-manual-stop.png)

```console
$ docker rm -f taskboard-postgres
taskboard-postgres

$ lsof -nP -iTCP:8000 -iTCP:5173 -iTCP:5433 -sTCP:LISTEN || echo "ports 8000, 5173 and 5433 are free"
ports 8000, 5173 and 5433 are free
```

---

## Part 2: Dockerfiles and docker-compose.yml

| File | Description |
|---|---|
| [`docker/backend.Dockerfile`](../docker/backend.Dockerfile) | Backend image |
| [`docker/frontend.Dockerfile`](../docker/frontend.Dockerfile) | Frontend image |
| [`docker/docker-compose.yml`](../docker/docker-compose.yml) | Starts PostgreSQL, the backend and the frontend together |

### Backend Dockerfile

The backend Dockerfile has two stages:

1. **Build stage** (`python:3.13-slim`): installs the packages from `requirements.txt` into a virtual environment in `/opt/venv`.
2. **Runtime stage** (`python:3.13-slim`): copies only `/opt/venv`, the Alembic files and the `app` code.

Other settings:

- The container runs as a non-root user (UID 10001).
- A `HEALTHCHECK` calls `/health` every 15 seconds.
- At start, the container runs `alembic upgrade head` and then starts `uvicorn` on port 8000.

### Frontend Dockerfile

The frontend Dockerfile also has two stages:

1. **Build stage** (`node:22-alpine`): runs `npm ci` and `npm run build`. The result is static HTML, CSS and JavaScript files in `dist/`.
2. **Runtime stage** (`nginx:1.31-alpine`): copies only the `dist/` files. Node.js and the source code are not in the final image.

Other settings:

- Nginx runs as the non-root user `nginx` (UID 101) on port 8080.
- The Nginx configuration sends each `/api/` request to the backend (`BACKEND_URL=http://backend:8000`).

### docker-compose.yml

```yaml
name: s21-taskboard

services:
  postgres:
    image: postgres:16-alpine
    environment:
      POSTGRES_DB: taskboard
      POSTGRES_USER: taskboard
      POSTGRES_PASSWORD: demo-password-123
    volumes:
      - postgres-data:/var/lib/postgresql/data
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U taskboard -d taskboard"]
      interval: 5s
      timeout: 3s
      retries: 10

  backend:
    build:
      context: ../application/backend
      dockerfile: ../../docker/backend.Dockerfile
      args:
        APP_VERSION: "1.1.0"
    image: taskboard-backend:compose
    environment:
      DATABASE_URL: postgresql+psycopg://taskboard:demo-password-123@postgres:5432/taskboard
      APP_ENV: compose
    depends_on:
      postgres:
        condition: service_healthy
    ports:
      - "18781:8000"

  frontend:
    build:
      context: ../application/frontend
      dockerfile: ../../docker/frontend.Dockerfile
      args:
        APP_VERSION: "1.1.0"
    image: taskboard-frontend:compose
    environment:
      BACKEND_URL: http://backend:8000
    depends_on:
      backend:
        condition: service_healthy
    ports:
      - "18780:8080"

volumes:
  postgres-data:
```

Important points:

- The backend connects to the host name `postgres`. Docker Compose puts all services on one network and gives each service a DNS name.
- `depends_on` with `condition: service_healthy` sets the start order. PostgreSQL must be healthy before the backend starts, and the backend must be healthy before the frontend starts.
- The named volume `postgres-data` keeps the database files.
- The ports on the Mac are 18780 (frontend) and 18781 (backend API). PostgreSQL has no port on the Mac, because only the backend needs it.

---

## Part 3: Run with docker compose up -d --build

Run this command in the `docker/` folder:

- `-d` starts the containers in the background.
- `--build` builds the images before Docker Compose starts the containers.

![docker compose up](screenshots/11-compose-up.png)

```console
$ cd docker
$ docker compose up -d --build
# build steps hidden here, full output: evidence/docker-compose-up.txt
 Image taskboard-backend:compose Built
 Image taskboard-frontend:compose Built
 Volume s21-taskboard_postgres-data Created
 Volume s21-taskboard_postgres-data Created
 Network s21-taskboard_default Created
 Network s21-taskboard_default Created
 Container s21-taskboard-postgres-1 Created
 Container s21-taskboard-backend-1 Created
 Container s21-taskboard-frontend-1 Created
 Container s21-taskboard-postgres-1 Started
 Container s21-taskboard-postgres-1 Healthy
 Container s21-taskboard-backend-1 Started
 Container s21-taskboard-backend-1 Healthy
 Container s21-taskboard-frontend-1 Started
```

The full output (162 lines, with all build steps) is in [`evidence/docker-compose-up.txt`](evidence/docker-compose-up.txt). The order of the lines shows `depends_on`: PostgreSQL became `Healthy` before the backend started, and the backend became `Healthy` before the frontend started.

Examine the containers and the images:

![docker compose ps](screenshots/12-compose-ps.png)

```console
$ docker compose ps --format "table {{.Service}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}"
SERVICE    IMAGE                        STATUS                    PORTS
backend    taskboard-backend:compose    Up 21 seconds (healthy)   0.0.0.0:18781->8000/tcp, [::]:18781->8000/tcp
frontend   taskboard-frontend:compose   Up 16 seconds             0.0.0.0:18780->8080/tcp, [::]:18780->8080/tcp
postgres   postgres:16-alpine           Up 27 seconds (healthy)   5432/tcp

$ docker compose images
CONTAINER                  REPOSITORY           TAG                 PLATFORM            IMAGE ID            SIZE                CREATED
s21-taskboard-backend-1    taskboard-backend    compose             linux/arm64         735d9dd91dcf        72.4MB              28 seconds ago
s21-taskboard-frontend-1   taskboard-frontend   compose             linux/arm64         1e309d31f14c        30MB                2 hours ago
s21-taskboard-postgres-1   postgres             16-alpine           linux/arm64/v8      cf78e76683b9        114MB               7 weeks ago
```

All three containers run, and the backend and PostgreSQL are `healthy`. The frontend image is only 30 MB, because it has only Nginx and the static files. The frontend image shows "2 hours ago", because Docker used the build cache from an earlier build of the same files.

---

## Part 4: Test the application and the backend APIs

### Step 1: Health checks

![compose api health](screenshots/13-compose-api-health.png)

```console
$ curl -s http://localhost:18781/health; echo
{"status":"UP"}

$ curl -s http://localhost:18781/ready; echo
{"status":"READY","database":"UP"}

$ curl -s http://localhost:18781/api/info; echo
{"version":"1.1.0","env":"compose"}

$ curl -s http://localhost:18780/api/info; echo
{"version":"1.1.0","env":"compose"}
```

The backend in the container connects to the PostgreSQL container (`"database":"UP"`). The last command goes to the frontend container on port 18780. Nginx sends it to the backend and returns the same answer.

### Step 2: Create, update and delete tasks

1. Create three tasks. The third request goes through the frontend (port 18780).
2. Change the status of task 1 to `DONE` and of task 2 to `IN_PROGRESS`.
3. Create a temporary task and delete it.
4. Get the deleted task again. The API must return HTTP 404.
5. Send a task with an empty title. The API must return HTTP 422 (validation error).

![compose api crud](screenshots/14-compose-api-crud.png)

```console
$ curl -s -X POST http://localhost:18781/api/tasks -H 'Content-Type: application/json' -d '{"title":"Build images","priority":"HIGH","assignee":"Kartavya"}'; echo
{"title":"Build images","description":"","priority":"HIGH","status":"TODO","assignee":"Kartavya","id":1,"created_at":"2026-10-07T15:28:36.220125Z"}

$ curl -s -X POST http://localhost:18781/api/tasks -H 'Content-Type: application/json' -d '{"title":"Test backend APIs","priority":"MEDIUM","assignee":"Kartavya"}'; echo
{"title":"Test backend APIs","description":"","priority":"MEDIUM","status":"TODO","assignee":"Kartavya","id":2,"created_at":"2026-10-07T15:28:36.238241Z"}

$ curl -s -X POST http://localhost:18780/api/tasks -H 'Content-Type: application/json' -d '{"title":"Add screenshots to README","priority":"LOW","assignee":"Kartavya"}'; echo
{"title":"Add screenshots to README","description":"","priority":"LOW","status":"TODO","assignee":"Kartavya","id":3,"created_at":"2026-10-07T15:28:36.255474Z"}

$ curl -s -X PUT http://localhost:18781/api/tasks/1 -H 'Content-Type: application/json' -d '{"status":"DONE"}'; echo
{"title":"Build images","description":"","priority":"HIGH","status":"DONE","assignee":"Kartavya","id":1,"created_at":"2026-10-07T15:28:36.220125Z"}

$ curl -s -X PUT http://localhost:18781/api/tasks/2 -H 'Content-Type: application/json' -d '{"status":"IN_PROGRESS"}'; echo
{"title":"Test backend APIs","description":"","priority":"MEDIUM","status":"IN_PROGRESS","assignee":"Kartavya","id":2,"created_at":"2026-10-07T15:28:36.238241Z"}

$ curl -s -X POST http://localhost:18781/api/tasks -H 'Content-Type: application/json' -d '{"title":"Temporary task"}' | python3 -c 'import json,sys; t=json.load(sys.stdin); print("created id", t["id"])'
created id 4

$ curl -s -o /dev/null -w 'DELETE /api/tasks/4 -> HTTP %{http_code}\n' -X DELETE http://localhost:18781/api/tasks/4
DELETE /api/tasks/4 -> HTTP 204

$ curl -s -w '  <- HTTP %{http_code}\n' http://localhost:18781/api/tasks/4
{"detail":"Task not found"}  <- HTTP 404

$ curl -s -w '  <- HTTP %{http_code}\n' -X POST http://localhost:18781/api/tasks -H 'Content-Type: application/json' -d '{"title":""}'
{"detail":[{"type":"string_too_short","loc":["body","title"],"msg":"String should have at least 1 character","input":"","ctx":{"min_length":1}}]}  <- HTTP 422
```

### Step 3: Make sure that the data is in PostgreSQL

Compare the API result with a direct query to the database.

![compose api list](screenshots/15-compose-api-list.png)

```console
$ curl -s http://localhost:18781/api/tasks | python3 -c 'import json,sys; [print(t["id"], t["status"].ljust(12), t["priority"].ljust(7), t["title"]) for t in json.load(sys.stdin)]'
3 TODO         LOW     Add screenshots to README
2 IN_PROGRESS  MEDIUM  Test backend APIs
1 DONE         HIGH    Build images

$ curl -s http://localhost:18781/api/tasks/stats; echo
{"total":3,"todo":1,"inProgress":1,"done":1}

$ docker compose -f ../docker/docker-compose.yml exec postgres psql -U taskboard -d taskboard -c "SELECT id, status, priority, title FROM tasks ORDER BY id;"
 id |   status    | priority |           title           
----+-------------+----------+---------------------------
  1 | DONE        | HIGH     | Build images
  2 | IN_PROGRESS | MEDIUM   | Test backend APIs
  3 | TODO        | LOW      | Add screenshots to README
(3 rows)
```

The API and the database show the same three tasks. Task 4 is not in the table, because the API deleted it.

### Step 4: Test the application in the browser

Open `http://localhost:18780` in the browser.

![compose app in browser](screenshots/16-compose-app-browser.png)

The dashboard shows the three tasks from the PostgreSQL container. The counters show 3 tasks in total, 1 to do, 1 in progress and 1 completed. The footer shows `API v1.1.0 · compose`, so the page gets its data from the backend container.

The "Recent activity" panel is static demo content of the user interface. It does not come from the API.

### Step 5: API documentation

FastAPI makes interactive API documentation. Open `http://localhost:18781/docs`.

![compose api docs](screenshots/17-compose-api-docs.png)

The page shows all endpoints of the backend, with the methods GET, POST, PUT and DELETE.

### Step 6: Backend logs

![compose logs](screenshots/18-compose-logs.png)

```console
$ docker compose logs backend 2>&1 | grep -E "Running upgrade|started|task created|PUT|DELETE" | head -n 12
backend-1  | INFO  [alembic.runtime.migration] Running upgrade  -> 0001_create_tasks
backend-1  | 2026-10-07 15:28:04,092 INFO taskboard TaskBoard API 1.1.0 started (env=compose)
backend-1  | 2026-10-07 15:28:36,224 INFO taskboard task created id=1 priority=HIGH
backend-1  | 2026-10-07 15:28:36,239 INFO taskboard task created id=2 priority=MEDIUM
backend-1  | 2026-10-07 15:28:36,256 INFO taskboard task created id=3 priority=LOW
backend-1  | INFO:     192.168.65.1:24018 - "PUT /api/tasks/1 HTTP/1.1" 200 OK
backend-1  | INFO:     192.168.65.1:18321 - "PUT /api/tasks/2 HTTP/1.1" 200 OK
backend-1  | 2026-10-07 15:28:36,298 INFO taskboard task created id=4 priority=MEDIUM
backend-1  | INFO:     192.168.65.1:22144 - "DELETE /api/tasks/4 HTTP/1.1" 204 No Content
```

The logs show the Alembic migration at start and each API request from the tests.

---

## Part 5: Stop the stack

`docker compose down -v` stops and removes the containers and the network. The `-v` option also removes the `postgres-data` volume.

**CAUTION:** The `-v` option deletes the database data. Do not use `-v` if you want to keep the tasks.

![docker compose down](screenshots/19-compose-down.png)

```console
$ docker compose down -v
 Container s21-taskboard-frontend-1 Stopping 
 Container s21-taskboard-frontend-1 Stopped 
 Container s21-taskboard-frontend-1 Removing 
 Container s21-taskboard-frontend-1 Removed 
 Container s21-taskboard-backend-1 Stopping 
 Container s21-taskboard-backend-1 Stopped 
 Container s21-taskboard-backend-1 Removing 
 Container s21-taskboard-backend-1 Removed 
 Container s21-taskboard-postgres-1 Stopping 
 Container s21-taskboard-postgres-1 Stopped 
 Container s21-taskboard-postgres-1 Removing 
 Container s21-taskboard-postgres-1 Removed 
 Volume s21-taskboard_postgres-data Removing 
 Network s21-taskboard_default Removing 
 Volume s21-taskboard_postgres-data Removed 
 Network s21-taskboard_default Removed 

$ docker compose ps -a
NAME      IMAGE     COMMAND   SERVICE   CREATED   STATUS    PORTS
```

Docker Compose stopped the containers in the reverse order of the start: frontend, backend, then PostgreSQL.

---

## Summary

| Task | Result | Evidence |
|---|---|---|
| Run the application manually (frontend, backend, PostgreSQL) | Done | [Part 1](#part-1-run-the-application-manually), screenshots 01-10 |
| Dockerfiles for the frontend and the backend | Done | [Part 2](#part-2-dockerfiles-and-docker-composeyml) |
| `docker-compose.yml` | Done | [Part 2](#docker-composeyml) |
| Run `docker compose up -d --build` | Done | [Part 3](#part-3-run-with-docker-compose-up--d---build), screenshots 11-12 |
| Test the application | Done | browser screenshots 09 and 16 |
| Test the backend APIs | Done | screenshots 04, 07, 08, 13, 14, 15, 17 |
| Screenshots in README.md | Done | [`screenshots/`](screenshots/) (19 files) |

What I learned:

- **Manual run vs Docker Compose:** the manual run needs three terminals, a Python virtual environment, Node.js and the correct environment variables. Docker Compose does all of this with one command and one file.
- **Service names are DNS names:** in Docker Compose, the backend connects to `postgres:5432`. In the manual run, it connects to `localhost:5433`. Only `DATABASE_URL` changes. The code stays the same.
- **Health checks control the start order:** `depends_on` with `service_healthy` makes sure that the backend does not start before the database can accept connections.
- **Multi-stage builds keep images small:** the frontend image has only Nginx and the built files (30 MB). The build tools stay in the build stage.
