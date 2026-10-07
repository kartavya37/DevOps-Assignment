"""Small Flask web API around the calculator.

The Docker image runs this file with gunicorn. Kubernetes uses /health for probes.
"""
import os
import platform

from flask import Flask, jsonify, request

from app.calculator import OPERATIONS, calculate

app = Flask(__name__)

APP_VERSION = os.getenv("APP_VERSION", "dev")
GIT_SHA = os.getenv("GIT_SHA", "local")

PAGE = """<!doctype html>
<html lang="en">
<head><meta charset="utf-8"><title>Session 16 Calculator</title>
<style>
 body {{ font-family: sans-serif; max-width: 640px; margin: 40px auto; padding: 0 16px; }}
 code {{ background: #eef; padding: 2px 4px; }}
 .ok {{ color: #070; font-weight: bold; }}
</style></head>
<body>
<h1>Session 16: CI/CD Calculator</h1>
<p class="ok">Status: running</p>
<p>Version: <code>{version}</code> &middot; Commit: <code>{sha}</code> &middot; Host: <code>{host}</code></p>
<h2>API</h2>
<ul>
 <li><code>GET /health</code></li>
 <li><code>GET /api/calc?op=add&amp;a=10&amp;b=5</code> (ops: {ops})</li>
 <li><code>GET /api/version</code></li>
</ul>
<p>Example: 10 + 5 = <b>{example}</b></p>
</body></html>
"""


@app.route("/")
def home():
    return PAGE.format(
        version=APP_VERSION,
        sha=GIT_SHA[:7],
        host=platform.node(),
        ops=", ".join(sorted(OPERATIONS)),
        example=calculate("add", 10, 5),
    )


@app.route("/health")
def health():
    return jsonify(status="healthy")


@app.route("/api/version")
def version():
    return jsonify(version=APP_VERSION, git_sha=GIT_SHA, python=platform.python_version())


@app.route("/api/calc")
def calc():
    op = request.args.get("op", "add")
    try:
        a = float(request.args.get("a", ""))
        b = float(request.args.get("b", ""))
        result = calculate(op, a, b)
    except ValueError as err:
        return jsonify(error=str(err)), 400
    return jsonify(operation=op, a=a, b=b, result=result)


if __name__ == "__main__":
    # Local development only. The container uses gunicorn.
    app.run(host="127.0.0.1", port=5000)
