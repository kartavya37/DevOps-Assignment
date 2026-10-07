"""Test configuration: the tests use a temporary SQLite database, never PostgreSQL."""
import os
import tempfile

_DB_DIR = tempfile.mkdtemp(prefix="taskboard-test-")
os.environ["DATABASE_URL"] = f"sqlite:///{_DB_DIR}/test.db"
os.environ["AUTO_CREATE_TABLES"] = "true"
os.environ["APP_ENV"] = "test"

import pytest  # noqa: E402
from fastapi.testclient import TestClient  # noqa: E402

from app.db import Base, engine  # noqa: E402
from app.main import app  # noqa: E402


@pytest.fixture()
def client():
    Base.metadata.drop_all(bind=engine)
    Base.metadata.create_all(bind=engine)
    with TestClient(app) as test_client:
        yield test_client
