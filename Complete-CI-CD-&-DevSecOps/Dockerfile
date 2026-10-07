# Session 17: hardened image for the DevSecOps Dashboard.

# Stage 1: install the dependencies into a virtual environment.
FROM python:3.13-alpine AS builder
COPY requirements.txt /tmp/requirements.txt
RUN python -m venv /opt/venv \
 && /opt/venv/bin/pip install --no-cache-dir -r /tmp/requirements.txt \
 && /opt/venv/bin/pip uninstall -y pip

# Stage 2: runtime image. It contains no compiler, no pip and no build files.
FROM python:3.13-alpine

ARG APP_VERSION=2.0.0
ARG GIT_SHA=local
ENV APP_VERSION=${APP_VERSION} \
    GIT_SHA=${GIT_SHA} \
    PATH=/opt/venv/bin:$PATH \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Install the latest OS security fixes (Trivy found a fixed zlib CVE in the base image).
# The application does not need pip at runtime. The libraries that pip vendors had HIGH CVEs (Trivy).
RUN apk upgrade --no-cache \
 && python -m pip uninstall -y pip \
 && rm -rf /usr/local/lib/python3.13/ensurepip \
 && adduser -D -H -u 10001 appuser

COPY --from=builder /opt/venv /opt/venv
WORKDIR /app
COPY app ./app

USER 10001
EXPOSE 5001
HEALTHCHECK --interval=30s --timeout=3s CMD python -c "import urllib.request; urllib.request.urlopen('http://127.0.0.1:5001/health')"
CMD ["gunicorn", "--bind", "0.0.0.0:5001", "--workers", "2", "--worker-tmp-dir", "/tmp", "--no-control-socket", "--access-logfile", "-", "app.app:app"]
