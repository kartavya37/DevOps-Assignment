import pytest

from app.main import app


@pytest.fixture
def client():
    app.config["TESTING"] = True
    with app.test_client() as client:
        yield client


def test_home_page(client):
    response = client.get("/")
    assert response.status_code == 200
    assert b"Session 16" in response.data


def test_health(client):
    response = client.get("/health")
    assert response.status_code == 200
    assert response.get_json() == {"status": "healthy"}


def test_calc_add(client):
    response = client.get("/api/calc?op=add&a=10&b=5")
    assert response.status_code == 200
    assert response.get_json()["result"] == 15


def test_calc_divide_by_zero(client):
    response = client.get("/api/calc?op=divide&a=1&b=0")
    assert response.status_code == 400


def test_calc_bad_number(client):
    response = client.get("/api/calc?op=add&a=x&b=1")
    assert response.status_code == 400


def test_version(client):
    response = client.get("/api/version")
    assert response.status_code == 200
    assert "version" in response.get_json()
