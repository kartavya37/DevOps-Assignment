import pytest

from app.app import app


@pytest.fixture
def client():
    app.config["TESTING"] = True
    with app.test_client() as client:
        yield client


def test_home(client):
    response = client.get("/")
    assert response.status_code == 200
    assert b"DevSecOps" in response.data


def test_health(client):
    response = client.get("/health")
    assert response.status_code == 200
    assert response.get_json()["status"] == "healthy"


def test_security_headers(client):
    response = client.get("/health")
    assert response.headers["X-Content-Type-Options"] == "nosniff"
    assert response.headers["X-Frame-Options"] == "DENY"


def test_greet(client):
    response = client.get("/api/greet/Kartavya")
    assert response.status_code == 200
    assert "Kartavya" in response.get_json()["message"]


def test_add_numbers(client):
    response = client.post("/api/add", json={"number1": 10, "number2": 20})
    assert response.status_code == 200
    assert response.get_json()["result"] == 30


def test_add_numbers_missing_fields(client):
    response = client.post("/api/add", json={"number1": 5})
    assert response.status_code == 400


def test_add_numbers_no_body(client):
    response = client.post("/api/add", data="not json")
    assert response.status_code == 400


def test_calculator_multiply(client):
    response = client.post("/api/calculate", json={"a": 4, "b": 5, "operation": "multiply"})
    assert response.status_code == 200
    assert response.get_json()["result"] == 20


def test_calculator_divide_by_zero(client):
    response = client.post("/api/calculate", json={"a": 10, "b": 0, "operation": "divide"})
    assert response.status_code == 400


def test_calculator_unknown_operation(client):
    response = client.post("/api/calculate", json={"a": 1, "b": 2, "operation": "sqrt"})
    assert response.status_code == 400


def test_calculator_power_limit(client):
    response = client.post("/api/calculate", json={"a": 2, "b": 1000, "operation": "power"})
    assert response.status_code == 400


def test_status(client):
    data = client.get("/api/status").get_json()
    assert data["status"] == "running"
    assert "python_version" in data
    assert "git_sha" in data


def test_pipeline_run_all_pass(client):
    data = client.post("/api/pipeline/run", json={"branch": "main", "fail_chance": 0}).get_json()
    assert data["overall_status"] == "passed"
    assert len(data["stages"]) == 10


def test_pipeline_run_all_fail(client):
    data = client.post("/api/pipeline/run", json={"fail_chance": 1}).get_json()
    assert data["overall_status"] == "failed"
    assert data["stages"][0]["status"] == "failed"
    assert data["stages"][-1]["status"] == "skipped"


def test_not_found(client):
    assert client.get("/missing").status_code == 404
