"""Application settings. Kubernetes gives the values as environment variables
(ConfigMap for normal settings, Secret for the database user and password)."""
from urllib.parse import quote_plus

from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    app_name: str = "TaskBoard API"
    app_version: str = "1.0.0"
    app_env: str = "local"
    log_level: str = "info"

    # Option 1: one full URL (Docker Compose, tests).
    database_url: str | None = None
    # Option 2: separate parts (Kubernetes ConfigMap + Secret).
    db_host: str = "localhost"
    db_port: int = 5432
    db_name: str = "taskboard"
    db_user: str = "taskboard"
    db_password: str = "taskboard"

    # Tests use SQLite and create the tables directly. Containers use Alembic.
    auto_create_tables: bool = False

    model_config = SettingsConfigDict(env_file=".env", extra="ignore")

    @property
    def sqlalchemy_url(self) -> str:
        if self.database_url:
            return self.database_url
        return (
            f"postgresql+psycopg://{quote_plus(self.db_user)}:{quote_plus(self.db_password)}"
            f"@{self.db_host}:{self.db_port}/{self.db_name}"
        )


settings = Settings()
