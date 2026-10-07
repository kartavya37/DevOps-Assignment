"""DevSecOps Dashboard: a small Flask app for the Session 17 pipeline.

Adapted from the class demo (session-17-devsecops/demo). Security changes:
- Debug mode is off. The container runs the app with gunicorn.
- The random choices use random.SystemRandom (Bandit B311 does not apply).
- The app sends basic security headers on every response.
- Timestamps are timezone-aware (datetime.utcnow() is deprecated).
"""
import datetime
import os
import platform
import random
import sys

from flask import Flask, jsonify, render_template, request

app = Flask(__name__)

APP_VERSION = os.getenv("APP_VERSION", "2.0.0")
GIT_SHA = os.getenv("GIT_SHA", "local")

_rng = random.SystemRandom()
_request_count = 0
_start_time = datetime.datetime.now(datetime.timezone.utc)


def _now():
    return datetime.datetime.now(datetime.timezone.utc)


def _iso_now():
    return _now().isoformat().replace("+00:00", "Z")


@app.before_request
def _count_request():
    global _request_count
    _request_count += 1


@app.after_request
def _security_headers(response):
    response.headers["X-Content-Type-Options"] = "nosniff"
    response.headers["X-Frame-Options"] = "DENY"
    response.headers["Referrer-Policy"] = "no-referrer"
    return response


# Pages

@app.route("/")
def home():
    return render_template("index.html")


# Health and status API

@app.route("/health")
def health():
    uptime_seconds = (_now() - _start_time).total_seconds()
    return jsonify({
        "status": "healthy",
        "uptime_seconds": round(uptime_seconds, 2),
        "timestamp": _iso_now(),
    })


@app.route("/api/status")
def status():
    uptime = _now() - _start_time
    hours, remainder = divmod(int(uptime.total_seconds()), 3600)
    minutes, seconds = divmod(remainder, 60)
    return jsonify({
        "app": "DevSecOps Dashboard",
        "version": APP_VERSION,
        "git_sha": GIT_SHA,
        "status": "running",
        "python_version": sys.version.split()[0],
        "platform": platform.system(),
        "uptime": f"{hours:02d}h {minutes:02d}m {seconds:02d}s",
        "total_requests": _request_count,
        "timestamp": _iso_now(),
    })


# Greeting API

@app.route("/api/greet/<name>")
def greet(name):
    name = name[:40]
    greetings = [
        f"Hello, {name}!",
        f"Hey {name}, welcome aboard!",
        f"Greetings, {name}! Your pipeline is secure.",
        f"Hi {name}! May your security gates always pass!",
    ]
    return jsonify({
        "message": _rng.choice(greetings),
        "name": name,
        "timestamp": _iso_now(),
    })


# Math API

def _two_numbers(data, first, second):
    """Return (a, b, error). error is None when both values are valid numbers."""
    if not data:
        return None, None, "No JSON body provided"
    a, b = data.get(first), data.get(second)
    if a is None or b is None:
        return None, None, f"Both {first} and {second} are required"
    try:
        return float(a), float(b), None
    except (TypeError, ValueError):
        return None, None, "Values must be numbers"


@app.route("/api/add", methods=["POST"])
def add_numbers():
    n1, n2, error = _two_numbers(request.get_json(silent=True), "number1", "number2")
    if error:
        return jsonify({"error": error}), 400
    return jsonify({"number1": n1, "number2": n2, "operation": "addition", "result": n1 + n2})


@app.route("/api/calculate", methods=["POST"])
def calculate():
    data = request.get_json(silent=True)
    a, b, error = _two_numbers(data, "a", "b")
    if error:
        return jsonify({"error": error}), 400

    op = data.get("operation", "add")
    ops = {
        "add": (lambda: a + b, "+"),
        "subtract": (lambda: a - b, "-"),
        "multiply": (lambda: a * b, "x"),
        "divide": (lambda: a / b if b != 0 else None, "/"),
        "power": (lambda: a ** b if abs(b) <= 100 else None, "^"),
        "modulo": (lambda: a % b if b != 0 else None, "%"),
    }
    if op not in ops:
        return jsonify({"error": f"Unknown operation '{op}'. Valid: {list(ops)}"}), 400

    func, symbol = ops[op]
    result = func()
    if result is None:
        return jsonify({"error": "Invalid operation (division by zero or exponent too large)"}), 400

    result = round(result, 10)
    return jsonify({
        "a": a, "b": b,
        "operation": op,
        "symbol": symbol,
        "result": result,
        "expression": f"{a} {symbol} {b} = {result}",
    })


# Pipeline simulator API

PIPELINE_STAGES = [
    "Build", "Unit Test", "SAST", "SCA", "Secret Scan",
    "Docker Build", "Image Scan", "Security Gate", "Push Image", "Deploy to K8s",
]


@app.route("/api/pipeline/run", methods=["POST"])
def run_pipeline():
    """Simulate one pipeline run. A failed stage skips all later stages."""
    data = request.get_json(silent=True) or {}
    branch = str(data.get("branch", "main"))[:50]
    try:
        fail_chance = min(max(float(data.get("fail_chance", 0.1)), 0.0), 1.0)
    except (TypeError, ValueError):
        return jsonify({"error": "fail_chance must be a number"}), 400

    stages, failed = [], False
    for name in PIPELINE_STAGES:
        if failed:
            state, duration = "skipped", 0
        elif _rng.random() < fail_chance:
            state, duration, failed = "failed", round(_rng.uniform(0.5, 5.0), 2), True
        else:
            state, duration = "passed", round(_rng.uniform(0.5, 15.0), 2)
        stages.append({"name": name, "icon": "", "status": state, "duration_s": duration})

    return jsonify({
        "run_id": f"run-{_rng.randint(1000, 9999)}",
        "branch": branch,
        "overall_status": "failed" if failed else "passed",
        "total_time_s": round(sum(s["duration_s"] for s in stages), 2),
        "stages": stages,
        "triggered_at": _iso_now(),
    })


# Error handlers

@app.errorhandler(404)
def not_found(e):
    return jsonify({"error": "Route not found", "code": 404}), 404


@app.errorhandler(500)
def server_error(e):
    return jsonify({"error": "Internal server error", "code": 500}), 500


if __name__ == "__main__":
    # Local development only: no debug mode, loopback address only.
    app.run(host="127.0.0.1", port=5001)
