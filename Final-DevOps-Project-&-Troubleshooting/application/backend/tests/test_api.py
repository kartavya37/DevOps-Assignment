def make_task(client, **overrides):
    body = {"title": "Configure ingress", "priority": "HIGH", "assignee": "Kartavya"}
    body.update(overrides)
    response = client.post("/api/tasks", json=body)
    assert response.status_code == 201
    return response.json()


def test_health(client):
    response = client.get("/health")
    assert response.status_code == 200
    assert response.json() == {"status": "UP"}


def test_ready_checks_database(client):
    response = client.get("/ready")
    assert response.status_code == 200
    assert response.json() == {"status": "READY", "database": "UP"}


def test_root_shows_service_and_version(client):
    body = client.get("/").json()
    assert body["service"] == "TaskBoard API"
    assert body["env"] == "test"
    assert "version" in body


def test_info_for_frontend(client):
    body = client.get("/api/info").json()
    assert body["env"] == "test"
    assert body["version"]


def test_create_task(client):
    task = make_task(client)
    assert task["id"] > 0
    assert task["title"] == "Configure ingress"
    assert task["status"] == "TODO"


def test_create_task_rejects_empty_title(client):
    response = client.post("/api/tasks", json={"title": ""})
    assert response.status_code == 422


def test_create_task_rejects_unknown_priority(client):
    response = client.post("/api/tasks", json={"title": "x", "priority": "URGENT"})
    assert response.status_code == 422


def test_list_tasks_newest_first(client):
    first = make_task(client, title="first")
    second = make_task(client, title="second")
    ids = [t["id"] for t in client.get("/api/tasks").json()]
    assert ids == [second["id"], first["id"]]


def test_get_task_and_404(client):
    task = make_task(client)
    assert client.get(f"/api/tasks/{task['id']}").json()["title"] == task["title"]
    assert client.get("/api/tasks/99999").status_code == 404


def test_update_task_status(client):
    task = make_task(client)
    response = client.put(f"/api/tasks/{task['id']}", json={"status": "IN_PROGRESS"})
    assert response.status_code == 200
    assert response.json()["status"] == "IN_PROGRESS"
    assert response.json()["title"] == task["title"]


def test_update_missing_task_returns_404(client):
    assert client.put("/api/tasks/99999", json={"status": "DONE"}).status_code == 404


def test_delete_task(client):
    task = make_task(client)
    assert client.delete(f"/api/tasks/{task['id']}").status_code == 204
    assert client.get(f"/api/tasks/{task['id']}").status_code == 404
    assert client.delete(f"/api/tasks/{task['id']}").status_code == 404


def test_stats_counts_by_status(client):
    make_task(client, status="TODO")
    make_task(client, status="TODO")
    make_task(client, status="IN_PROGRESS")
    make_task(client, status="DONE")
    assert client.get("/api/tasks/stats").json() == {"total": 4, "todo": 2, "inProgress": 1, "done": 1}


def test_metrics_endpoint(client):
    make_task(client, priority="LOW")
    client.get("/api/tasks")
    body = client.get("/metrics").text
    assert "http_requests_total" in body
    assert 'taskboard_tasks_created_total{priority="LOW"}' in body
    assert "taskboard_build_info" in body
