from logging.config import fileConfig

from alembic import context
from sqlalchemy import create_engine, pool, text

from app import models  # noqa: F401  (registers the tables on Base.metadata)
from app.config import settings
from app.db import Base

config = context.config
if config.config_file_name:
    fileConfig(config.config_file_name)
target_metadata = Base.metadata
DB_URL = settings.sqlalchemy_url
# Two backend Pods can start at the same time. A PostgreSQL advisory lock makes
# sure that only one Pod runs the migrations. The other Pod waits.
MIGRATION_LOCK_ID = 210021


def run_migrations_offline():
    context.configure(url=DB_URL, target_metadata=target_metadata, literal_binds=True,
                      dialect_opts={"paramstyle": "named"})
    with context.begin_transaction():
        context.run_migrations()


def run_migrations_online():
    connectable = create_engine(DB_URL, poolclass=pool.NullPool)
    with connectable.connect() as connection:
        is_postgres = connection.dialect.name == "postgresql"
        if is_postgres:
            connection.execute(text(f"SELECT pg_advisory_lock({MIGRATION_LOCK_ID})"))
            connection.commit()
        try:
            context.configure(connection=connection, target_metadata=target_metadata)
            with context.begin_transaction():
                context.run_migrations()
        finally:
            if is_postgres:
                connection.execute(text(f"SELECT pg_advisory_unlock({MIGRATION_LOCK_ID})"))
                connection.commit()


if context.is_offline_mode():
    run_migrations_offline()
else:
    run_migrations_online()
