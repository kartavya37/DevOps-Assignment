time="2026-10-07T19:30:13+05:30" level=info msg="Using docker host 'unix:///var/run/docker.sock', and daemon socket 'unix:///var/run/docker.sock'"
time="2026-10-07T19:30:13+05:30" level=info msg="Start server on http://0.0.0.0:18791"
[S21 Final Project Pipeline/1. Build & Test] ⭐ Run Set up job
[S21 Final Project Pipeline/1. Build & Test] 🚀  Start image=catthehacker/ubuntu:act-latest
[S21 Final Project Pipeline/1. Build & Test]   🐳  docker pull image=catthehacker/ubuntu:act-latest platform=linux/arm64 username= forcePull=false
[S21 Final Project Pipeline/1. Build & Test]   🐳  docker create image=catthehacker/ubuntu:act-latest platform=linux/arm64 entrypoint=["tail" "-f" "/dev/null"] cmd=[] network="host"
[S21 Final Project Pipeline/1. Build & Test]   🐳  docker run image=catthehacker/ubuntu:act-latest platform=linux/arm64 entrypoint=["tail" "-f" "/dev/null"] cmd=[] network="host"
[S21 Final Project Pipeline/1. Build & Test]   🐳  docker exec cmd=[node --no-warnings -e console.log(process.execPath)] user= workdir=
[S21 Final Project Pipeline/1. Build & Test]   ✅  Success - Set up job
[S21 Final Project Pipeline/1. Build & Test]   ☁  git clone 'https://github.com/actions/setup-python' # ref=v7
[S21 Final Project Pipeline/1. Build & Test]   ☁  git clone 'https://github.com/actions/setup-node' # ref=v7
[S21 Final Project Pipeline/1. Build & Test]   ☁  git clone 'https://github.com/actions/upload-artifact' # ref=v4
[S21 Final Project Pipeline/1. Build & Test] ⭐ Run Main Checkout source code
[S21 Final Project Pipeline/1. Build & Test]   🐳  docker cp src=/Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment/. dst=/Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment
[S21 Final Project Pipeline/1. Build & Test]   ✅  Success - Main Checkout source code [1.182992625s]
[S21 Final Project Pipeline/1. Build & Test] ⭐ Run Main Set up Python
[S21 Final Project Pipeline/1. Build & Test]   🐳  docker cp src=/Users/kp/.cache/act/actions-setup-python@v7/ dst=/var/run/act/actions/actions-setup-python@v7/
[S21 Final Project Pipeline/1. Build & Test]   🐳  docker exec cmd=[/opt/acttoolcache/node/24.19.0/arm64/bin/node /var/run/act/actions/actions-setup-python@v7/dist/setup/index.js] user= workdir=
[S21 Final Project Pipeline/1. Build & Test]   ❓  ::group::Installed versions
[S21 Final Project Pipeline/1. Build & Test]   | Successfully set up CPython (3.13.16)
[S21 Final Project Pipeline/1. Build & Test]   ❓  ::endgroup::
[S21 Final Project Pipeline/1. Build & Test]   ❓ add-matcher /run/act/actions/actions-setup-python@v7/.github/python.json
[S21 Final Project Pipeline/1. Build & Test]   ✅  Success - Main Set up Python [984.96ms]
[S21 Final Project Pipeline/1. Build & Test]   ⚙  ::set-env:: pythonLocation=/opt/hostedtoolcache/Python/3.13.16/arm64
[S21 Final Project Pipeline/1. Build & Test]   ⚙  ::set-env:: PKG_CONFIG_PATH=/opt/hostedtoolcache/Python/3.13.16/arm64/lib/pkgconfig
[S21 Final Project Pipeline/1. Build & Test]   ⚙  ::set-env:: Python_ROOT_DIR=/opt/hostedtoolcache/Python/3.13.16/arm64
[S21 Final Project Pipeline/1. Build & Test]   ⚙  ::set-env:: Python2_ROOT_DIR=/opt/hostedtoolcache/Python/3.13.16/arm64
[S21 Final Project Pipeline/1. Build & Test]   ⚙  ::set-env:: Python3_ROOT_DIR=/opt/hostedtoolcache/Python/3.13.16/arm64
[S21 Final Project Pipeline/1. Build & Test]   ⚙  ::set-env:: LD_LIBRARY_PATH=/opt/hostedtoolcache/Python/3.13.16/arm64/lib
[S21 Final Project Pipeline/1. Build & Test]   ⚙  ::set-output:: python-version=3.13.16
[S21 Final Project Pipeline/1. Build & Test]   ⚙  ::set-output:: python-path=/opt/hostedtoolcache/Python/3.13.16/arm64/bin/python
[S21 Final Project Pipeline/1. Build & Test]   ⚙  ::add-path:: /opt/hostedtoolcache/Python/3.13.16/arm64
[S21 Final Project Pipeline/1. Build & Test]   ⚙  ::add-path:: /opt/hostedtoolcache/Python/3.13.16/arm64/bin
[S21 Final Project Pipeline/1. Build & Test] ⭐ Run Main Install backend dependencies
[S21 Final Project Pipeline/1. Build & Test]   🐳  docker exec cmd=[bash --noprofile --norc -e -o pipefail /var/run/act/workflow/2.sh] user= workdir=Final-DevOps-Project-&-Troubleshooting/application/backend
[S21 Final Project Pipeline/1. Build & Test]   | Requirement already satisfied: fastapi==0.142.2 in /opt/hostedtoolcache/Python/3.13.16/arm64/lib/python3.13/site-packages (from -r /Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment/Final-DevOps-Project-&-Troubleshooting/application/backend/requirements.txt (line 2)) (0.142.2)
[S21 Final Project Pipeline/1. Build & Test]   | Requirement already satisfied: uvicorn==0.54.0 in /opt/hostedtoolcache/Python/3.13.16/arm64/lib/python3.13/site-packages (from uvicorn[standard]==0.54.0->-r /Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment/Final-DevOps-Project-&-Troubleshooting/application/backend/requirements.txt (line 3)) (0.54.0)
[S21 Final Project Pipeline/1. Build & Test]   | Requirement already satisfied: sqlalchemy==2.1.3 in /opt/hostedtoolcache/Python/3.13.16/arm64/lib/python3.13/site-packages (from -r /Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment/Final-DevOps-Project-&-Troubleshooting/application/backend/requirements.txt (line 4)) (2.1.3)
[S21 Final Project Pipeline/1. Build & Test]   | Requirement already satisfied: psycopg==3.3.6 in /opt/hostedtoolcache/Python/3.13.16/arm64/lib/python3.13/site-packages (from psycopg[binary]==3.3.6->-r /Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment/Final-DevOps-Project-&-Troubleshooting/application/backend/requirements.txt (line 5)) (3.3.6)
[S21 Final Project Pipeline/1. Build & Test]   | Requirement already satisfied: pydantic-settings==2.15.0 in /opt/hostedtoolcache/Python/3.13.16/arm64/lib/python3.13/site-packages (from -r /Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment/Final-DevOps-Project-&-Troubleshooting/application/backend/requirements.txt (line 6)) (2.15.0)
[S21 Final Project Pipeline/1. Build & Test]   | Requirement already satisfied: prometheus-fastapi-instrumentator==8.1.0 in /opt/hostedtoolcache/Python/3.13.16/arm64/lib/python3.13/site-packages (from -r /Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment/Final-DevOps-Project-&-Troubleshooting/application/backend/requirements.txt (line 7)) (8.1.0)
[S21 Final Project Pipeline/1. Build & Test]   | Requirement already satisfied: prometheus-client==0.26.0 in /opt/hostedtoolcache/Python/3.13.16/arm64/lib/python3.13/site-packages (from -r /Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment/Final-DevOps-Project-&-Troubleshooting/application/backend/requirements.txt (line 8)) (0.26.0)
[S21 Final Project Pipeline/1. Build & Test]   | Requirement already satisfied: alembic==1.20.0 in /opt/hostedtoolcache/Python/3.13.16/arm64/lib/python3.13/site-packages (from -r /Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment/Final-DevOps-Project-&-Troubleshooting/application/backend/requirements.txt (line 9)) (1.20.0)
[S21 Final Project Pipeline/1. Build & Test]   | Requirement already satisfied: pytest==9.1.1 in /opt/hostedtoolcache/Python/3.13.16/arm64/lib/python3.13/site-packages (from -r requirements-dev.txt (line 3)) (9.1.1)
[S21 Final Project Pipeline/1. Build & Test]   | Requirement already satisfied: pytest-cov==7.1.0 in /opt/hostedtoolcache/Python/3.13.16/arm64/lib/python3.13/site-packages (from -r requirements-dev.txt (line 4)) (7.1.0)
[S21 Final Project Pipeline/1. Build & Test]   | Requirement already satisfied: httpx2==2.13.1 in /opt/hostedtoolcache/Python/3.13.16/arm64/lib/python3.13/site-packages (from -r requirements-dev.txt (line 5)) (2.13.1)
[S21 Final Project Pipeline/1. Build & Test]   | Requirement already satisfied: starlette>=0.46.0 in /opt/hostedtoolcache/Python/3.13.16/arm64/lib/python3.13/site-packages (from fastapi==0.142.2->-r /Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment/Final-DevOps-Project-&-Troubleshooting/application/backend/requirements.txt (line 2)) (1.7.0)
[S21 Final Project Pipeline/1. Build & Test]   | Requirement already satisfied: pydantic>=2.9.0 in /opt/hostedtoolcache/Python/3.13.16/arm64/lib/python3.13/site-packages (from fastapi==0.142.2->-r /Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment/Final-DevOps-Project-&-Troubleshooting/application/backend/requirements.txt (line 2)) (2.13.5)
[S21 Final Project Pipeline/1. Build & Test]   | Requirement already satisfied: typing-extensions>=4.8.0 in /opt/hostedtoolcache/Python/3.13.16/arm64/lib/python3.13/site-packages (from fastapi==0.142.2->-r /Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment/Final-DevOps-Project-&-Troubleshooting/application/backend/requirements.txt (line 2)) (4.16.0)
[S21 Final Project Pipeline/1. Build & Test]   | Requirement already satisfied: typing-inspection>=0.4.2 in /opt/hostedtoolcache/Python/3.13.16/arm64/lib/python3.13/site-packages (from fastapi==0.142.2->-r /Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment/Final-DevOps-Project-&-Troubleshooting/application/backend/requirements.txt (line 2)) (0.4.4)
[S21 Final Project Pipeline/1. Build & Test]   | Requirement already satisfied: annotated-doc>=0.0.2 in /opt/hostedtoolcache/Python/3.13.16/arm64/lib/python3.13/site-packages (from fastapi==0.142.2->-r /Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment/Final-DevOps-Project-&-Troubleshooting/application/backend/requirements.txt (line 2)) (0.0.5)
[S21 Final Project Pipeline/1. Build & Test]   | Requirement already satisfied: opentelemetry-api>=1.44.0 in /opt/hostedtoolcache/Python/3.13.16/arm64/lib/python3.13/site-packages (from fastapi==0.142.2->-r /Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment/Final-DevOps-Project-&-Troubleshooting/application/backend/requirements.txt (line 2)) (1.45.1)
[S21 Final Project Pipeline/1. Build & Test]   | Requirement already satisfied: click>=7.0 in /opt/hostedtoolcache/Python/3.13.16/arm64/lib/python3.13/site-packages (from uvicorn==0.54.0->uvicorn[standard]==0.54.0->-r /Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment/Final-DevOps-Project-&-Troubleshooting/application/backend/requirements.txt (line 3)) (8.5.0)
[S21 Final Project Pipeline/1. Build & Test]   | Requirement already satisfied: h11>=0.8 in /opt/hostedtoolcache/Python/3.13.16/arm64/lib/python3.13/site-packages (from uvicorn==0.54.0->uvicorn[standard]==0.54.0->-r /Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment/Final-DevOps-Project-&-Troubleshooting/application/backend/requirements.txt (line 3)) (0.16.0)
[S21 Final Project Pipeline/1. Build & Test]   | Requirement already satisfied: python-dotenv>=0.21.0 in /opt/hostedtoolcache/Python/3.13.16/arm64/lib/python3.13/site-packages (from pydantic-settings==2.15.0->-r /Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment/Final-DevOps-Project-&-Troubleshooting/application/backend/requirements.txt (line 6)) (1.2.4)
[S21 Final Project Pipeline/1. Build & Test]   | Requirement already satisfied: Mako in /opt/hostedtoolcache/Python/3.13.16/arm64/lib/python3.13/site-packages (from alembic==1.20.0->-r /Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment/Final-DevOps-Project-&-Troubleshooting/application/backend/requirements.txt (line 9)) (1.4.3)
[S21 Final Project Pipeline/1. Build & Test]   | Requirement already satisfied: iniconfig>=1.0.1 in /opt/hostedtoolcache/Python/3.13.16/arm64/lib/python3.13/site-packages (from pytest==9.1.1->-r requirements-dev.txt (line 3)) (2.3.1)
[S21 Final Project Pipeline/1. Build & Test]   | Requirement already satisfied: packaging>=22 in /opt/hostedtoolcache/Python/3.13.16/arm64/lib/python3.13/site-packages (from pytest==9.1.1->-r requirements-dev.txt (line 3)) (26.3)
[S21 Final Project Pipeline/1. Build & Test]   | Requirement already satisfied: pluggy<2,>=1.5 in /opt/hostedtoolcache/Python/3.13.16/arm64/lib/python3.13/site-packages (from pytest==9.1.1->-r requirements-dev.txt (line 3)) (1.6.0)
[S21 Final Project Pipeline/1. Build & Test]   | Requirement already satisfied: pygments>=2.7.2 in /opt/hostedtoolcache/Python/3.13.16/arm64/lib/python3.13/site-packages (from pytest==9.1.1->-r requirements-dev.txt (line 3)) (2.21.0)
[S21 Final Project Pipeline/1. Build & Test]   | Requirement already satisfied: coverage>=7.10.6 in /opt/hostedtoolcache/Python/3.13.16/arm64/lib/python3.13/site-packages (from coverage[toml]>=7.10.6->pytest-cov==7.1.0->-r requirements-dev.txt (line 4)) (7.16.2)
[S21 Final Project Pipeline/1. Build & Test]   | Requirement already satisfied: anyio>=4.10 in /opt/hostedtoolcache/Python/3.13.16/arm64/lib/python3.13/site-packages (from httpx2==2.13.1->-r requirements-dev.txt (line 5)) (4.15.1)
[S21 Final Project Pipeline/1. Build & Test]   | Requirement already satisfied: httpcore2==2.13.1 in /opt/hostedtoolcache/Python/3.13.16/arm64/lib/python3.13/site-packages (from httpx2==2.13.1->-r requirements-dev.txt (line 5)) (2.13.1)
[S21 Final Project Pipeline/1. Build & Test]   | Requirement already satisfied: idna>=3.18 in /opt/hostedtoolcache/Python/3.13.16/arm64/lib/python3.13/site-packages (from httpx2==2.13.1->-r requirements-dev.txt (line 5)) (3.20)
[S21 Final Project Pipeline/1. Build & Test]   | Requirement already satisfied: truststore>=0.10 in /opt/hostedtoolcache/Python/3.13.16/arm64/lib/python3.13/site-packages (from httpx2==2.13.1->-r requirements-dev.txt (line 5)) (0.10.4)
[S21 Final Project Pipeline/1. Build & Test]   | Requirement already satisfied: psycopg-binary==3.3.6 in /opt/hostedtoolcache/Python/3.13.16/arm64/lib/python3.13/site-packages (from psycopg[binary]==3.3.6->-r /Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment/Final-DevOps-Project-&-Troubleshooting/application/backend/requirements.txt (line 5)) (3.3.6)
[S21 Final Project Pipeline/1. Build & Test]   | Requirement already satisfied: httptools>=0.8.0 in /opt/hostedtoolcache/Python/3.13.16/arm64/lib/python3.13/site-packages (from uvicorn[standard]==0.54.0->-r /Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment/Final-DevOps-Project-&-Troubleshooting/application/backend/requirements.txt (line 3)) (0.8.0)
[S21 Final Project Pipeline/1. Build & Test]   | Requirement already satisfied: pyyaml>=5.1 in /opt/hostedtoolcache/Python/3.13.16/arm64/lib/python3.13/site-packages (from uvicorn[standard]==0.54.0->-r /Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment/Final-DevOps-Project-&-Troubleshooting/application/backend/requirements.txt (line 3)) (6.0.3)
[S21 Final Project Pipeline/1. Build & Test]   | Requirement already satisfied: uvloop>=0.15.1 in /opt/hostedtoolcache/Python/3.13.16/arm64/lib/python3.13/site-packages (from uvicorn[standard]==0.54.0->-r /Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment/Final-DevOps-Project-&-Troubleshooting/application/backend/requirements.txt (line 3)) (0.23.0)
[S21 Final Project Pipeline/1. Build & Test]   | Requirement already satisfied: watchfiles>=0.20 in /opt/hostedtoolcache/Python/3.13.16/arm64/lib/python3.13/site-packages (from uvicorn[standard]==0.54.0->-r /Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment/Final-DevOps-Project-&-Troubleshooting/application/backend/requirements.txt (line 3)) (1.3.0)
[S21 Final Project Pipeline/1. Build & Test]   | Requirement already satisfied: websockets>=13.0 in /opt/hostedtoolcache/Python/3.13.16/arm64/lib/python3.13/site-packages (from uvicorn[standard]==0.54.0->-r /Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment/Final-DevOps-Project-&-Troubleshooting/application/backend/requirements.txt (line 3)) (17.2)
[S21 Final Project Pipeline/1. Build & Test]   | Requirement already satisfied: annotated-types>=0.6.0 in /opt/hostedtoolcache/Python/3.13.16/arm64/lib/python3.13/site-packages (from pydantic>=2.9.0->fastapi==0.142.2->-r /Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment/Final-DevOps-Project-&-Troubleshooting/application/backend/requirements.txt (line 2)) (0.8.0)
[S21 Final Project Pipeline/1. Build & Test]   | Requirement already satisfied: pydantic-core==2.46.5 in /opt/hostedtoolcache/Python/3.13.16/arm64/lib/python3.13/site-packages (from pydantic>=2.9.0->fastapi==0.142.2->-r /Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment/Final-DevOps-Project-&-Troubleshooting/application/backend/requirements.txt (line 2)) (2.46.5)
[S21 Final Project Pipeline/1. Build & Test]   | Requirement already satisfied: MarkupSafe>=2.0 in /opt/hostedtoolcache/Python/3.13.16/arm64/lib/python3.13/site-packages (from Mako->alembic==1.20.0->-r /Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment/Final-DevOps-Project-&-Troubleshooting/application/backend/requirements.txt (line 9)) (3.0.4)
[S21 Final Project Pipeline/1. Build & Test]   | WARNING: Running pip as the 'root' user can result in broken permissions and conflicting behaviour with the system package manager, possibly rendering your system unusable. It is recommended to use a virtual environment instead: https://pip.pypa.io/warnings/venv. Use the --root-user-action option if you know what you are doing and want to suppress this warning.
[S21 Final Project Pipeline/1. Build & Test]   ✅  Success - Main Install backend dependencies [784.431417ms]
[S21 Final Project Pipeline/1. Build & Test] ⭐ Run Main Run backend tests (coverage must be 80% or more)
[S21 Final Project Pipeline/1. Build & Test]   🐳  docker exec cmd=[bash --noprofile --norc -e -o pipefail /var/run/act/workflow/3.sh] user= workdir=Final-DevOps-Project-&-Troubleshooting/application/backend
[S21 Final Project Pipeline/1. Build & Test]   | ============================= test session starts ==============================
[S21 Final Project Pipeline/1. Build & Test]   | platform linux -- Python 3.13.16, pytest-9.1.1, pluggy-1.6.0 -- /opt/hostedtoolcache/Python/3.13.16/arm64/bin/python
[S21 Final Project Pipeline/1. Build & Test]   | rootdir: /Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment/Final-DevOps-Project-&-Troubleshooting/application/backend
[S21 Final Project Pipeline/1. Build & Test]   | configfile: pytest.ini
[S21 Final Project Pipeline/1. Build & Test]   | testpaths: tests
[S21 Final Project Pipeline/1. Build & Test]   | plugins: platformdirs-4.12.3, anyio-4.15.1, cov-7.1.0
[S21 Final Project Pipeline/1. Build & Test]   | collecting ... collected 14 items
[S21 Final Project Pipeline/1. Build & Test]   | 
[S21 Final Project Pipeline/1. Build & Test]   | tests/test_api.py::test_health PASSED                                    [  7%]
[S21 Final Project Pipeline/1. Build & Test]   | tests/test_api.py::test_ready_checks_database PASSED                     [ 14%]
[S21 Final Project Pipeline/1. Build & Test]   | tests/test_api.py::test_root_shows_service_and_version PASSED            [ 21%]
[S21 Final Project Pipeline/1. Build & Test]   | tests/test_api.py::test_info_for_frontend PASSED                         [ 28%]
[S21 Final Project Pipeline/1. Build & Test]   | tests/test_api.py::test_create_task PASSED                               [ 35%]
[S21 Final Project Pipeline/1. Build & Test]   | tests/test_api.py::test_create_task_rejects_empty_title PASSED           [ 42%]
[S21 Final Project Pipeline/1. Build & Test]   | tests/test_api.py::test_create_task_rejects_unknown_priority PASSED      [ 50%]
[S21 Final Project Pipeline/1. Build & Test]   | tests/test_api.py::test_list_tasks_newest_first PASSED                   [ 57%]
[S21 Final Project Pipeline/1. Build & Test]   | tests/test_api.py::test_get_task_and_404 PASSED                          [ 64%]
[S21 Final Project Pipeline/1. Build & Test]   | tests/test_api.py::test_update_task_status PASSED                        [ 71%]
[S21 Final Project Pipeline/1. Build & Test]   | tests/test_api.py::test_update_missing_task_returns_404 PASSED           [ 78%]
[S21 Final Project Pipeline/1. Build & Test]   | tests/test_api.py::test_delete_task PASSED                               [ 85%]
[S21 Final Project Pipeline/1. Build & Test]   | tests/test_api.py::test_stats_counts_by_status PASSED                    [ 92%]
[S21 Final Project Pipeline/1. Build & Test]   | tests/test_api.py::test_metrics_endpoint PASSED                          [100%]
[S21 Final Project Pipeline/1. Build & Test]   | 
[S21 Final Project Pipeline/1. Build & Test]   | - generated xml file: /Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment/Final-DevOps-Project-&-Troubleshooting/reports/junit.xml -
[S21 Final Project Pipeline/1. Build & Test]   | ================================ tests coverage ================================
[S21 Final Project Pipeline/1. Build & Test]   | _______________ coverage: platform linux, python 3.13.16-final-0 _______________
[S21 Final Project Pipeline/1. Build & Test]   | 
[S21 Final Project Pipeline/1. Build & Test]   | Name              Stmts   Miss  Cover   Missing
[S21 Final Project Pipeline/1. Build & Test]   | -----------------------------------------------
[S21 Final Project Pipeline/1. Build & Test]   | app/__init__.py       0      0   100%
[S21 Final Project Pipeline/1. Build & Test]   | app/config.py        21      1    95%   32
[S21 Final Project Pipeline/1. Build & Test]   | app/db.py            12      0   100%
[S21 Final Project Pipeline/1. Build & Test]   | app/main.py          90      4    96%   75-78
[S21 Final Project Pipeline/1. Build & Test]   | app/models.py        13      0   100%
[S21 Final Project Pipeline/1. Build & Test]   | app/schemas.py       26      0   100%
[S21 Final Project Pipeline/1. Build & Test]   | -----------------------------------------------
[S21 Final Project Pipeline/1. Build & Test]   | TOTAL               162      5    97%
[S21 Final Project Pipeline/1. Build & Test]   | Coverage XML written to file ../../reports/coverage.xml
[S21 Final Project Pipeline/1. Build & Test]   | Required test coverage of 80% reached. Total coverage: 96.91%
[S21 Final Project Pipeline/1. Build & Test]   | ============================== 14 passed in 0.24s ==============================
[S21 Final Project Pipeline/1. Build & Test]   ✅  Success - Main Run backend tests (coverage must be 80% or more) [1.085929666s]
[S21 Final Project Pipeline/1. Build & Test] ⭐ Run Main Set up Node.js
[S21 Final Project Pipeline/1. Build & Test]   🐳  docker cp src=/Users/kp/.cache/act/actions-setup-node@v7/ dst=/var/run/act/actions/actions-setup-node@v7/
[S21 Final Project Pipeline/1. Build & Test]   🐳  docker exec cmd=[/opt/acttoolcache/node/24.19.0/arm64/bin/node /var/run/act/actions/actions-setup-node@v7/dist/setup/index.js] user= workdir=
[S21 Final Project Pipeline/1. Build & Test]   | Found in cache @ /opt/hostedtoolcache/node/22.23.3/arm64
[S21 Final Project Pipeline/1. Build & Test]   ❓  ::group::Environment details
[S21 Final Project Pipeline/1. Build & Test]   | node: v22.23.3
[S21 Final Project Pipeline/1. Build & Test]   | npm: 10.9.9
[S21 Final Project Pipeline/1. Build & Test]   | yarn: 
[S21 Final Project Pipeline/1. Build & Test]   ❓  ::endgroup::
[S21 Final Project Pipeline/1. Build & Test]   ❓ add-matcher /run/act/actions/actions-setup-node@v7/.github/tsc.json
[S21 Final Project Pipeline/1. Build & Test]   ❓ add-matcher /run/act/actions/actions-setup-node@v7/.github/eslint-stylish.json
[S21 Final Project Pipeline/1. Build & Test]   ❓ add-matcher /run/act/actions/actions-setup-node@v7/.github/eslint-compact.json
[S21 Final Project Pipeline/1. Build & Test]   ✅  Success - Main Set up Node.js [1.377691458s]
[S21 Final Project Pipeline/1. Build & Test]   ⚙  ::set-output:: node-version=v22.23.3
[S21 Final Project Pipeline/1. Build & Test]   ⚙  ::add-path:: /opt/hostedtoolcache/node/22.23.3/arm64/bin
[S21 Final Project Pipeline/1. Build & Test] ⭐ Run Main Build the frontend
[S21 Final Project Pipeline/1. Build & Test]   🐳  docker exec cmd=[bash --noprofile --norc -e -o pipefail /var/run/act/workflow/5.sh] user= workdir=Final-DevOps-Project-&-Troubleshooting/application/frontend
[S21 Final Project Pipeline/1. Build & Test]   | 
[S21 Final Project Pipeline/1. Build & Test]   | added 19 packages in 5s
[S21 Final Project Pipeline/1. Build & Test]   | 
[S21 Final Project Pipeline/1. Build & Test]   | > taskboard-frontend@1.0.0 build
[S21 Final Project Pipeline/1. Build & Test]   | > vite build
[S21 Final Project Pipeline/1. Build & Test]   | 
[S21 Final Project Pipeline/1. Build & Test]   | vite v8.3.3 building client environment for production...
[S21 Final Project Pipeline/1. Build & Test]   | transforming...
[S21 Final Project Pipeline/1. Build & Test]   | ✓ 15 modules transformed.
[S21 Final Project Pipeline/1. Build & Test]   | rendering chunks...
[S21 Final Project Pipeline/1. Build & Test]   | computing gzip size...
[S21 Final Project Pipeline/1. Build & Test]   | dist/index.html                   0.34 kB │ gzip:  0.25 kB
[S21 Final Project Pipeline/1. Build & Test]   | dist/assets/index-BjDi7pN7.css    6.49 kB │ gzip:  2.07 kB
[S21 Final Project Pipeline/1. Build & Test]   | dist/assets/index-wMtEPqM-.js   227.50 kB │ gzip: 70.94 kB
[S21 Final Project Pipeline/1. Build & Test]   | 
[S21 Final Project Pipeline/1. Build & Test]   | ✓ built in 141ms
[S21 Final Project Pipeline/1. Build & Test]   | dist:
[S21 Final Project Pipeline/1. Build & Test]   | total 8
[S21 Final Project Pipeline/1. Build & Test]   | drwxr-xr-x 2 root root 4096 Oct  7 14:00 assets
[S21 Final Project Pipeline/1. Build & Test]   | -rw-r--r-- 1 root root  343 Oct  7 14:00 index.html
[S21 Final Project Pipeline/1. Build & Test]   | 
[S21 Final Project Pipeline/1. Build & Test]   | dist/assets:
[S21 Final Project Pipeline/1. Build & Test]   | total 232
[S21 Final Project Pipeline/1. Build & Test]   | -rw-r--r-- 1 root root   6494 Oct  7 14:00 index-BjDi7pN7.css
[S21 Final Project Pipeline/1. Build & Test]   | -rw-r--r-- 1 root root 227505 Oct  7 14:00 index-wMtEPqM-.js
[S21 Final Project Pipeline/1. Build & Test]   ✅  Success - Main Build the frontend [5.312852s]
[S21 Final Project Pipeline/1. Build & Test] ⭐ Run Main Upload test report
[S21 Final Project Pipeline/1. Build & Test]   🐳  docker cp src=/Users/kp/.cache/act/actions-upload-artifact@v4/ dst=/var/run/act/actions/actions-upload-artifact@v4/
[S21 Final Project Pipeline/1. Build & Test]   🐳  docker exec cmd=[/opt/acttoolcache/node/24.19.0/arm64/bin/node /var/run/act/actions/actions-upload-artifact@v4/dist/upload/index.js] user= workdir=
[S21 Final Project Pipeline/1. Build & Test]   | (node:216) [DEP0040] DeprecationWarning: The `punycode` module is deprecated. Please use a userland alternative instead.
[S21 Final Project Pipeline/1. Build & Test]   | (Use `node --trace-deprecation ...` to show where the warning was created)
[S21 Final Project Pipeline/1. Build & Test]   | With the provided path, there will be 2 files uploaded
[S21 Final Project Pipeline/1. Build & Test]   | Artifact name is valid!
[S21 Final Project Pipeline/1. Build & Test]   | Root directory input is valid!
[S21 Final Project Pipeline/1. Build & Test]   | Beginning upload of artifact content to blob storage
[S21 Final Project Pipeline/1. Build & Test]   | (node:216) [DEP0169] DeprecationWarning: `url.parse()` behavior is not standardized and prone to errors that have security implications. Use the WHATWG URL API instead. CVEs are not issued for `url.parse()` vulnerabilities.
[S21 Final Project Pipeline/1. Build & Test]   | Uploaded bytes 1583
[S21 Final Project Pipeline/1. Build & Test]   | Finished uploading artifact content to blob storage!
[S21 Final Project Pipeline/1. Build & Test]   | SHA256 digest of uploaded artifact zip is 368b7f030c7344d80281456c6ff18067e1bcda78fc985c00d6208a7aa48e93f4
[S21 Final Project Pipeline/1. Build & Test]   | Finalizing artifact upload
[S21 Final Project Pipeline/1. Build & Test]   | Artifact test-results.zip successfully finalized. Artifact ID 3486992502
[S21 Final Project Pipeline/1. Build & Test]   | Artifact test-results has been successfully uploaded! Final size is 1583 bytes. Artifact ID is 3486992502
[S21 Final Project Pipeline/1. Build & Test]   | Artifact download URL: https://github.com/kartavya37/DevOps-Assignment/actions/runs/1/artifacts/3486992502
[S21 Final Project Pipeline/1. Build & Test]   ✅  Success - Main Upload test report [745.791583ms]
[S21 Final Project Pipeline/1. Build & Test]   ⚙  ::set-output:: artifact-url=https://github.com/kartavya37/DevOps-Assignment/actions/runs/1/artifacts/3486992502
[S21 Final Project Pipeline/1. Build & Test]   ⚙  ::set-output:: artifact-id=3486992502
[S21 Final Project Pipeline/1. Build & Test]   ⚙  ::set-output:: artifact-digest=368b7f030c7344d80281456c6ff18067e1bcda78fc985c00d6208a7aa48e93f4
[S21 Final Project Pipeline/1. Build & Test] ⭐ Run Post Set up Node.js
[S21 Final Project Pipeline/1. Build & Test]   🐳  docker exec cmd=[/opt/acttoolcache/node/24.19.0/arm64/bin/node /var/run/act/actions/actions-setup-node@v7/dist/cache-save/index.js] user= workdir=
[S21 Final Project Pipeline/1. Build & Test]   ✅  Success - Post Set up Node.js [91.018583ms]
[S21 Final Project Pipeline/1. Build & Test] ⭐ Run Post Set up Python
[S21 Final Project Pipeline/1. Build & Test]   🐳  docker exec cmd=[/opt/acttoolcache/node/24.19.0/arm64/bin/node /var/run/act/actions/actions-setup-python@v7/dist/cache-save/index.js] user= workdir=
[S21 Final Project Pipeline/1. Build & Test]   ✅  Success - Post Set up Python [104.334208ms]
[S21 Final Project Pipeline/1. Build & Test] ⭐ Run Complete job
[S21 Final Project Pipeline/1. Build & Test] Cleaning up container for job 1. Build & Test
[S21 Final Project Pipeline/1. Build & Test]   ✅  Success - Complete job
[S21 Final Project Pipeline/1. Build & Test] 🏁  Job succeeded
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)] ⭐ Run Set up job
[S21 Final Project Pipeline/6. Docker Build                        ] ⭐ Run Set up job
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ] ⭐ Run Set up job
[S21 Final Project Pipeline/6. Docker Build                        ] 🚀  Start image=catthehacker/ubuntu:act-latest
[S21 Final Project Pipeline/5. Secret Scan (Gitleaks)              ] ⭐ Run Set up job
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ] 🚀  Start image=catthehacker/ubuntu:act-latest
[S21 Final Project Pipeline/5. Secret Scan (Gitleaks)              ] 🚀  Start image=catthehacker/ubuntu:act-latest
[S21 Final Project Pipeline/2. SAST (Bandit)                       ] ⭐ Run Set up job
[S21 Final Project Pipeline/2. SAST (Bandit)                       ] 🚀  Start image=catthehacker/ubuntu:act-latest
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)] 🚀  Start image=catthehacker/ubuntu:act-latest
[S21 Final Project Pipeline/6. Docker Build                        ]   🐳  docker pull image=catthehacker/ubuntu:act-latest platform=linux/arm64 username= forcePull=false
[S21 Final Project Pipeline/5. Secret Scan (Gitleaks)              ]   🐳  docker pull image=catthehacker/ubuntu:act-latest platform=linux/arm64 username= forcePull=false
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   🐳  docker pull image=catthehacker/ubuntu:act-latest platform=linux/arm64 username= forcePull=false
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   🐳  docker pull image=catthehacker/ubuntu:act-latest platform=linux/arm64 username= forcePull=false
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   🐳  docker pull image=catthehacker/ubuntu:act-latest platform=linux/arm64 username= forcePull=false
[S21 Final Project Pipeline/5. Secret Scan (Gitleaks)              ]   🐳  docker create image=catthehacker/ubuntu:act-latest platform=linux/arm64 entrypoint=["tail" "-f" "/dev/null"] cmd=[] network="host"
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   🐳  docker create image=catthehacker/ubuntu:act-latest platform=linux/arm64 entrypoint=["tail" "-f" "/dev/null"] cmd=[] network="host"
[S21 Final Project Pipeline/6. Docker Build                        ]   🐳  docker create image=catthehacker/ubuntu:act-latest platform=linux/arm64 entrypoint=["tail" "-f" "/dev/null"] cmd=[] network="host"
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   🐳  docker create image=catthehacker/ubuntu:act-latest platform=linux/arm64 entrypoint=["tail" "-f" "/dev/null"] cmd=[] network="host"
[S21 Final Project Pipeline/5. Secret Scan (Gitleaks)              ]   🐳  docker run image=catthehacker/ubuntu:act-latest platform=linux/arm64 entrypoint=["tail" "-f" "/dev/null"] cmd=[] network="host"
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   🐳  docker run image=catthehacker/ubuntu:act-latest platform=linux/arm64 entrypoint=["tail" "-f" "/dev/null"] cmd=[] network="host"
[S21 Final Project Pipeline/6. Docker Build                        ]   🐳  docker run image=catthehacker/ubuntu:act-latest platform=linux/arm64 entrypoint=["tail" "-f" "/dev/null"] cmd=[] network="host"
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   🐳  docker create image=catthehacker/ubuntu:act-latest platform=linux/arm64 entrypoint=["tail" "-f" "/dev/null"] cmd=[] network="host"
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   🐳  docker run image=catthehacker/ubuntu:act-latest platform=linux/arm64 entrypoint=["tail" "-f" "/dev/null"] cmd=[] network="host"
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   🐳  docker run image=catthehacker/ubuntu:act-latest platform=linux/arm64 entrypoint=["tail" "-f" "/dev/null"] cmd=[] network="host"
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   🐳  docker exec cmd=[node --no-warnings -e console.log(process.execPath)] user= workdir=
[S21 Final Project Pipeline/5. Secret Scan (Gitleaks)              ]   🐳  docker exec cmd=[node --no-warnings -e console.log(process.execPath)] user= workdir=
[S21 Final Project Pipeline/6. Docker Build                        ]   🐳  docker exec cmd=[node --no-warnings -e console.log(process.execPath)] user= workdir=
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   🐳  docker exec cmd=[node --no-warnings -e console.log(process.execPath)] user= workdir=
[S21 Final Project Pipeline/5. Secret Scan (Gitleaks)              ]   ✅  Success - Set up job
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   ✅  Success - Set up job
[S21 Final Project Pipeline/6. Docker Build                        ]   ✅  Success - Set up job
[S21 Final Project Pipeline/5. Secret Scan (Gitleaks)              ]   ☁  git clone 'https://github.com/actions/upload-artifact' # ref=v4
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   ☁  git clone 'https://github.com/actions/setup-python' # ref=v7
[S21 Final Project Pipeline/6. Docker Build                        ]   ☁  git clone 'https://github.com/docker/setup-buildx-action' # ref=v4
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   ✅  Success - Set up job
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   ☁  git clone 'https://github.com/aquasecurity/trivy-action' # ref=ed142fd0673e97e23eac54620cfb913e5ce36c25
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   🐳  docker exec cmd=[node --no-warnings -e console.log(process.execPath)] user= workdir=
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ✅  Success - Set up job
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ☁  git clone 'https://github.com/actions/setup-python' # ref=v7
[S21 Final Project Pipeline/5. Secret Scan (Gitleaks)              ] ⭐ Run Main Checkout source code
[S21 Final Project Pipeline/5. Secret Scan (Gitleaks)              ]   🐳  docker cp src=/Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment/. dst=/Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   ☁  git clone 'https://github.com/actions/upload-artifact' # ref=v4
[S21 Final Project Pipeline/6. Docker Build                        ]   ☁  git clone 'https://github.com/docker/build-push-action' # ref=v7
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ] ⭐ Run Pre Scan the Kubernetes manifests (Trivy config)
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   ☁  git clone 'https://github.com/aquasecurity/setup-trivy' # ref=3fb12ec12f41e471780db15c232d5dd185dcb514
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ☁  git clone 'https://github.com/actions/setup-node' # ref=v7
[S21 Final Project Pipeline/2. SAST (Bandit)                       ] ⭐ Run Main Checkout source code
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   🐳  docker cp src=/Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment/. dst=/Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment
[S21 Final Project Pipeline/6. Docker Build                        ]   ☁  git clone 'https://github.com/docker/build-push-action' # ref=v7
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ] ⭐ Run Pre Install Trivy
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   ☁  git clone 'https://github.com/actions/cache' # ref=9255dc7a253b0ccc959486e2bca901246202afeb
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ☁  git clone 'https://github.com/aquasecurity/trivy-action' # ref=ed142fd0673e97e23eac54620cfb913e5ce36c25
[S21 Final Project Pipeline/6. Docker Build                        ]   ☁  git clone 'https://github.com/actions/upload-artifact' # ref=v4
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   ☁  git clone 'https://github.com/actions/checkout' # ref=8e8c483db84b4bee98b60c0593521ed34d9990e8
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)] ⭐ Run Pre Scan the dependency files (Trivy fs)
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ☁  git clone 'https://github.com/aquasecurity/setup-trivy' # ref=3fb12ec12f41e471780db15c232d5dd185dcb514
[S21 Final Project Pipeline/6. Docker Build                        ] ⭐ Run Main Checkout source code
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   ☁  git clone 'https://github.com/actions/cache' # ref=9255dc7a253b0ccc959486e2bca901246202afeb
[S21 Final Project Pipeline/6. Docker Build                        ]   🐳  docker cp src=/Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment/. dst=/Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)] ⭐ Run Pre Install Trivy
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ☁  git clone 'https://github.com/actions/cache' # ref=9255dc7a253b0ccc959486e2bca901246202afeb
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   ✅  Success - Pre Install Trivy [575.301166ms]
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   ☁  git clone 'https://github.com/actions/cache' # ref=27d5ce7f107fe9357f9df03efb73ab90386fccae
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ☁  git clone 'https://github.com/actions/checkout' # ref=8e8c483db84b4bee98b60c0593521ed34d9990e8
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   ✅  Success - Pre Scan the Kubernetes manifests (Trivy config) [1.073302083s]
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ☁  git clone 'https://github.com/actions/cache' # ref=9255dc7a253b0ccc959486e2bca901246202afeb
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   ☁  git clone 'https://github.com/actions/upload-artifact' # ref=v4
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ✅  Success - Pre Install Trivy [418.43925ms]
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ☁  git clone 'https://github.com/actions/cache' # ref=27d5ce7f107fe9357f9df03efb73ab90386fccae
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ] ⭐ Run Main Checkout source code
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   🐳  docker cp src=/Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment/. dst=/Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ✅  Success - Pre Scan the dependency files (Trivy fs) [734.421417ms]
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ☁  git clone 'https://github.com/actions/upload-artifact' # ref=v4
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)] ⭐ Run Main Checkout source code
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   🐳  docker cp src=/Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment/. dst=/Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   ✅  Success - Main Checkout source code [1.829070917s]
[S21 Final Project Pipeline/5. Secret Scan (Gitleaks)              ]   ✅  Success - Main Checkout source code [2.33267325s]
[S21 Final Project Pipeline/2. SAST (Bandit)                       ] ⭐ Run Main Set up Python
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   🐳  docker cp src=/Users/kp/.cache/act/actions-setup-python@v7/ dst=/var/run/act/actions/actions-setup-python@v7/
[S21 Final Project Pipeline/5. Secret Scan (Gitleaks)              ] ⭐ Run Main Install Gitleaks (checksum verified)
[S21 Final Project Pipeline/5. Secret Scan (Gitleaks)              ]   🐳  docker exec cmd=[bash --noprofile --norc -e -o pipefail /var/run/act/workflow/1.sh] user= workdir=/tmp
[S21 Final Project Pipeline/6. Docker Build                        ]   ✅  Success - Main Checkout source code [2.235520709s]
[S21 Final Project Pipeline/6. Docker Build                        ] ⭐ Run Main Set up Docker Buildx
[S21 Final Project Pipeline/6. Docker Build                        ]   🐳  docker cp src=/Users/kp/.cache/act/docker-setup-buildx-action@v4/ dst=/var/run/act/actions/docker-setup-buildx-action@v4/
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   ✅  Success - Main Checkout source code [2.110001458s]
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ] ⭐ Run Main Create the reports folder
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   🐳  docker exec cmd=[bash --noprofile --norc -e -o pipefail /var/run/act/workflow/1.sh] user= workdir=Final-DevOps-Project-&-Troubleshooting
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   ✅  Success - Main Create the reports folder [103.980375ms]
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ✅  Success - Main Checkout source code [2.129181417s]
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   🐳  docker exec cmd=[/opt/acttoolcache/node/24.19.0/arm64/bin/node /var/run/act/actions/actions-setup-python@v7/dist/setup/index.js] user= workdir=
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)] ⭐ Run Main Set up Python
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ] ⭐ Run Main Scan the Kubernetes manifests (Trivy config)
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   🐳  docker cp src=/Users/kp/.cache/act/actions-setup-python@v7/ dst=/var/run/act/actions/actions-setup-python@v7/
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   🐳  docker cp src=/Users/kp/.cache/act/aquasecurity-trivy-action@ed142fd0673e97e23eac54620cfb913e5ce36c25/ dst=/var/run/act/actions/aquasecurity-trivy-action@ed142fd0673e97e23eac54620cfb913e5ce36c25/
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   ❓  ::group::Installed versions
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   | Successfully set up CPython (3.13.16)
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   ❓  ::endgroup::
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   ❓ add-matcher /run/act/actions/actions-setup-python@v7/.github/python.json
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   ✅  Success - Main Set up Python [1.674559209s]
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   ⚙  ::set-env:: Python3_ROOT_DIR=/opt/hostedtoolcache/Python/3.13.16/arm64
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   ⚙  ::set-env:: LD_LIBRARY_PATH=/opt/hostedtoolcache/Python/3.13.16/arm64/lib
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   ⚙  ::set-env:: pythonLocation=/opt/hostedtoolcache/Python/3.13.16/arm64
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   ⚙  ::set-env:: PKG_CONFIG_PATH=/opt/hostedtoolcache/Python/3.13.16/arm64/lib/pkgconfig
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   ⚙  ::set-env:: Python_ROOT_DIR=/opt/hostedtoolcache/Python/3.13.16/arm64
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   ⚙  ::set-env:: Python2_ROOT_DIR=/opt/hostedtoolcache/Python/3.13.16/arm64
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   ⚙  ::set-output:: python-path=/opt/hostedtoolcache/Python/3.13.16/arm64/bin/python
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   ⚙  ::set-output:: python-version=3.13.16
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   ⚙  ::add-path:: /opt/hostedtoolcache/Python/3.13.16/arm64
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   ⚙  ::add-path:: /opt/hostedtoolcache/Python/3.13.16/arm64/bin
[S21 Final Project Pipeline/2. SAST (Bandit)                       ] ⭐ Run Main Scan the backend source code
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   🐳  docker exec cmd=[bash --noprofile --norc -e -o pipefail /var/run/act/workflow/2.sh] user= workdir=Final-DevOps-Project-&-Troubleshooting
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ] ⭐ Run Main Install Trivy
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   🐳  docker cp src=/Users/kp/.cache/act/aquasecurity-setup-trivy@3fb12ec12f41e471780db15c232d5dd185dcb514/ dst=/var/run/act/actions/aquasecurity-setup-trivy@3fb12ec12f41e471780db15c232d5dd185dcb514/
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ] ⭐ Run Main Binary dir
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   🐳  docker exec cmd=[bash --noprofile --norc -e -o pipefail /var/run/act/workflow/2-composite-0-composite-binary-dir.sh] user= workdir=
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   ✅  Success - Main Binary dir [84.871875ms]
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   ⚙  ::set-output:: dir=/root/.local/bin/trivy-bin
[S21 Final Project Pipeline/6. Docker Build                        ]   🐳  docker exec cmd=[/opt/acttoolcache/node/24.19.0/arm64/bin/node /var/run/act/actions/docker-setup-buildx-action@v4/dist/index.cjs] user= workdir=
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ] ⭐ Run Main Restore Trivy binary from cache
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   🐳  docker cp src=/Users/kp/.cache/act/actions-cache-restore@9255dc7a253b0ccc959486e2bca901246202afeb/ dst=/var/run/act/actions/actions-cache-restore@9255dc7a253b0ccc959486e2bca901246202afeb/
[S21 Final Project Pipeline/6. Docker Build                        ]   ❓  ::group::Docker info
[S21 Final Project Pipeline/6. Docker Build                        ]   | [command]/usr/bin/docker version
[S21 Final Project Pipeline/6. Docker Build                        ]   | Client:
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Version:           29.7.2-1
[S21 Final Project Pipeline/6. Docker Build                        ]   |  API version:       1.55
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Go version:        go1.26.5
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Git commit:        a7dcaa6fdb6ed04aacbfdc76357fdae01605609e
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Built:             Fri Aug  7 10:40:54 2026
[S21 Final Project Pipeline/6. Docker Build                        ]   |  OS/Arch:           linux/arm64
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Context:           default
[S21 Final Project Pipeline/6. Docker Build                        ]   | 
[S21 Final Project Pipeline/6. Docker Build                        ]   | Server: Docker Desktop 4.87.0 (236836)
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Engine:
[S21 Final Project Pipeline/6. Docker Build                        ]   |   Version:          29.7.2
[S21 Final Project Pipeline/6. Docker Build                        ]   |   API version:      1.55 (minimum version 1.40)
[S21 Final Project Pipeline/6. Docker Build                        ]   |   Go version:       go1.26.5
[S21 Final Project Pipeline/6. Docker Build                        ]   |   Git commit:       6a43e3d
[S21 Final Project Pipeline/6. Docker Build                        ]   |   Built:            Wed Aug  5 18:28:35 2026
[S21 Final Project Pipeline/6. Docker Build                        ]   |   OS/Arch:          linux/arm64
[S21 Final Project Pipeline/6. Docker Build                        ]   |   Experimental:     false
[S21 Final Project Pipeline/6. Docker Build                        ]   |  containerd:
[S21 Final Project Pipeline/6. Docker Build                        ]   |   Version:          v2.2.5
[S21 Final Project Pipeline/6. Docker Build                        ]   |   GitCommit:        e53c7c1516c3b2bff98eb76f1f4117477e6f4e66
[S21 Final Project Pipeline/6. Docker Build                        ]   |  runc:
[S21 Final Project Pipeline/6. Docker Build                        ]   |   Version:          1.3.6
[S21 Final Project Pipeline/6. Docker Build                        ]   |   GitCommit:        v1.3.6-0-g491b69ba
[S21 Final Project Pipeline/6. Docker Build                        ]   |  docker-init:
[S21 Final Project Pipeline/6. Docker Build                        ]   |   Version:          0.19.0
[S21 Final Project Pipeline/6. Docker Build                        ]   |   GitCommit:        de40ad0
[S21 Final Project Pipeline/6. Docker Build                        ]   | [command]/usr/bin/docker info
[S21 Final Project Pipeline/6. Docker Build                        ]   | Client:
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Version:    29.7.2-1
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Context:    default
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Debug Mode: false
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Plugins:
[S21 Final Project Pipeline/6. Docker Build                        ]   |   buildx: Docker Buildx (Docker Inc.)
[S21 Final Project Pipeline/6. Docker Build                        ]   |     Version:  0.36.1-1
[S21 Final Project Pipeline/6. Docker Build                        ]   |     Path:     /usr/libexec/docker/cli-plugins/docker-buildx
[S21 Final Project Pipeline/6. Docker Build                        ]   |   compose: Docker Compose (Docker Inc.)
[S21 Final Project Pipeline/6. Docker Build                        ]   |     Version:  5.4.0-2
[S21 Final Project Pipeline/6. Docker Build                        ]   |     Path:     /usr/libexec/docker/cli-plugins/docker-compose
[S21 Final Project Pipeline/6. Docker Build                        ]   | 
[S21 Final Project Pipeline/6. Docker Build                        ]   | Server:
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Containers: 29
[S21 Final Project Pipeline/6. Docker Build                        ]   |   Running: 10
[S21 Final Project Pipeline/6. Docker Build                        ]   |   Paused: 0
[S21 Final Project Pipeline/6. Docker Build                        ]   |   Stopped: 19
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Images: 90
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Server Version: 29.7.2
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Storage Driver: overlayfs
[S21 Final Project Pipeline/6. Docker Build                        ]   |   driver-type: io.containerd.snapshotter.v1
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Logging Driver: json-file
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Cgroup Driver: cgroupfs
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Cgroup Version: 2
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Plugins:
[S21 Final Project Pipeline/6. Docker Build                        ]   |   Volume: local
[S21 Final Project Pipeline/6. Docker Build                        ]   |   Network: bridge host ipvlan macvlan null overlay
[S21 Final Project Pipeline/6. Docker Build                        ]   |   Log: awslogs fluentd gcplogs gelf journald json-file local splunk syslog
[S21 Final Project Pipeline/6. Docker Build                        ]   |  CDI spec directories:
[S21 Final Project Pipeline/6. Docker Build                        ]   |   /etc/cdi
[S21 Final Project Pipeline/6. Docker Build                        ]   |   /var/run/cdi
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Discovered Devices:
[S21 Final Project Pipeline/6. Docker Build                        ]   |   cdi: docker.com/gpu=webgpu
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Swarm: inactive
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Runtimes: io.containerd.runc.v2 runc
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Default Runtime: runc
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Init Binary: docker-init
[S21 Final Project Pipeline/6. Docker Build                        ]   |  containerd version: e53c7c1516c3b2bff98eb76f1f4117477e6f4e66
[S21 Final Project Pipeline/6. Docker Build                        ]   |  runc version: v1.3.6-0-g491b69ba
[S21 Final Project Pipeline/6. Docker Build                        ]   |  init version: de40ad0
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Security Options:
[S21 Final Project Pipeline/6. Docker Build                        ]   |   seccomp
[S21 Final Project Pipeline/6. Docker Build                        ]   |    Profile: builtin
[S21 Final Project Pipeline/6. Docker Build                        ]   |   cgroupns
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Kernel Version: 7.0.12-linuxkit
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Operating System: Docker Desktop
[S21 Final Project Pipeline/6. Docker Build                        ]   |  OSType: linux
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Architecture: aarch64
[S21 Final Project Pipeline/6. Docker Build                        ]   |  CPUs: 15
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Total Memory: 11.67GiB
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Name: docker-desktop
[S21 Final Project Pipeline/6. Docker Build                        ]   |  ID: 9bd91c35-f158-4f23-93a7-e74dad678dac
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Docker Root Dir: /var/lib/docker
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Debug Mode: false
[S21 Final Project Pipeline/6. Docker Build                        ]   |  HTTP Proxy: http.docker.internal:3128
[S21 Final Project Pipeline/6. Docker Build                        ]   |  HTTPS Proxy: http.docker.internal:3128
[S21 Final Project Pipeline/6. Docker Build                        ]   |  No Proxy: hubproxy.docker.internal
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Labels:
[S21 Final Project Pipeline/6. Docker Build                        ]   |   com.docker.desktop.address=unix:///Users/kp/Library/Containers/com.docker.docker/Data/docker-cli.sock
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Experimental: false
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Insecure Registries:
[S21 Final Project Pipeline/6. Docker Build                        ]   |   hubproxy.docker.internal:5555
[S21 Final Project Pipeline/6. Docker Build                        ]   |   ::1/128
[S21 Final Project Pipeline/6. Docker Build                        ]   |   127.0.0.0/8
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Live Restore Enabled: false
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Firewall Backend: iptables
[S21 Final Project Pipeline/6. Docker Build                        ]   | 
[S21 Final Project Pipeline/6. Docker Build                        ]   ❓  ::endgroup::
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   🐳  docker exec cmd=[/opt/acttoolcache/node/24.19.0/arm64/bin/node /var/run/act/actions/actions-setup-python@v7/dist/setup/index.js] user= workdir=
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   | Requirement already satisfied: bandit==1.9.4 in /opt/hostedtoolcache/Python/3.13.16/arm64/lib/python3.13/site-packages (1.9.4)
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   | Requirement already satisfied: PyYAML>=5.3.1 in /opt/hostedtoolcache/Python/3.13.16/arm64/lib/python3.13/site-packages (from bandit==1.9.4) (6.0.3)
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   | Requirement already satisfied: stevedore>=1.20.0 in /opt/hostedtoolcache/Python/3.13.16/arm64/lib/python3.13/site-packages (from bandit==1.9.4) (5.9.1)
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   | Requirement already satisfied: rich in /opt/hostedtoolcache/Python/3.13.16/arm64/lib/python3.13/site-packages (from bandit==1.9.4) (15.0.0)
[S21 Final Project Pipeline/6. Docker Build                        ]   ❓  ::group::Buildx version
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   | Requirement already satisfied: markdown-it-py>=2.2.0 in /opt/hostedtoolcache/Python/3.13.16/arm64/lib/python3.13/site-packages (from rich->bandit==1.9.4) (4.2.0)
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   | Requirement already satisfied: pygments<3.0.0,>=2.13.0 in /opt/hostedtoolcache/Python/3.13.16/arm64/lib/python3.13/site-packages (from rich->bandit==1.9.4) (2.21.0)
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   | Requirement already satisfied: mdurl~=0.1 in /opt/hostedtoolcache/Python/3.13.16/arm64/lib/python3.13/site-packages (from markdown-it-py>=2.2.0->rich->bandit==1.9.4) (0.1.2)
[S21 Final Project Pipeline/6. Docker Build                        ]   | [command]/usr/bin/docker buildx version
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ❓  ::group::Installed versions
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | Successfully set up CPython (3.13.16)
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ❓  ::endgroup::
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ❓ add-matcher /run/act/actions/actions-setup-python@v7/.github/python.json
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ✅  Success - Main Set up Python [1.162753792s]
[S21 Final Project Pipeline/6. Docker Build                        ]   | github.com/docker/buildx 0.36.1-1 1d8dde89b8aba914e05e45366770736fea1fd690
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ⚙  ::set-env:: Python2_ROOT_DIR=/opt/hostedtoolcache/Python/3.13.16/arm64
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ⚙  ::set-env:: Python3_ROOT_DIR=/opt/hostedtoolcache/Python/3.13.16/arm64
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ⚙  ::set-env:: LD_LIBRARY_PATH=/opt/hostedtoolcache/Python/3.13.16/arm64/lib
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ⚙  ::set-env:: pythonLocation=/opt/hostedtoolcache/Python/3.13.16/arm64
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ⚙  ::set-env:: PKG_CONFIG_PATH=/opt/hostedtoolcache/Python/3.13.16/arm64/lib/pkgconfig
[S21 Final Project Pipeline/6. Docker Build                        ]   ❓  ::endgroup::
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ⚙  ::set-env:: Python_ROOT_DIR=/opt/hostedtoolcache/Python/3.13.16/arm64
[S21 Final Project Pipeline/6. Docker Build                        ]   ❓  ::group::Booting builder
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ⚙  ::set-output:: python-version=3.13.16
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ⚙  ::set-output:: python-path=/opt/hostedtoolcache/Python/3.13.16/arm64/bin/python
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   | WARNING: Running pip as the 'root' user can result in broken permissions and conflicting behaviour with the system package manager, possibly rendering your system unusable. It is recommended to use a virtual environment instead: https://pip.pypa.io/warnings/venv. Use the --root-user-action option if you know what you are doing and want to suppress this warning.
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ⚙  ::add-path:: /opt/hostedtoolcache/Python/3.13.16/arm64
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ⚙  ::add-path:: /opt/hostedtoolcache/Python/3.13.16/arm64/bin
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)] ⭐ Run Main Audit the Python dependencies (pip-audit)
[S21 Final Project Pipeline/6. Docker Build                        ]   | [command]/usr/bin/docker buildx inspect --bootstrap --builder default
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   🐳  docker exec cmd=[bash --noprofile --norc -e -o pipefail /var/run/act/workflow/2.sh] user= workdir=Final-DevOps-Project-&-Troubleshooting
[S21 Final Project Pipeline/6. Docker Build                        ]   | Name:   default
[S21 Final Project Pipeline/6. Docker Build                        ]   | Driver: docker
[S21 Final Project Pipeline/6. Docker Build                        ]   | 
[S21 Final Project Pipeline/6. Docker Build                        ]   | Nodes:
[S21 Final Project Pipeline/6. Docker Build                        ]   | Name:             default
[S21 Final Project Pipeline/6. Docker Build                        ]   | Endpoint:         default
[S21 Final Project Pipeline/6. Docker Build                        ]   | Status:           running
[S21 Final Project Pipeline/6. Docker Build                        ]   | BuildKit version: v0.32.2
[S21 Final Project Pipeline/6. Docker Build                        ]   | Platforms:        linux/arm64, linux/amd64, linux/amd64/v2, linux/riscv64, linux/ppc64le, linux/s390x, linux/386
[S21 Final Project Pipeline/6. Docker Build                        ]   | Labels:
[S21 Final Project Pipeline/6. Docker Build                        ]   |  org.mobyproject.buildkit.worker.containerd.namespace: moby
[S21 Final Project Pipeline/6. Docker Build                        ]   |  org.mobyproject.buildkit.worker.containerd.uuid:      901af005-849e-49c0-8694-c6cf43e5380c
[S21 Final Project Pipeline/6. Docker Build                        ]   |  org.mobyproject.buildkit.worker.executor:             containerd
[S21 Final Project Pipeline/6. Docker Build                        ]   |  org.mobyproject.buildkit.worker.hostname:             docker-desktop
[S21 Final Project Pipeline/6. Docker Build                        ]   |  org.mobyproject.buildkit.worker.moby.host-gateway-ip: 192.168.65.254
[S21 Final Project Pipeline/6. Docker Build                        ]   |  org.mobyproject.buildkit.worker.network:              host
[S21 Final Project Pipeline/6. Docker Build                        ]   |  org.mobyproject.buildkit.worker.selinux.enabled:      false
[S21 Final Project Pipeline/6. Docker Build                        ]   |  org.mobyproject.buildkit.worker.snapshotter:          overlayfs
[S21 Final Project Pipeline/6. Docker Build                        ]   | Devices:
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Name:                  docker.com/gpu=webgpu
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Automatically allowed: false
[S21 Final Project Pipeline/6. Docker Build                        ]   | GC Policy rule#0:
[S21 Final Project Pipeline/6. Docker Build                        ]   |  All:            false
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Filters:        type==source.local type==exec.cachemount type==source.git.checkout
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Keep Duration:  48h0m0s
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Max Used Space: 2.764GiB
[S21 Final Project Pipeline/6. Docker Build                        ]   | GC Policy rule#1:
[S21 Final Project Pipeline/6. Docker Build                        ]   |  All:            false
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Keep Duration:  1440h0m0s
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Reserved Space: 20GiB
[S21 Final Project Pipeline/6. Docker Build                        ]   | GC Policy rule#2:
[S21 Final Project Pipeline/6. Docker Build                        ]   |  All:            false
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Reserved Space: 20GiB
[S21 Final Project Pipeline/6. Docker Build                        ]   | GC Policy rule#3:
[S21 Final Project Pipeline/6. Docker Build                        ]   |  All:            true
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Reserved Space: 20GiB
[S21 Final Project Pipeline/6. Docker Build                        ]   ❓  ::endgroup::
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   | [main]	INFO	profile include tests: None
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   | [main]	INFO	profile exclude tests: None
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   | [main]	INFO	cli include tests: None
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   | [main]	INFO	cli exclude tests: None
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   | [json]	INFO	JSON output written to file: reports/bandit.json
[S21 Final Project Pipeline/6. Docker Build                        ]   ❓  ::group::Inspect builder
[S21 Final Project Pipeline/6. Docker Build                        ]   | {
[S21 Final Project Pipeline/6. Docker Build                        ]   |   "nodes": [
[S21 Final Project Pipeline/6. Docker Build                        ]   |     {
[S21 Final Project Pipeline/6. Docker Build                        ]   |       "name": "default",
[S21 Final Project Pipeline/6. Docker Build                        ]   |       "endpoint": "default",
[S21 Final Project Pipeline/6. Docker Build                        ]   |       "status": "running",
[S21 Final Project Pipeline/6. Docker Build                        ]   |       "buildkit": "v0.32.2",
[S21 Final Project Pipeline/6. Docker Build                        ]   |       "platforms": "linux/arm64,linux/amd64,linux/amd64/v2,linux/riscv64,linux/ppc64le,linux/s390x,linux/386",
[S21 Final Project Pipeline/6. Docker Build                        ]   |       "features": {
[S21 Final Project Pipeline/6. Docker Build                        ]   |         "Automatically load images to the Docker Engine image store": true,
[S21 Final Project Pipeline/6. Docker Build                        ]   |         "Cache export": true,
[S21 Final Project Pipeline/6. Docker Build                        ]   |         "Direct push": true,
[S21 Final Project Pipeline/6. Docker Build                        ]   |         "Docker exporter": true,
[S21 Final Project Pipeline/6. Docker Build                        ]   |         "Multi-platform build": true,
[S21 Final Project Pipeline/6. Docker Build                        ]   |         "OCI exporter": true,
[S21 Final Project Pipeline/6. Docker Build                        ]   |         "Prefer image digest": true
[S21 Final Project Pipeline/6. Docker Build                        ]   |       },
[S21 Final Project Pipeline/6. Docker Build                        ]   |       "labels": {
[S21 Final Project Pipeline/6. Docker Build                        ]   |         "org.mobyproject.buildkit.worker.containerd.namespace": "moby",
[S21 Final Project Pipeline/6. Docker Build                        ]   |         "org.mobyproject.buildkit.worker.containerd.uuid": "901af005-849e-49c0-8694-c6cf43e5380c",
[S21 Final Project Pipeline/6. Docker Build                        ]   |         "org.mobyproject.buildkit.worker.executor": "containerd",
[S21 Final Project Pipeline/6. Docker Build                        ]   |         "org.mobyproject.buildkit.worker.hostname": "docker-desktop",
[S21 Final Project Pipeline/6. Docker Build                        ]   |         "org.mobyproject.buildkit.worker.moby.host-gateway-ip": "192.168.65.254",
[S21 Final Project Pipeline/6. Docker Build                        ]   |         "org.mobyproject.buildkit.worker.network": "host",
[S21 Final Project Pipeline/6. Docker Build                        ]   |         "org.mobyproject.buildkit.worker.selinux.enabled": "false",
[S21 Final Project Pipeline/6. Docker Build                        ]   |         "org.mobyproject.buildkit.worker.snapshotter": "overlayfs"
[S21 Final Project Pipeline/6. Docker Build                        ]   |       },
[S21 Final Project Pipeline/6. Docker Build                        ]   |       "devices": [
[S21 Final Project Pipeline/6. Docker Build                        ]   |         {
[S21 Final Project Pipeline/6. Docker Build                        ]   |           "name": "docker.com/gpu=webgpu",
[S21 Final Project Pipeline/6. Docker Build                        ]   |           "autoAllow": false
[S21 Final Project Pipeline/6. Docker Build                        ]   |         }
[S21 Final Project Pipeline/6. Docker Build                        ]   |       ],
[S21 Final Project Pipeline/6. Docker Build                        ]   |       "gcPolicy": [
[S21 Final Project Pipeline/6. Docker Build                        ]   |         {
[S21 Final Project Pipeline/6. Docker Build                        ]   |           "all": false,
[S21 Final Project Pipeline/6. Docker Build                        ]   |           "filter": [
[S21 Final Project Pipeline/6. Docker Build                        ]   |             "type==source.local type==exec.cachemount type==source.git.checkout"
[S21 Final Project Pipeline/6. Docker Build                        ]   |           ],
[S21 Final Project Pipeline/6. Docker Build                        ]   |           "keepDuration": "48h0m0s",
[S21 Final Project Pipeline/6. Docker Build                        ]   |           "maxUsedSpace": "2.764GiB"
[S21 Final Project Pipeline/6. Docker Build                        ]   |         },
[S21 Final Project Pipeline/6. Docker Build                        ]   |         {
[S21 Final Project Pipeline/6. Docker Build                        ]   |           "all": false,
[S21 Final Project Pipeline/6. Docker Build                        ]   |           "keepDuration": "1440h0m0s",
[S21 Final Project Pipeline/6. Docker Build                        ]   |           "reservedSpace": "20GiB"
[S21 Final Project Pipeline/6. Docker Build                        ]   |         },
[S21 Final Project Pipeline/6. Docker Build                        ]   |         {
[S21 Final Project Pipeline/6. Docker Build                        ]   |           "all": false,
[S21 Final Project Pipeline/6. Docker Build                        ]   |           "reservedSpace": "20GiB"
[S21 Final Project Pipeline/6. Docker Build                        ]   |         },
[S21 Final Project Pipeline/6. Docker Build                        ]   |         {
[S21 Final Project Pipeline/6. Docker Build                        ]   |           "all": true,
[S21 Final Project Pipeline/6. Docker Build                        ]   |           "reservedSpace": "20GiB"
[S21 Final Project Pipeline/6. Docker Build                        ]   |         }
[S21 Final Project Pipeline/6. Docker Build                        ]   |       ]
[S21 Final Project Pipeline/6. Docker Build                        ]   |     }
[S21 Final Project Pipeline/6. Docker Build                        ]   |   ],
[S21 Final Project Pipeline/6. Docker Build                        ]   |   "name": "default",
[S21 Final Project Pipeline/6. Docker Build                        ]   |   "driver": "docker"
[S21 Final Project Pipeline/6. Docker Build                        ]   | }
[S21 Final Project Pipeline/6. Docker Build                        ]   ❓  ::endgroup::
[S21 Final Project Pipeline/6. Docker Build                        ]   ✅  Success - Main Set up Docker Buildx [2.134453s]
[S21 Final Project Pipeline/6. Docker Build                        ]   ⚙  ::set-output:: name=default
[S21 Final Project Pipeline/6. Docker Build                        ]   ⚙  ::set-output:: driver=docker
[S21 Final Project Pipeline/6. Docker Build                        ]   ⚙  ::set-output:: platforms=linux/arm64,linux/amd64,linux/amd64/v2,linux/riscv64,linux/ppc64le,linux/s390x,linux/386
[S21 Final Project Pipeline/6. Docker Build                        ]   ⚙  ::set-output:: nodes=[
  {
    "name": "default",
    "endpoint": "default",
    "status": "running",
    "buildkit": "v0.32.2",
    "platforms": "linux/arm64,linux/amd64,linux/amd64/v2,linux/riscv64,linux/ppc64le,linux/s390x,linux/386",
    "features": {
      "Automatically load images to the Docker Engine image store": true,
      "Cache export": true,
      "Direct push": true,
      "Docker exporter": true,
      "Multi-platform build": true,
      "OCI exporter": true,
      "Prefer image digest": true
    },
    "labels": {
      "org.mobyproject.buildkit.worker.containerd.namespace": "moby",
      "org.mobyproject.buildkit.worker.containerd.uuid": "901af005-849e-49c0-8694-c6cf43e5380c",
      "org.mobyproject.buildkit.worker.executor": "containerd",
      "org.mobyproject.buildkit.worker.hostname": "docker-desktop",
      "org.mobyproject.buildkit.worker.moby.host-gateway-ip": "192.168.65.254",
      "org.mobyproject.buildkit.worker.network": "host",
      "org.mobyproject.buildkit.worker.selinux.enabled": "false",
      "org.mobyproject.buildkit.worker.snapshotter": "overlayfs"
    },
    "devices": [
      {
        "name": "docker.com/gpu=webgpu",
        "autoAllow": false
      }
    ],
    "gcPolicy": [
      {
        "all": false,
        "filter": [
          "type==source.local type==exec.cachemount type==source.git.checkout"
        ],
        "keepDuration": "48h0m0s",
        "maxUsedSpace": "2.764GiB"
      },
      {
        "all": false,
        "keepDuration": "1440h0m0s",
        "reservedSpace": "20GiB"
      },
      {
        "all": false,
        "reservedSpace": "20GiB"
      },
      {
        "all": true,
        "reservedSpace": "20GiB"
      }
    ]
  }
]
[S21 Final Project Pipeline/6. Docker Build                        ] ⭐ Run Main Build the backend image (tag = Git commit SHA)
[S21 Final Project Pipeline/6. Docker Build                        ]   🐳  docker cp src=/Users/kp/.cache/act/docker-build-push-action@v7/ dst=/var/run/act/actions/docker-build-push-action@v7/
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   | [main]	INFO	profile include tests: None
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   | [main]	INFO	profile exclude tests: None
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   | [main]	INFO	cli include tests: None
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   | [main]	INFO	cli exclude tests: None
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   | [main]	INFO	using config: security/bandit.yaml
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   | [main]	INFO	running on Python 3.13.16
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   | Run started:2026-10-07 14:00:34.031366+00:00
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   | 
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   | Test results:
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   | 	No issues identified.
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   | 
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   | Code scanned:
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   | 	Total lines of code: 185
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   | 	Total lines skipped (#nosec): 0
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   | 
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   | Run metrics:
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   | 	Total issues (by severity):
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   | 		Undefined: 0
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   | 		Low: 0
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   | 		Medium: 0
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   | 		High: 0
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   | 	Total issues (by confidence):
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   | 		Undefined: 0
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   | 		Low: 0
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   | 		Medium: 0
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   | 		High: 0
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   | Files skipped (0):
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   ✅  Success - Main Scan the backend source code [1.45325675s]
[S21 Final Project Pipeline/2. SAST (Bandit)                       ] ⭐ Run Main Upload SAST report
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   🐳  docker cp src=/Users/kp/.cache/act/actions-upload-artifact@v4/ dst=/var/run/act/actions/actions-upload-artifact@v4/
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   🐳  docker exec cmd=[/opt/acttoolcache/node/24.19.0/arm64/bin/node /var/run/act/actions/actions-cache-restore@9255dc7a253b0ccc959486e2bca901246202afeb/dist/restore-only/index.js] user= workdir=
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   ⚙  ***
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | Cache Size: ~41 MB (42628276 B)
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | [command]/usr/bin/tar -xf /tmp/07514b64-a39b-4460-8d25-2361844b8ff9/cache.tzst -P -C /Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment --use-compress-program unzstd
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | Requirement already satisfied: pip-audit==2.10.1 in /opt/hostedtoolcache/Python/3.13.16/arm64/lib/python3.13/site-packages (2.10.1)
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | Requirement already satisfied: CacheControl>=0.13.0 in /opt/hostedtoolcache/Python/3.13.16/arm64/lib/python3.13/site-packages (from CacheControl[filecache]>=0.13.0->pip-audit==2.10.1) (0.14.4)
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | Requirement already satisfied: cyclonedx-python-lib<12,>=5 in /opt/hostedtoolcache/Python/3.13.16/arm64/lib/python3.13/site-packages (from pip-audit==2.10.1) (11.12.0)
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | Requirement already satisfied: packaging>=23.0.0 in /opt/hostedtoolcache/Python/3.13.16/arm64/lib/python3.13/site-packages (from pip-audit==2.10.1) (26.3)
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | Requirement already satisfied: pip-api>=0.0.28 in /opt/hostedtoolcache/Python/3.13.16/arm64/lib/python3.13/site-packages (from pip-audit==2.10.1) (0.0.35)
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | Requirement already satisfied: pip-requirements-parser>=32.0.0 in /opt/hostedtoolcache/Python/3.13.16/arm64/lib/python3.13/site-packages (from pip-audit==2.10.1) (32.0.1)
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | Requirement already satisfied: requests>=2.31.0 in /opt/hostedtoolcache/Python/3.13.16/arm64/lib/python3.13/site-packages (from pip-audit==2.10.1) (2.34.2)
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | Requirement already satisfied: rich>=12.4 in /opt/hostedtoolcache/Python/3.13.16/arm64/lib/python3.13/site-packages (from pip-audit==2.10.1) (15.0.0)
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | Requirement already satisfied: tomli>=2.2.1 in /opt/hostedtoolcache/Python/3.13.16/arm64/lib/python3.13/site-packages (from pip-audit==2.10.1) (2.4.1)
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | Requirement already satisfied: tomli-w>=1.2.0 in /opt/hostedtoolcache/Python/3.13.16/arm64/lib/python3.13/site-packages (from pip-audit==2.10.1) (1.2.0)
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | Requirement already satisfied: platformdirs>=4.2.0 in /opt/hostedtoolcache/Python/3.13.16/arm64/lib/python3.13/site-packages (from pip-audit==2.10.1) (4.12.3)
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | Requirement already satisfied: license-expression<31,>=30 in /opt/hostedtoolcache/Python/3.13.16/arm64/lib/python3.13/site-packages (from cyclonedx-python-lib<12,>=5->pip-audit==2.10.1) (30.4.4)
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | Requirement already satisfied: packageurl-python<2,>=0.11 in /opt/hostedtoolcache/Python/3.13.16/arm64/lib/python3.13/site-packages (from cyclonedx-python-lib<12,>=5->pip-audit==2.10.1) (0.17.6)
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | Requirement already satisfied: py-serializable<3.0.0,>=2.1.0 in /opt/hostedtoolcache/Python/3.13.16/arm64/lib/python3.13/site-packages (from cyclonedx-python-lib<12,>=5->pip-audit==2.10.1) (2.1.0)
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | Requirement already satisfied: sortedcontainers<3.0.0,>=2.4.0 in /opt/hostedtoolcache/Python/3.13.16/arm64/lib/python3.13/site-packages (from cyclonedx-python-lib<12,>=5->pip-audit==2.10.1) (2.4.0)
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | Requirement already satisfied: boolean.py>=4.0 in /opt/hostedtoolcache/Python/3.13.16/arm64/lib/python3.13/site-packages (from license-expression<31,>=30->cyclonedx-python-lib<12,>=5->pip-audit==2.10.1) (5.0)
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | Requirement already satisfied: defusedxml<0.8.0,>=0.7.1 in /opt/hostedtoolcache/Python/3.13.16/arm64/lib/python3.13/site-packages (from py-serializable<3.0.0,>=2.1.0->cyclonedx-python-lib<12,>=5->pip-audit==2.10.1) (0.7.1)
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | Requirement already satisfied: msgpack<2.0.0,>=0.5.2 in /opt/hostedtoolcache/Python/3.13.16/arm64/lib/python3.13/site-packages (from CacheControl>=0.13.0->CacheControl[filecache]>=0.13.0->pip-audit==2.10.1) (1.2.3)
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | Requirement already satisfied: filelock>=3.8.0 in /opt/hostedtoolcache/Python/3.13.16/arm64/lib/python3.13/site-packages (from CacheControl[filecache]>=0.13.0->pip-audit==2.10.1) (4.0.12)
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | Requirement already satisfied: pip in /opt/hostedtoolcache/Python/3.13.16/arm64/lib/python3.13/site-packages (from pip-api>=0.0.28->pip-audit==2.10.1) (26.2.1)
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | Requirement already satisfied: pyparsing in /opt/hostedtoolcache/Python/3.13.16/arm64/lib/python3.13/site-packages (from pip-requirements-parser>=32.0.0->pip-audit==2.10.1) (3.3.3)
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | Requirement already satisfied: charset_normalizer<4,>=2 in /opt/hostedtoolcache/Python/3.13.16/arm64/lib/python3.13/site-packages (from requests>=2.31.0->pip-audit==2.10.1) (3.5.2)
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | Requirement already satisfied: idna<4,>=2.5 in /opt/hostedtoolcache/Python/3.13.16/arm64/lib/python3.13/site-packages (from requests>=2.31.0->pip-audit==2.10.1) (3.20)
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | Requirement already satisfied: urllib3<3,>=1.26 in /opt/hostedtoolcache/Python/3.13.16/arm64/lib/python3.13/site-packages (from requests>=2.31.0->pip-audit==2.10.1) (2.8.0)
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | Requirement already satisfied: certifi>=2023.5.7 in /opt/hostedtoolcache/Python/3.13.16/arm64/lib/python3.13/site-packages (from requests>=2.31.0->pip-audit==2.10.1) (2026.7.22)
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | Requirement already satisfied: markdown-it-py>=2.2.0 in /opt/hostedtoolcache/Python/3.13.16/arm64/lib/python3.13/site-packages (from rich>=12.4->pip-audit==2.10.1) (4.2.0)
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | Requirement already satisfied: pygments<3.0.0,>=2.13.0 in /opt/hostedtoolcache/Python/3.13.16/arm64/lib/python3.13/site-packages (from rich>=12.4->pip-audit==2.10.1) (2.21.0)
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | Requirement already satisfied: mdurl~=0.1 in /opt/hostedtoolcache/Python/3.13.16/arm64/lib/python3.13/site-packages (from markdown-it-py>=2.2.0->rich>=12.4->pip-audit==2.10.1) (0.1.2)
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   🐳  docker exec cmd=[/opt/acttoolcache/node/24.19.0/arm64/bin/node /var/run/act/actions/actions-upload-artifact@v4/dist/upload/index.js] user= workdir=
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | WARNING: Running pip as the 'root' user can result in broken permissions and conflicting behaviour with the system package manager, possibly rendering your system unusable. It is recommended to use a virtual environment instead: https://pip.pypa.io/warnings/venv. Use the --root-user-action option if you know what you are doing and want to suppress this warning.
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   | (node:71) [DEP0040] DeprecationWarning: The `punycode` module is deprecated. Please use a userland alternative instead.
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   | (Use `node --trace-deprecation ...` to show where the warning was created)
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   | With the provided path, there will be 1 file uploaded
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   | Artifact name is valid!
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   | Root directory input is valid!
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   | Beginning upload of artifact content to blob storage
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   | (node:71) [DEP0169] DeprecationWarning: `url.parse()` behavior is not standardized and prone to errors that have security implications. Use the WHATWG URL API instead. CVEs are not issued for `url.parse()` vulnerabilities.
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   | Uploaded bytes 425
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   | Finished uploading artifact content to blob storage!
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   | SHA256 digest of uploaded artifact zip is 5cc78c92ec791f7f8985a5610af77fdd36c8f2d8967874170005e3749301a549
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   | Finalizing artifact upload
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   | Artifact sast-report.zip successfully finalized. Artifact ID 574075399
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   | Artifact sast-report has been successfully uploaded! Final size is 425 bytes. Artifact ID is 574075399
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   | Artifact download URL: https://github.com/kartavya37/DevOps-Assignment/actions/runs/1/artifacts/574075399
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   ✅  Success - Main Upload SAST report [994.173667ms]
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   ⚙  ::set-output:: artifact-id=574075399
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   ⚙  ::set-output:: artifact-digest=5cc78c92ec791f7f8985a5610af77fdd36c8f2d8967874170005e3749301a549
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   ⚙  ::set-output:: artifact-url=https://github.com/kartavya37/DevOps-Assignment/actions/runs/1/artifacts/574075399
[S21 Final Project Pipeline/2. SAST (Bandit)                       ] ⭐ Run Post Set up Python
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   🐳  docker exec cmd=[/opt/acttoolcache/node/24.19.0/arm64/bin/node /var/run/act/actions/actions-setup-python@v7/dist/cache-save/index.js] user= workdir=
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   ✅  Success - Post Set up Python [135.068125ms]
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | /usr/bin/tar: Year/Devops/SST-Assignments/DevOps-Assignment: Not found in archive
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | /usr/bin/tar: Exiting with failure status due to previous errors
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   🚧  ::warning::Failed to restore: "/usr/bin/tar" failed with error: The process '/usr/bin/tar' failed with exit code 2
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | Cache not found for input keys: trivy-binary-v0.75.0-Linux-ARM64
[S21 Final Project Pipeline/2. SAST (Bandit)                       ] ⭐ Run Complete job
[S21 Final Project Pipeline/2. SAST (Bandit)                       ] Cleaning up container for job 2. SAST (Bandit)
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   ✅  Success - Main Restore Trivy binary from cache [2.192652833s]
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   ⚙  ::set-output:: cache-primary-key=trivy-binary-v0.75.0-Linux-ARM64
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ] ⭐ Run Main Checkout install script
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   🐳  docker cp src=/Users/kp/.cache/act/actions-checkout@8e8c483db84b4bee98b60c0593521ed34d9990e8/ dst=/var/run/act/actions/actions-checkout@8e8c483db84b4bee98b60c0593521ed34d9990e8/
[S21 Final Project Pipeline/6. Docker Build                        ]   🐳  docker exec cmd=[/opt/acttoolcache/node/24.19.0/arm64/bin/node /var/run/act/actions/docker-build-push-action@v7/dist/index.cjs] user= workdir=
[S21 Final Project Pipeline/2. SAST (Bandit)                       ]   ✅  Success - Complete job
[S21 Final Project Pipeline/2. SAST (Bandit)                       ] 🏁  Job succeeded
[S21 Final Project Pipeline/6. Docker Build                        ]   ❓  ::group::GitHub Actions runtime token ACs
[S21 Final Project Pipeline/6. Docker Build                        ]   | : write
[S21 Final Project Pipeline/6. Docker Build                        ]   ❓  ::endgroup::
[S21 Final Project Pipeline/6. Docker Build                        ]   ❓  ::group::Docker info
[S21 Final Project Pipeline/6. Docker Build                        ]   | [command]/usr/bin/docker version
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   🐳  docker exec cmd=[/opt/acttoolcache/node/24.19.0/arm64/bin/node /var/run/act/actions/actions-checkout@8e8c483db84b4bee98b60c0593521ed34d9990e8/dist/index.js] user= workdir=
[S21 Final Project Pipeline/6. Docker Build                        ]   | Client:
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Version:           29.7.2-1
[S21 Final Project Pipeline/6. Docker Build                        ]   |  API version:       1.55
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Go version:        go1.26.5
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Git commit:        a7dcaa6fdb6ed04aacbfdc76357fdae01605609e
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Built:             Fri Aug  7 10:40:54 2026
[S21 Final Project Pipeline/6. Docker Build                        ]   |  OS/Arch:           linux/arm64
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Context:           default
[S21 Final Project Pipeline/6. Docker Build                        ]   | 
[S21 Final Project Pipeline/6. Docker Build                        ]   | Server: Docker Desktop 4.87.0 (236836)
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Engine:
[S21 Final Project Pipeline/6. Docker Build                        ]   |   Version:          29.7.2
[S21 Final Project Pipeline/6. Docker Build                        ]   |   API version:      1.55 (minimum version 1.40)
[S21 Final Project Pipeline/6. Docker Build                        ]   |   Go version:       go1.26.5
[S21 Final Project Pipeline/6. Docker Build                        ]   |   Git commit:       6a43e3d
[S21 Final Project Pipeline/6. Docker Build                        ]   |   Built:            Wed Aug  5 18:28:35 2026
[S21 Final Project Pipeline/6. Docker Build                        ]   |   OS/Arch:          linux/arm64
[S21 Final Project Pipeline/6. Docker Build                        ]   |   Experimental:     false
[S21 Final Project Pipeline/6. Docker Build                        ]   |  containerd:
[S21 Final Project Pipeline/6. Docker Build                        ]   |   Version:          v2.2.5
[S21 Final Project Pipeline/6. Docker Build                        ]   |   GitCommit:        e53c7c1516c3b2bff98eb76f1f4117477e6f4e66
[S21 Final Project Pipeline/6. Docker Build                        ]   |  runc:
[S21 Final Project Pipeline/6. Docker Build                        ]   |   Version:          1.3.6
[S21 Final Project Pipeline/6. Docker Build                        ]   |   GitCommit:        v1.3.6-0-g491b69ba
[S21 Final Project Pipeline/6. Docker Build                        ]   |  docker-init:
[S21 Final Project Pipeline/6. Docker Build                        ]   |   Version:          0.19.0
[S21 Final Project Pipeline/6. Docker Build                        ]   |   GitCommit:        de40ad0
[S21 Final Project Pipeline/6. Docker Build                        ]   | [command]/usr/bin/docker info
[S21 Final Project Pipeline/6. Docker Build                        ]   | Client:
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Version:    29.7.2-1
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Context:    default
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Debug Mode: false
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Plugins:
[S21 Final Project Pipeline/6. Docker Build                        ]   |   buildx: Docker Buildx (Docker Inc.)
[S21 Final Project Pipeline/6. Docker Build                        ]   |     Version:  0.36.1-1
[S21 Final Project Pipeline/6. Docker Build                        ]   |     Path:     /usr/libexec/docker/cli-plugins/docker-buildx
[S21 Final Project Pipeline/6. Docker Build                        ]   |   compose: Docker Compose (Docker Inc.)
[S21 Final Project Pipeline/6. Docker Build                        ]   |     Version:  5.4.0-2
[S21 Final Project Pipeline/6. Docker Build                        ]   |     Path:     /usr/libexec/docker/cli-plugins/docker-compose
[S21 Final Project Pipeline/6. Docker Build                        ]   | 
[S21 Final Project Pipeline/6. Docker Build                        ]   | Server:
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Containers: 28
[S21 Final Project Pipeline/6. Docker Build                        ]   |   Running: 9
[S21 Final Project Pipeline/6. Docker Build                        ]   |   Paused: 0
[S21 Final Project Pipeline/6. Docker Build                        ]   |   Stopped: 19
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Images: 90
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Server Version: 29.7.2
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Storage Driver: overlayfs
[S21 Final Project Pipeline/6. Docker Build                        ]   |   driver-type: io.containerd.snapshotter.v1
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Logging Driver: json-file
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Cgroup Driver: cgroupfs
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Cgroup Version: 2
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Plugins:
[S21 Final Project Pipeline/6. Docker Build                        ]   |   Volume: local
[S21 Final Project Pipeline/6. Docker Build                        ]   |   Network: bridge host ipvlan macvlan null overlay
[S21 Final Project Pipeline/6. Docker Build                        ]   |   Log: awslogs fluentd gcplogs gelf journald json-file local splunk syslog
[S21 Final Project Pipeline/6. Docker Build                        ]   |  CDI spec directories:
[S21 Final Project Pipeline/6. Docker Build                        ]   |   /etc/cdi
[S21 Final Project Pipeline/6. Docker Build                        ]   |   /var/run/cdi
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Discovered Devices:
[S21 Final Project Pipeline/6. Docker Build                        ]   |   cdi: docker.com/gpu=webgpu
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Swarm: inactive
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Runtimes: io.containerd.runc.v2 runc
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Default Runtime: runc
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Init Binary: docker-init
[S21 Final Project Pipeline/6. Docker Build                        ]   |  containerd version: e53c7c1516c3b2bff98eb76f1f4117477e6f4e66
[S21 Final Project Pipeline/6. Docker Build                        ]   |  runc version: v1.3.6-0-g491b69ba
[S21 Final Project Pipeline/6. Docker Build                        ]   |  init version: de40ad0
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Security Options:
[S21 Final Project Pipeline/6. Docker Build                        ]   |   seccomp
[S21 Final Project Pipeline/6. Docker Build                        ]   |    Profile: builtin
[S21 Final Project Pipeline/6. Docker Build                        ]   |   cgroupns
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Kernel Version: 7.0.12-linuxkit
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Operating System: Docker Desktop
[S21 Final Project Pipeline/6. Docker Build                        ]   |  OSType: linux
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Architecture: aarch64
[S21 Final Project Pipeline/6. Docker Build                        ]   |  CPUs: 15
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Total Memory: 11.67GiB
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Name: docker-desktop
[S21 Final Project Pipeline/6. Docker Build                        ]   |  ID: 9bd91c35-f158-4f23-93a7-e74dad678dac
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Docker Root Dir: /var/lib/docker
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Debug Mode: false
[S21 Final Project Pipeline/6. Docker Build                        ]   |  HTTP Proxy: http.docker.internal:3128
[S21 Final Project Pipeline/6. Docker Build                        ]   |  HTTPS Proxy: http.docker.internal:3128
[S21 Final Project Pipeline/6. Docker Build                        ]   |  No Proxy: hubproxy.docker.internal
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Labels:
[S21 Final Project Pipeline/6. Docker Build                        ]   |   com.docker.desktop.address=unix:///Users/kp/Library/Containers/com.docker.docker/Data/docker-cli.sock
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Experimental: false
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Insecure Registries:
[S21 Final Project Pipeline/6. Docker Build                        ]   |   hubproxy.docker.internal:5555
[S21 Final Project Pipeline/6. Docker Build                        ]   |   ::1/128
[S21 Final Project Pipeline/6. Docker Build                        ]   |   127.0.0.0/8
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Live Restore Enabled: false
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Firewall Backend: iptables
[S21 Final Project Pipeline/6. Docker Build                        ]   | 
[S21 Final Project Pipeline/6. Docker Build                        ]   ❓  ::endgroup::
[S21 Final Project Pipeline/6. Docker Build                        ]   ❓  ::group::Proxy configuration
[S21 Final Project Pipeline/6. Docker Build                        ]   | No proxy configuration found
[S21 Final Project Pipeline/6. Docker Build                        ]   ❓  ::endgroup::
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   ❓ add-matcher /run/act/actions/actions-checkout@8e8c483db84b4bee98b60c0593521ed34d9990e8/dist/problem-matcher.json
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | Syncing repository: aquasecurity/trivy
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   ❓  ::group::Getting Git version info
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | Working directory is '/Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment/trivy'
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | [command]/usr/bin/git version
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | git version 2.55.0
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   ❓  ::endgroup::
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   ⚙  ***
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | Temporarily overriding HOME='/tmp/1dff85c1-fb3e-44c2-8a9f-5e4f2d6fe410' before making global git config changes
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | Adding repository directory to the temporary git global config as a safe directory
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | [command]/usr/bin/git config --global --add safe.directory /Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment/trivy
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   ❓  ::group::Initializing the repository
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | [command]/usr/bin/git init /Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment/trivy
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | hint: Using 'master' as the name for the initial branch. This default branch name
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | hint: will change to "main" in Git 3.0. To configure the initial branch name
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | hint: to use in all of your new repositories, which will suppress this warning,
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | hint: call:
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | hint:
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | hint: 	git config --global init.defaultBranch <name>
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | hint:
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | hint: Names commonly chosen instead of 'master' are 'main', 'trunk' and
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | hint: 'development'. The just-created branch can be renamed via this command:
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | hint:
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | hint: 	git branch -m <name>
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | hint:
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | hint: Disable this message with "git config set advice.defaultBranchName false"
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | Initialized empty Git repository in /Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment/trivy/.git/
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | [command]/usr/bin/git remote add origin https://github.com/aquasecurity/trivy
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   ❓  ::endgroup::
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   ❓  ::group::Disabling automatic garbage collection
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | [command]/usr/bin/git config --local gc.auto 0
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   ❓  ::endgroup::
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   ❓  ::group::Setting up auth
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | Removing SSH command configuration
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | [command]/usr/bin/git config --local --name-only --get-regexp core\.sshCommand
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | [command]/usr/bin/git submodule foreach --recursive sh -c "git config --local --name-only --get-regexp 'core\.sshCommand' && git config --local --unset-all 'core.sshCommand' || :"
[S21 Final Project Pipeline/6. Docker Build                        ]   ❓  ::group::Buildx version
[S21 Final Project Pipeline/6. Docker Build                        ]   | [command]/usr/bin/docker buildx version
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | Removing HTTP extra header
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | [command]/usr/bin/git config --local --name-only --get-regexp http\.https\:\/\/github\.com\/\.extraheader
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | [command]/usr/bin/git submodule foreach --recursive sh -c "git config --local --name-only --get-regexp 'http\.https\:\/\/github\.com\/\.extraheader' && git config --local --unset-all 'http.https://github.com/.extraheader' || :"
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | Removing includeIf entries pointing to credentials config files
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | [command]/usr/bin/git config --local --name-only --get-regexp ^includeIf\.gitdir:
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | [command]/usr/bin/git submodule foreach --recursive git config --local --show-origin --name-only --get-regexp remote.origin.url
[S21 Final Project Pipeline/6. Docker Build                        ]   | github.com/docker/buildx 0.36.1-1 1d8dde89b8aba914e05e45366770736fea1fd690
[S21 Final Project Pipeline/6. Docker Build                        ]   ❓  ::endgroup::
[S21 Final Project Pipeline/6. Docker Build                        ]   ❓  ::group::Builder info
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | [command]/usr/bin/git config --file /tmp/git-credentials-c7090ded-24bd-42f9-b4a3-99fe7f54e4c5.config http.https://github.com/.extraheader AUTHORIZATION: basic ***
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | [command]/usr/bin/git config --local includeIf.gitdir:/Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment/trivy/.git.path /tmp/git-credentials-c7090ded-24bd-42f9-b4a3-99fe7f54e4c5.config
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | [command]/usr/bin/git config --local includeIf.gitdir:/Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment/trivy/.git/worktrees/*.path /tmp/git-credentials-c7090ded-24bd-42f9-b4a3-99fe7f54e4c5.config
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | [command]/usr/bin/git config --local includeIf.gitdir:/github/workspace/trivy/.git.path /github/runner_temp/git-credentials-c7090ded-24bd-42f9-b4a3-99fe7f54e4c5.config
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | [command]/usr/bin/git config --local includeIf.gitdir:/github/workspace/trivy/.git/worktrees/*.path /github/runner_temp/git-credentials-c7090ded-24bd-42f9-b4a3-99fe7f54e4c5.config
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   ❓  ::endgroup::
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   ❓  ::group::Fetching the repository
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | [command]/usr/bin/git -c protocol.version=2 fetch --no-tags --prune --no-recurse-submodules --filter=blob:none --depth=1 origin 75c4dc0f45c5d7ffd05ae26df1e0c666787bdf2a
[S21 Final Project Pipeline/6. Docker Build                        ]   | {
[S21 Final Project Pipeline/6. Docker Build                        ]   |   "nodes": [
[S21 Final Project Pipeline/6. Docker Build                        ]   |     {
[S21 Final Project Pipeline/6. Docker Build                        ]   |       "name": "default",
[S21 Final Project Pipeline/6. Docker Build                        ]   |       "endpoint": "default",
[S21 Final Project Pipeline/6. Docker Build                        ]   |       "status": "running",
[S21 Final Project Pipeline/6. Docker Build                        ]   |       "buildkit": "v0.32.2",
[S21 Final Project Pipeline/6. Docker Build                        ]   |       "platforms": "linux/arm64,linux/amd64,linux/amd64/v2,linux/riscv64,linux/ppc64le,linux/s390x,linux/386",
[S21 Final Project Pipeline/6. Docker Build                        ]   |       "features": {
[S21 Final Project Pipeline/6. Docker Build                        ]   |         "Automatically load images to the Docker Engine image store": true,
[S21 Final Project Pipeline/6. Docker Build                        ]   |         "Cache export": true,
[S21 Final Project Pipeline/6. Docker Build                        ]   |         "Direct push": true,
[S21 Final Project Pipeline/6. Docker Build                        ]   |         "Docker exporter": true,
[S21 Final Project Pipeline/6. Docker Build                        ]   |         "Multi-platform build": true,
[S21 Final Project Pipeline/6. Docker Build                        ]   |         "OCI exporter": true,
[S21 Final Project Pipeline/6. Docker Build                        ]   |         "Prefer image digest": true
[S21 Final Project Pipeline/6. Docker Build                        ]   |       },
[S21 Final Project Pipeline/6. Docker Build                        ]   |       "labels": {
[S21 Final Project Pipeline/6. Docker Build                        ]   |         "org.mobyproject.buildkit.worker.containerd.namespace": "moby",
[S21 Final Project Pipeline/6. Docker Build                        ]   |         "org.mobyproject.buildkit.worker.containerd.uuid": "901af005-849e-49c0-8694-c6cf43e5380c",
[S21 Final Project Pipeline/6. Docker Build                        ]   |         "org.mobyproject.buildkit.worker.executor": "containerd",
[S21 Final Project Pipeline/6. Docker Build                        ]   |         "org.mobyproject.buildkit.worker.hostname": "docker-desktop",
[S21 Final Project Pipeline/6. Docker Build                        ]   |         "org.mobyproject.buildkit.worker.moby.host-gateway-ip": "192.168.65.254",
[S21 Final Project Pipeline/6. Docker Build                        ]   |         "org.mobyproject.buildkit.worker.network": "host",
[S21 Final Project Pipeline/6. Docker Build                        ]   |         "org.mobyproject.buildkit.worker.selinux.enabled": "false",
[S21 Final Project Pipeline/6. Docker Build                        ]   |         "org.mobyproject.buildkit.worker.snapshotter": "overlayfs"
[S21 Final Project Pipeline/6. Docker Build                        ]   |       },
[S21 Final Project Pipeline/6. Docker Build                        ]   |       "devices": [
[S21 Final Project Pipeline/6. Docker Build                        ]   |         {
[S21 Final Project Pipeline/6. Docker Build                        ]   |           "name": "docker.com/gpu=webgpu",
[S21 Final Project Pipeline/6. Docker Build                        ]   |           "autoAllow": false
[S21 Final Project Pipeline/6. Docker Build                        ]   |         }
[S21 Final Project Pipeline/6. Docker Build                        ]   |       ],
[S21 Final Project Pipeline/6. Docker Build                        ]   |       "gcPolicy": [
[S21 Final Project Pipeline/6. Docker Build                        ]   |         {
[S21 Final Project Pipeline/6. Docker Build                        ]   |           "all": false,
[S21 Final Project Pipeline/6. Docker Build                        ]   |           "filter": [
[S21 Final Project Pipeline/6. Docker Build                        ]   |             "type==source.local type==exec.cachemount type==source.git.checkout"
[S21 Final Project Pipeline/6. Docker Build                        ]   |           ],
[S21 Final Project Pipeline/6. Docker Build                        ]   |           "keepDuration": "48h0m0s",
[S21 Final Project Pipeline/6. Docker Build                        ]   |           "maxUsedSpace": "2.764GiB"
[S21 Final Project Pipeline/6. Docker Build                        ]   |         },
[S21 Final Project Pipeline/6. Docker Build                        ]   |         {
[S21 Final Project Pipeline/6. Docker Build                        ]   |           "all": false,
[S21 Final Project Pipeline/6. Docker Build                        ]   |           "keepDuration": "1440h0m0s",
[S21 Final Project Pipeline/6. Docker Build                        ]   |           "reservedSpace": "20GiB"
[S21 Final Project Pipeline/6. Docker Build                        ]   |         },
[S21 Final Project Pipeline/6. Docker Build                        ]   |         {
[S21 Final Project Pipeline/6. Docker Build                        ]   |           "all": false,
[S21 Final Project Pipeline/6. Docker Build                        ]   |           "reservedSpace": "20GiB"
[S21 Final Project Pipeline/6. Docker Build                        ]   |         },
[S21 Final Project Pipeline/6. Docker Build                        ]   |         {
[S21 Final Project Pipeline/6. Docker Build                        ]   |           "all": true,
[S21 Final Project Pipeline/6. Docker Build                        ]   |           "reservedSpace": "20GiB"
[S21 Final Project Pipeline/6. Docker Build                        ]   |         }
[S21 Final Project Pipeline/6. Docker Build                        ]   |       ]
[S21 Final Project Pipeline/6. Docker Build                        ]   |     }
[S21 Final Project Pipeline/6. Docker Build                        ]   |   ],
[S21 Final Project Pipeline/6. Docker Build                        ]   |   "name": "default",
[S21 Final Project Pipeline/6. Docker Build                        ]   |   "driver": "docker"
[S21 Final Project Pipeline/6. Docker Build                        ]   | }
[S21 Final Project Pipeline/6. Docker Build                        ]   ❓  ::endgroup::
[S21 Final Project Pipeline/6. Docker Build                        ]   | [command]/usr/bin/docker buildx build --build-arg APP_VERSION=1.1.0 --build-arg GIT_SHA=3ba758e0669b9efc0a1ecd4b57040d1310aa1eef --file Final-DevOps-Project-&-Troubleshooting/docker/backend.Dockerfile --iidfile /tmp/docker-actions-toolkit-F4MBd3/build-iidfile-d8a75bef3e.txt --label org.opencontainers.image.source=https://github.com/kartavya37/DevOps-Assignment --output type=docker,dest=/tmp/backend.tar --tag ghcr.io/kartavya37/taskboard-backend:3ba758e0669b9efc0a1ecd4b57040d1310aa1eef --tag ghcr.io/kartavya37/taskboard-backend:latest --metadata-file /tmp/docker-actions-toolkit-F4MBd3/build-metadata-4d31fba225.json Final-DevOps-Project-&-Troubleshooting/application/backend
[S21 Final Project Pipeline/6. Docker Build                        ]   | #0 building with "default" instance using docker driver
[S21 Final Project Pipeline/6. Docker Build                        ]   | 
[S21 Final Project Pipeline/6. Docker Build                        ]   | #1 [internal] load build definition from backend.Dockerfile
[S21 Final Project Pipeline/6. Docker Build                        ]   | #1 DONE 0.0s
[S21 Final Project Pipeline/6. Docker Build                        ]   | 
[S21 Final Project Pipeline/6. Docker Build                        ]   | #1 [internal] load build definition from backend.Dockerfile
[S21 Final Project Pipeline/6. Docker Build                        ]   | #1 transferring dockerfile: 1.85kB done
[S21 Final Project Pipeline/6. Docker Build                        ]   | #1 DONE 0.0s
[S21 Final Project Pipeline/6. Docker Build                        ]   | 
[S21 Final Project Pipeline/6. Docker Build                        ]   | #2 [internal] load metadata for docker.io/library/python:3.13-slim
[S21 Final Project Pipeline/6. Docker Build                        ]   | #2 DONE 0.0s
[S21 Final Project Pipeline/6. Docker Build                        ]   | 
[S21 Final Project Pipeline/6. Docker Build                        ]   | #3 [internal] load .dockerignore
[S21 Final Project Pipeline/6. Docker Build                        ]   | #3 transferring context: 127B done
[S21 Final Project Pipeline/6. Docker Build                        ]   | #3 DONE 0.0s
[S21 Final Project Pipeline/6. Docker Build                        ]   | 
[S21 Final Project Pipeline/6. Docker Build                        ]   | #4 [build 1/4] FROM docker.io/library/python:3.13-slim@sha256:bf44cdfcb76cd3b41e879bc058fc37ec5872002ccfde7fcb765e218cde0cd79c
[S21 Final Project Pipeline/6. Docker Build                        ]   | #4 resolve docker.io/library/python:3.13-slim@sha256:bf44cdfcb76cd3b41e879bc058fc37ec5872002ccfde7fcb765e218cde0cd79c 0.0s done
[S21 Final Project Pipeline/6. Docker Build                        ]   | #4 DONE 0.0s
[S21 Final Project Pipeline/6. Docker Build                        ]   | 
[S21 Final Project Pipeline/6. Docker Build                        ]   | #5 [internal] load build context
[S21 Final Project Pipeline/6. Docker Build                        ]   | #5 transferring context: 12.66kB done
[S21 Final Project Pipeline/6. Docker Build                        ]   | #5 DONE 0.0s
[S21 Final Project Pipeline/6. Docker Build                        ]   | 
[S21 Final Project Pipeline/6. Docker Build                        ]   | #6 [runtime 5/7] COPY alembic.ini ./
[S21 Final Project Pipeline/6. Docker Build                        ]   | #6 CACHED
[S21 Final Project Pipeline/6. Docker Build                        ]   | 
[S21 Final Project Pipeline/6. Docker Build                        ]   | #7 [runtime 4/7] COPY --from=build /opt/venv /opt/venv
[S21 Final Project Pipeline/6. Docker Build                        ]   | #7 CACHED
[S21 Final Project Pipeline/6. Docker Build                        ]   | 
[S21 Final Project Pipeline/6. Docker Build                        ]   | #8 [runtime 6/7] COPY alembic ./alembic
[S21 Final Project Pipeline/6. Docker Build                        ]   | #8 CACHED
[S21 Final Project Pipeline/6. Docker Build                        ]   | 
[S21 Final Project Pipeline/6. Docker Build                        ]   | #9 [build 2/4] RUN python -m venv /opt/venv
[S21 Final Project Pipeline/6. Docker Build                        ]   | #9 CACHED
[S21 Final Project Pipeline/6. Docker Build                        ]   | 
[S21 Final Project Pipeline/6. Docker Build                        ]   | #10 [build 4/4] RUN pip install -r requirements.txt && pip uninstall -y pip
[S21 Final Project Pipeline/6. Docker Build                        ]   | #10 CACHED
[S21 Final Project Pipeline/6. Docker Build                        ]   | 
[S21 Final Project Pipeline/6. Docker Build                        ]   | #11 [build 3/4] COPY requirements.txt .
[S21 Final Project Pipeline/6. Docker Build                        ]   | #11 CACHED
[S21 Final Project Pipeline/6. Docker Build                        ]   | 
[S21 Final Project Pipeline/6. Docker Build                        ]   | #12 [runtime 2/7] RUN pip uninstall -y pip setuptools wheel 2>/dev/null || true     && useradd --uid 10001 --no-create-home --shell /usr/sbin/nologin appuser
[S21 Final Project Pipeline/6. Docker Build                        ]   | #12 CACHED
[S21 Final Project Pipeline/6. Docker Build                        ]   | 
[S21 Final Project Pipeline/6. Docker Build                        ]   | #13 [runtime 3/7] WORKDIR /app
[S21 Final Project Pipeline/6. Docker Build                        ]   | #13 CACHED
[S21 Final Project Pipeline/6. Docker Build                        ]   | 
[S21 Final Project Pipeline/6. Docker Build                        ]   | #14 [runtime 7/7] COPY app ./app
[S21 Final Project Pipeline/6. Docker Build                        ]   | #14 CACHED
[S21 Final Project Pipeline/6. Docker Build                        ]   | 
[S21 Final Project Pipeline/6. Docker Build                        ]   | #15 exporting to docker image format
[S21 Final Project Pipeline/6. Docker Build                        ]   | #15 exporting layers done
[S21 Final Project Pipeline/6. Docker Build                        ]   | #15 exporting manifest sha256:218b61234a39d5af09a2867608fe73b8767a6164002db59da859d4e4e970deb6 done
[S21 Final Project Pipeline/6. Docker Build                        ]   | #15 exporting config sha256:413a1a8220e5e4c237d32000ed74a76f372c5aca54486125b905142b8827b7db done
[S21 Final Project Pipeline/6. Docker Build                        ]   | #15 sending tarball
[S21 Final Project Pipeline/6. Docker Build                        ]   | #15 sending tarball 1.1s done
[S21 Final Project Pipeline/6. Docker Build                        ]   | #15 DONE 1.1s
[S21 Final Project Pipeline/6. Docker Build                        ]   | 
[S21 Final Project Pipeline/6. Docker Build                        ]   | #16 resolving provenance for metadata file
[S21 Final Project Pipeline/6. Docker Build                        ]   | #16 DONE 0.0s
[S21 Final Project Pipeline/6. Docker Build                        ]   ❓  ::group::ImageID
[S21 Final Project Pipeline/6. Docker Build                        ]   | sha256:413a1a8220e5e4c237d32000ed74a76f372c5aca54486125b905142b8827b7db
[S21 Final Project Pipeline/6. Docker Build                        ]   ❓  ::endgroup::
[S21 Final Project Pipeline/6. Docker Build                        ]   ❓  ::group::Digest
[S21 Final Project Pipeline/6. Docker Build                        ]   | sha256:218b61234a39d5af09a2867608fe73b8767a6164002db59da859d4e4e970deb6
[S21 Final Project Pipeline/6. Docker Build                        ]   ❓  ::endgroup::
[S21 Final Project Pipeline/6. Docker Build                        ]   ❓  ::group::Metadata
[S21 Final Project Pipeline/6. Docker Build                        ]   ⚙  ::stop-commands::a2671d70-ee57-4297-ab0c-d7e0f1463900
[S21 Final Project Pipeline/6. Docker Build                        ]   | {
[S21 Final Project Pipeline/6. Docker Build                        ]   |   "buildx.build.provenance": {
[S21 Final Project Pipeline/6. Docker Build                        ]   |     "builder": {
[S21 Final Project Pipeline/6. Docker Build                        ]   |       "id": ""
[S21 Final Project Pipeline/6. Docker Build                        ]   |     },
[S21 Final Project Pipeline/6. Docker Build                        ]   |     "buildType": "https://mobyproject.org/buildkit@v1",
[S21 Final Project Pipeline/6. Docker Build                        ]   |     "materials": [
[S21 Final Project Pipeline/6. Docker Build                        ]   |       {
[S21 Final Project Pipeline/6. Docker Build                        ]   |         "uri": "pkg:docker/python@3.13-slim?platform=linux%2Farm64",
[S21 Final Project Pipeline/6. Docker Build                        ]   |         "digest": {
[S21 Final Project Pipeline/6. Docker Build                        ]   |           "sha256": "bf44cdfcb76cd3b41e879bc058fc37ec5872002ccfde7fcb765e218cde0cd79c"
[S21 Final Project Pipeline/6. Docker Build                        ]   |         }
[S21 Final Project Pipeline/6. Docker Build                        ]   |       }
[S21 Final Project Pipeline/6. Docker Build                        ]   |     ],
[S21 Final Project Pipeline/6. Docker Build                        ]   |     "invocation": {
[S21 Final Project Pipeline/6. Docker Build                        ]   |       "configSource": {
[S21 Final Project Pipeline/6. Docker Build                        ]   |         "entryPoint": "backend.Dockerfile"
[S21 Final Project Pipeline/6. Docker Build                        ]   |       },
[S21 Final Project Pipeline/6. Docker Build                        ]   |       "parameters": {
[S21 Final Project Pipeline/6. Docker Build                        ]   |         "frontend": "dockerfile.v0",
[S21 Final Project Pipeline/6. Docker Build                        ]   |         "args": {
[S21 Final Project Pipeline/6. Docker Build                        ]   |           "build-arg:APP_VERSION": "1.1.0",
[S21 Final Project Pipeline/6. Docker Build                        ]   |           "build-arg:GIT_SHA": "3ba758e0669b9efc0a1ecd4b57040d1310aa1eef",
[S21 Final Project Pipeline/6. Docker Build                        ]   |           "label:org.opencontainers.image.source": "https://github.com/kartavya37/DevOps-Assignment"
[S21 Final Project Pipeline/6. Docker Build                        ]   |         },
[S21 Final Project Pipeline/6. Docker Build                        ]   |         "locals": [
[S21 Final Project Pipeline/6. Docker Build                        ]   |           {
[S21 Final Project Pipeline/6. Docker Build                        ]   |             "name": "context"
[S21 Final Project Pipeline/6. Docker Build                        ]   |           },
[S21 Final Project Pipeline/6. Docker Build                        ]   |           {
[S21 Final Project Pipeline/6. Docker Build                        ]   |             "name": "dockerfile"
[S21 Final Project Pipeline/6. Docker Build                        ]   |           }
[S21 Final Project Pipeline/6. Docker Build                        ]   |         ],
[S21 Final Project Pipeline/6. Docker Build                        ]   |         "root": {
[S21 Final Project Pipeline/6. Docker Build                        ]   |           "configSource": {
[S21 Final Project Pipeline/6. Docker Build                        ]   |             "path": "backend.Dockerfile"
[S21 Final Project Pipeline/6. Docker Build                        ]   |           },
[S21 Final Project Pipeline/6. Docker Build                        ]   |           "request": {
[S21 Final Project Pipeline/6. Docker Build                        ]   |             "args": {
[S21 Final Project Pipeline/6. Docker Build                        ]   |               "build-arg:APP_VERSION": "1.1.0",
[S21 Final Project Pipeline/6. Docker Build                        ]   |               "build-arg:GIT_SHA": "3ba758e0669b9efc0a1ecd4b57040d1310aa1eef",
[S21 Final Project Pipeline/6. Docker Build                        ]   |               "label:org.opencontainers.image.source": "https://github.com/kartavya37/DevOps-Assignment",
[S21 Final Project Pipeline/6. Docker Build                        ]   |               "vcs:localdir:context": "Final-DevOps-Project-&-Troubleshooting/application/backend",
[S21 Final Project Pipeline/6. Docker Build                        ]   |               "vcs:localdir:dockerfile": "Final-DevOps-Project-&-Troubleshooting/docker",
[S21 Final Project Pipeline/6. Docker Build                        ]   |               "vcs:revision": "3ba758e0669b9efc0a1ecd4b57040d1310aa1eef",
[S21 Final Project Pipeline/6. Docker Build                        ]   |               "vcs:source": "https://github.com/kartavya37/DevOps-Assignment.git"
[S21 Final Project Pipeline/6. Docker Build                        ]   |             }
[S21 Final Project Pipeline/6. Docker Build                        ]   |           }
[S21 Final Project Pipeline/6. Docker Build                        ]   |         },
[S21 Final Project Pipeline/6. Docker Build                        ]   |         "compatibilityVersion": 30
[S21 Final Project Pipeline/6. Docker Build                        ]   |       },
[S21 Final Project Pipeline/6. Docker Build                        ]   |       "environment": {
[S21 Final Project Pipeline/6. Docker Build                        ]   |         "dockerfileVersion": "1.26.0",
[S21 Final Project Pipeline/6. Docker Build                        ]   |         "platform": "linux/arm64"
[S21 Final Project Pipeline/6. Docker Build                        ]   |       }
[S21 Final Project Pipeline/6. Docker Build                        ]   |     }
[S21 Final Project Pipeline/6. Docker Build                        ]   |   },
[S21 Final Project Pipeline/6. Docker Build                        ]   |   "buildx.build.ref": "default/default/ulja44iqgppj8o2m6ps1talho",
[S21 Final Project Pipeline/6. Docker Build                        ]   |   "containerimage.config.digest": "sha256:413a1a8220e5e4c237d32000ed74a76f372c5aca54486125b905142b8827b7db",
[S21 Final Project Pipeline/6. Docker Build                        ]   |   "containerimage.descriptor": {
[S21 Final Project Pipeline/6. Docker Build                        ]   |     "mediaType": "application/vnd.oci.image.manifest.v1+json",
[S21 Final Project Pipeline/6. Docker Build                        ]   |     "digest": "sha256:218b61234a39d5af09a2867608fe73b8767a6164002db59da859d4e4e970deb6",
[S21 Final Project Pipeline/6. Docker Build                        ]   |     "size": 2190,
[S21 Final Project Pipeline/6. Docker Build                        ]   |     "annotations": {
[S21 Final Project Pipeline/6. Docker Build                        ]   |       "org.opencontainers.image.created": "2026-10-07T14:00:36Z"
[S21 Final Project Pipeline/6. Docker Build                        ]   |     },
[S21 Final Project Pipeline/6. Docker Build                        ]   |     "platform": {
[S21 Final Project Pipeline/6. Docker Build                        ]   |       "architecture": "arm64",
[S21 Final Project Pipeline/6. Docker Build                        ]   |       "os": "linux"
[S21 Final Project Pipeline/6. Docker Build                        ]   |     }
[S21 Final Project Pipeline/6. Docker Build                        ]   |   },
[S21 Final Project Pipeline/6. Docker Build                        ]   |   "containerimage.digest": "sha256:218b61234a39d5af09a2867608fe73b8767a6164002db59da859d4e4e970deb6",
[S21 Final Project Pipeline/6. Docker Build                        ]   |   "image.name": "ghcr.io/kartavya37/taskboard-backend:3ba758e0669b9efc0a1ecd4b57040d1310aa1eef,ghcr.io/kartavya37/taskboard-backend:latest"
[S21 Final Project Pipeline/6. Docker Build                        ]   | }
[S21 Final Project Pipeline/6. Docker Build                        ]   ⚙  ::a2671d70-ee57-4297-ab0c-d7e0f1463900::
[S21 Final Project Pipeline/6. Docker Build                        ]   ❓  ::endgroup::
[S21 Final Project Pipeline/6. Docker Build                        ]   ❓  ::group::Reference
[S21 Final Project Pipeline/6. Docker Build                        ]   | default/default/ulja44iqgppj8o2m6ps1talho
[S21 Final Project Pipeline/6. Docker Build                        ]   ❓  ::endgroup::
[S21 Final Project Pipeline/6. Docker Build                        ]   ❓  ::group::Check build summary support
[S21 Final Project Pipeline/6. Docker Build                        ]   | Build summary supported!
[S21 Final Project Pipeline/6. Docker Build                        ]   ❓  ::endgroup::
[S21 Final Project Pipeline/6. Docker Build                        ]   ✅  Success - Main Build the backend image (tag = Git commit SHA) [3.983568541s]
[S21 Final Project Pipeline/6. Docker Build                        ]   ⚙  ::set-output:: imageid=sha256:413a1a8220e5e4c237d32000ed74a76f372c5aca54486125b905142b8827b7db
[S21 Final Project Pipeline/6. Docker Build                        ]   ⚙  ::set-output:: digest=sha256:218b61234a39d5af09a2867608fe73b8767a6164002db59da859d4e4e970deb6
[S21 Final Project Pipeline/6. Docker Build                        ]   ⚙  ::set-output:: metadata={
  "buildx.build.provenance": {
    "builder": {
      "id": ""
    },
    "buildType": "https://mobyproject.org/buildkit@v1",
    "materials": [
      {
        "uri": "pkg:docker/python@3.13-slim?platform=linux%2Farm64",
        "digest": {
          "sha256": "bf44cdfcb76cd3b41e879bc058fc37ec5872002ccfde7fcb765e218cde0cd79c"
        }
      }
    ],
    "invocation": {
      "configSource": {
        "entryPoint": "backend.Dockerfile"
      },
      "parameters": {
        "frontend": "dockerfile.v0",
        "args": {
          "build-arg:APP_VERSION": "1.1.0",
          "build-arg:GIT_SHA": "3ba758e0669b9efc0a1ecd4b57040d1310aa1eef",
          "label:org.opencontainers.image.source": "https://github.com/kartavya37/DevOps-Assignment"
        },
        "locals": [
          {
            "name": "context"
          },
          {
            "name": "dockerfile"
          }
        ],
        "root": {
          "configSource": {
            "path": "backend.Dockerfile"
          },
          "request": {
            "args": {
              "build-arg:APP_VERSION": "1.1.0",
              "build-arg:GIT_SHA": "3ba758e0669b9efc0a1ecd4b57040d1310aa1eef",
              "label:org.opencontainers.image.source": "https://github.com/kartavya37/DevOps-Assignment",
              "vcs:localdir:context": "Final-DevOps-Project-&-Troubleshooting/application/backend",
              "vcs:localdir:dockerfile": "Final-DevOps-Project-&-Troubleshooting/docker",
              "vcs:revision": "3ba758e0669b9efc0a1ecd4b57040d1310aa1eef",
              "vcs:source": "https://github.com/kartavya37/DevOps-Assignment.git"
            }
          }
        },
        "compatibilityVersion": 30
      },
      "environment": {
        "dockerfileVersion": "1.26.0",
        "platform": "linux/arm64"
      }
    }
  },
  "buildx.build.ref": "default/default/ulja44iqgppj8o2m6ps1talho",
  "containerimage.config.digest": "sha256:413a1a8220e5e4c237d32000ed74a76f372c5aca54486125b905142b8827b7db",
  "containerimage.descriptor": {
    "mediaType": "application/vnd.oci.image.manifest.v1+json",
    "digest": "sha256:218b61234a39d5af09a2867608fe73b8767a6164002db59da859d4e4e970deb6",
    "size": 2190,
    "annotations": {
      "org.opencontainers.image.created": "2026-10-07T14:00:36Z"
    },
    "platform": {
      "architecture": "arm64",
      "os": "linux"
    }
  },
  "containerimage.digest": "sha256:218b61234a39d5af09a2867608fe73b8767a6164002db59da859d4e4e970deb6",
  "image.name": "ghcr.io/kartavya37/taskboard-backend:3ba758e0669b9efc0a1ecd4b57040d1310aa1eef,ghcr.io/kartavya37/taskboard-backend:latest"
}
[S21 Final Project Pipeline/6. Docker Build                        ] ⭐ Run Main Build the frontend image (tag = Git commit SHA)
[S21 Final Project Pipeline/6. Docker Build                        ]   🐳  docker cp src=/Users/kp/.cache/act/docker-build-push-action@v7/ dst=/var/run/act/actions/docker-build-push-action@v7/
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | From https://github.com/aquasecurity/trivy
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   |  * branch            75c4dc0f45c5d7ffd05ae26df1e0c666787bdf2a -> FETCH_HEAD
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   ❓  ::endgroup::
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   ❓  ::group::Determining the checkout info
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   ❓  ::endgroup::
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   ❓  ::group::Setting up sparse checkout
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | [command]/usr/bin/git sparse-checkout set contrib
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   ❓  ::endgroup::
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   ❓  ::group::Checking out the ref
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | [command]/usr/bin/git checkout --progress --force 75c4dc0f45c5d7ffd05ae26df1e0c666787bdf2a
[S21 Final Project Pipeline/6. Docker Build                        ]   🐳  docker exec cmd=[/opt/acttoolcache/node/24.19.0/arm64/bin/node /var/run/act/actions/docker-build-push-action@v7/dist/index.cjs] user= workdir=
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | Updating files:   3% (1/28)Updating files:   7% (2/28)Updating files:  10% (3/28)Updating files:  14% (4/28)Updating files:  17% (5/28)Updating files:  21% (6/28)Updating files:  25% (7/28)Updating files:  28% (8/28)Updating files:  32% (9/28)Updating files:  35% (10/28)Updating files:  39% (11/28)Updating files:  42% (12/28)Updating files:  46% (13/28)Updating files:  50% (14/28)Updating files:  53% (15/28)Updating files:  57% (16/28)Updating files:  60% (17/28)Updating files:  64% (18/28)Updating files:  67% (19/28)Updating files:  71% (20/28)Updating files:  75% (21/28)Updating files:  78% (22/28)Updating files:  82% (23/28)Updating files:  85% (24/28)Updating files:  89% (25/28)Updating files:  92% (26/28)Updating files:  96% (27/28)Updating files: 100% (28/28)Updating files: 100% (28/28), done.
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | Note: switching to '75c4dc0f45c5d7ffd05ae26df1e0c666787bdf2a'.
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | 
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | You are in 'detached HEAD' state. You can look around, make experimental
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | changes and commit them, and you can discard any commits you make in this
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | state without impacting any branches by switching back to a branch.
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | 
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | If you want to create a new branch to retain commits you create, you may
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | do so (now or later) by using -c with the switch command. Example:
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | 
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   |   git switch -c <new-branch-name>
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | 
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | Or undo this operation with:
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | 
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   |   git switch -
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | 
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | Turn off this advice by setting config variable advice.detachedHead to false
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | 
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | HEAD is now at 75c4dc0 chore: add client option to install script (#9962)
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   ❓  ::endgroup::
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | [command]/usr/bin/git log -1 --format=%H
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | 75c4dc0f45c5d7ffd05ae26df1e0c666787bdf2a
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   ❓  ::remove-matcher owner=checkout-git::
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   ✅  Success - Main Checkout install script [3.977979208s]
[S21 Final Project Pipeline/6. Docker Build                        ]   ❓  ::group::GitHub Actions runtime token ACs
[S21 Final Project Pipeline/6. Docker Build                        ]   | : write
[S21 Final Project Pipeline/6. Docker Build                        ]   ❓  ::endgroup::
[S21 Final Project Pipeline/6. Docker Build                        ]   ❓  ::group::Docker info
[S21 Final Project Pipeline/6. Docker Build                        ]   | [command]/usr/bin/docker version
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   ⚙  ::set-output:: commit=75c4dc0f45c5d7ffd05ae26df1e0c666787bdf2a
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   ⚙  ::set-output:: ref=
[S21 Final Project Pipeline/6. Docker Build                        ]   | Client:
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Version:           29.7.2-1
[S21 Final Project Pipeline/6. Docker Build                        ]   |  API version:       1.55
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Go version:        go1.26.5
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Git commit:        a7dcaa6fdb6ed04aacbfdc76357fdae01605609e
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Built:             Fri Aug  7 10:40:54 2026
[S21 Final Project Pipeline/6. Docker Build                        ]   |  OS/Arch:           linux/arm64
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Context:           default
[S21 Final Project Pipeline/6. Docker Build                        ]   | 
[S21 Final Project Pipeline/6. Docker Build                        ]   | Server: Docker Desktop 4.87.0 (236836)
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Engine:
[S21 Final Project Pipeline/6. Docker Build                        ]   |   Version:          29.7.2
[S21 Final Project Pipeline/6. Docker Build                        ]   |   API version:      1.55 (minimum version 1.40)
[S21 Final Project Pipeline/6. Docker Build                        ]   |   Go version:       go1.26.5
[S21 Final Project Pipeline/6. Docker Build                        ]   |   Git commit:       6a43e3d
[S21 Final Project Pipeline/6. Docker Build                        ]   |   Built:            Wed Aug  5 18:28:35 2026
[S21 Final Project Pipeline/6. Docker Build                        ]   |   OS/Arch:          linux/arm64
[S21 Final Project Pipeline/6. Docker Build                        ]   |   Experimental:     false
[S21 Final Project Pipeline/6. Docker Build                        ]   |  containerd:
[S21 Final Project Pipeline/6. Docker Build                        ]   |   Version:          v2.2.5
[S21 Final Project Pipeline/6. Docker Build                        ]   |   GitCommit:        e53c7c1516c3b2bff98eb76f1f4117477e6f4e66
[S21 Final Project Pipeline/6. Docker Build                        ]   |  runc:
[S21 Final Project Pipeline/6. Docker Build                        ]   |   Version:          1.3.6
[S21 Final Project Pipeline/6. Docker Build                        ]   |   GitCommit:        v1.3.6-0-g491b69ba
[S21 Final Project Pipeline/6. Docker Build                        ]   |  docker-init:
[S21 Final Project Pipeline/6. Docker Build                        ]   |   Version:          0.19.0
[S21 Final Project Pipeline/6. Docker Build                        ]   |   GitCommit:        de40ad0
[S21 Final Project Pipeline/6. Docker Build                        ]   | [command]/usr/bin/docker info
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ] ⭐ Run Main Install Trivy
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   🐳  docker exec cmd=[bash --noprofile --norc -e -o pipefail /var/run/act/workflow/2-composite-0-composite-4.sh] user= workdir=
[S21 Final Project Pipeline/6. Docker Build                        ]   | Client:
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Version:    29.7.2-1
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Context:    default
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Debug Mode: false
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Plugins:
[S21 Final Project Pipeline/6. Docker Build                        ]   |   buildx: Docker Buildx (Docker Inc.)
[S21 Final Project Pipeline/6. Docker Build                        ]   |     Version:  0.36.1-1
[S21 Final Project Pipeline/6. Docker Build                        ]   |     Path:     /usr/libexec/docker/cli-plugins/docker-buildx
[S21 Final Project Pipeline/6. Docker Build                        ]   |   compose: Docker Compose (Docker Inc.)
[S21 Final Project Pipeline/6. Docker Build                        ]   |     Version:  5.4.0-2
[S21 Final Project Pipeline/6. Docker Build                        ]   |     Path:     /usr/libexec/docker/cli-plugins/docker-compose
[S21 Final Project Pipeline/6. Docker Build                        ]   | 
[S21 Final Project Pipeline/6. Docker Build                        ]   | Server:
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Containers: 28
[S21 Final Project Pipeline/6. Docker Build                        ]   |   Running: 9
[S21 Final Project Pipeline/6. Docker Build                        ]   |   Paused: 0
[S21 Final Project Pipeline/6. Docker Build                        ]   |   Stopped: 19
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Images: 90
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Server Version: 29.7.2
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Storage Driver: overlayfs
[S21 Final Project Pipeline/6. Docker Build                        ]   |   driver-type: io.containerd.snapshotter.v1
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Logging Driver: json-file
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Cgroup Driver: cgroupfs
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Cgroup Version: 2
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Plugins:
[S21 Final Project Pipeline/6. Docker Build                        ]   |   Volume: local
[S21 Final Project Pipeline/6. Docker Build                        ]   |   Network: bridge host ipvlan macvlan null overlay
[S21 Final Project Pipeline/6. Docker Build                        ]   |   Log: awslogs fluentd gcplogs gelf journald json-file local splunk syslog
[S21 Final Project Pipeline/6. Docker Build                        ]   |  CDI spec directories:
[S21 Final Project Pipeline/6. Docker Build                        ]   |   /etc/cdi
[S21 Final Project Pipeline/6. Docker Build                        ]   |   /var/run/cdi
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Discovered Devices:
[S21 Final Project Pipeline/6. Docker Build                        ]   |   cdi: docker.com/gpu=webgpu
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Swarm: inactive
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Runtimes: io.containerd.runc.v2 runc
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Default Runtime: runc
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Init Binary: docker-init
[S21 Final Project Pipeline/6. Docker Build                        ]   |  containerd version: e53c7c1516c3b2bff98eb76f1f4117477e6f4e66
[S21 Final Project Pipeline/6. Docker Build                        ]   |  runc version: v1.3.6-0-g491b69ba
[S21 Final Project Pipeline/6. Docker Build                        ]   |  init version: de40ad0
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Security Options:
[S21 Final Project Pipeline/6. Docker Build                        ]   |   seccomp
[S21 Final Project Pipeline/6. Docker Build                        ]   |    Profile: builtin
[S21 Final Project Pipeline/6. Docker Build                        ]   |   cgroupns
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Kernel Version: 7.0.12-linuxkit
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Operating System: Docker Desktop
[S21 Final Project Pipeline/6. Docker Build                        ]   |  OSType: linux
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Architecture: aarch64
[S21 Final Project Pipeline/6. Docker Build                        ]   |  CPUs: 15
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Total Memory: 11.67GiB
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Name: docker-desktop
[S21 Final Project Pipeline/6. Docker Build                        ]   |  ID: 9bd91c35-f158-4f23-93a7-e74dad678dac
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Docker Root Dir: /var/lib/docker
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Debug Mode: false
[S21 Final Project Pipeline/6. Docker Build                        ]   |  HTTP Proxy: http.docker.internal:3128
[S21 Final Project Pipeline/6. Docker Build                        ]   |  HTTPS Proxy: http.docker.internal:3128
[S21 Final Project Pipeline/6. Docker Build                        ]   |  No Proxy: hubproxy.docker.internal
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Labels:
[S21 Final Project Pipeline/6. Docker Build                        ]   |   com.docker.desktop.address=unix:///Users/kp/Library/Containers/com.docker.docker/Data/docker-cli.sock
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Experimental: false
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Insecure Registries:
[S21 Final Project Pipeline/6. Docker Build                        ]   |   hubproxy.docker.internal:5555
[S21 Final Project Pipeline/6. Docker Build                        ]   |   ::1/128
[S21 Final Project Pipeline/6. Docker Build                        ]   |   127.0.0.0/8
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Live Restore Enabled: false
[S21 Final Project Pipeline/6. Docker Build                        ]   |  Firewall Backend: iptables
[S21 Final Project Pipeline/6. Docker Build                        ]   | 
[S21 Final Project Pipeline/6. Docker Build                        ]   ❓  ::endgroup::
[S21 Final Project Pipeline/6. Docker Build                        ]   ❓  ::group::Proxy configuration
[S21 Final Project Pipeline/6. Docker Build                        ]   | No proxy configuration found
[S21 Final Project Pipeline/6. Docker Build                        ]   ❓  ::endgroup::
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | installing Trivy binary
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | aquasecurity/trivy info checking GitHub for tag 'v0.75.0'
[S21 Final Project Pipeline/6. Docker Build                        ]   ❓  ::group::Buildx version
[S21 Final Project Pipeline/6. Docker Build                        ]   | [command]/usr/bin/docker buildx version
[S21 Final Project Pipeline/6. Docker Build                        ]   | github.com/docker/buildx 0.36.1-1 1d8dde89b8aba914e05e45366770736fea1fd690
[S21 Final Project Pipeline/6. Docker Build                        ]   ❓  ::endgroup::
[S21 Final Project Pipeline/6. Docker Build                        ]   ❓  ::group::Builder info
[S21 Final Project Pipeline/6. Docker Build                        ]   | {
[S21 Final Project Pipeline/6. Docker Build                        ]   |   "nodes": [
[S21 Final Project Pipeline/6. Docker Build                        ]   |     {
[S21 Final Project Pipeline/6. Docker Build                        ]   |       "name": "default",
[S21 Final Project Pipeline/6. Docker Build                        ]   |       "endpoint": "default",
[S21 Final Project Pipeline/6. Docker Build                        ]   |       "status": "running",
[S21 Final Project Pipeline/6. Docker Build                        ]   |       "buildkit": "v0.32.2",
[S21 Final Project Pipeline/6. Docker Build                        ]   |       "platforms": "linux/arm64,linux/amd64,linux/amd64/v2,linux/riscv64,linux/ppc64le,linux/s390x,linux/386",
[S21 Final Project Pipeline/6. Docker Build                        ]   |       "features": {
[S21 Final Project Pipeline/6. Docker Build                        ]   |         "Automatically load images to the Docker Engine image store": true,
[S21 Final Project Pipeline/6. Docker Build                        ]   |         "Cache export": true,
[S21 Final Project Pipeline/6. Docker Build                        ]   |         "Direct push": true,
[S21 Final Project Pipeline/6. Docker Build                        ]   |         "Docker exporter": true,
[S21 Final Project Pipeline/6. Docker Build                        ]   |         "Multi-platform build": true,
[S21 Final Project Pipeline/6. Docker Build                        ]   |         "OCI exporter": true,
[S21 Final Project Pipeline/6. Docker Build                        ]   |         "Prefer image digest": true
[S21 Final Project Pipeline/6. Docker Build                        ]   |       },
[S21 Final Project Pipeline/6. Docker Build                        ]   |       "labels": {
[S21 Final Project Pipeline/6. Docker Build                        ]   |         "org.mobyproject.buildkit.worker.containerd.namespace": "moby",
[S21 Final Project Pipeline/6. Docker Build                        ]   |         "org.mobyproject.buildkit.worker.containerd.uuid": "901af005-849e-49c0-8694-c6cf43e5380c",
[S21 Final Project Pipeline/6. Docker Build                        ]   |         "org.mobyproject.buildkit.worker.executor": "containerd",
[S21 Final Project Pipeline/6. Docker Build                        ]   |         "org.mobyproject.buildkit.worker.hostname": "docker-desktop",
[S21 Final Project Pipeline/6. Docker Build                        ]   |         "org.mobyproject.buildkit.worker.moby.host-gateway-ip": "192.168.65.254",
[S21 Final Project Pipeline/6. Docker Build                        ]   |         "org.mobyproject.buildkit.worker.network": "host",
[S21 Final Project Pipeline/6. Docker Build                        ]   |         "org.mobyproject.buildkit.worker.selinux.enabled": "false",
[S21 Final Project Pipeline/6. Docker Build                        ]   |         "org.mobyproject.buildkit.worker.snapshotter": "overlayfs"
[S21 Final Project Pipeline/6. Docker Build                        ]   |       },
[S21 Final Project Pipeline/6. Docker Build                        ]   |       "devices": [
[S21 Final Project Pipeline/6. Docker Build                        ]   |         {
[S21 Final Project Pipeline/6. Docker Build                        ]   |           "name": "docker.com/gpu=webgpu",
[S21 Final Project Pipeline/6. Docker Build                        ]   |           "autoAllow": false
[S21 Final Project Pipeline/6. Docker Build                        ]   |         }
[S21 Final Project Pipeline/6. Docker Build                        ]   |       ],
[S21 Final Project Pipeline/6. Docker Build                        ]   |       "gcPolicy": [
[S21 Final Project Pipeline/6. Docker Build                        ]   |         {
[S21 Final Project Pipeline/6. Docker Build                        ]   |           "all": false,
[S21 Final Project Pipeline/6. Docker Build                        ]   |           "filter": [
[S21 Final Project Pipeline/6. Docker Build                        ]   |             "type==source.local type==exec.cachemount type==source.git.checkout"
[S21 Final Project Pipeline/6. Docker Build                        ]   |           ],
[S21 Final Project Pipeline/6. Docker Build                        ]   |           "keepDuration": "48h0m0s",
[S21 Final Project Pipeline/6. Docker Build                        ]   |           "maxUsedSpace": "2.764GiB"
[S21 Final Project Pipeline/6. Docker Build                        ]   |         },
[S21 Final Project Pipeline/6. Docker Build                        ]   |         {
[S21 Final Project Pipeline/6. Docker Build                        ]   |           "all": false,
[S21 Final Project Pipeline/6. Docker Build                        ]   |           "keepDuration": "1440h0m0s",
[S21 Final Project Pipeline/6. Docker Build                        ]   |           "reservedSpace": "20GiB"
[S21 Final Project Pipeline/6. Docker Build                        ]   |         },
[S21 Final Project Pipeline/6. Docker Build                        ]   |         {
[S21 Final Project Pipeline/6. Docker Build                        ]   |           "all": false,
[S21 Final Project Pipeline/6. Docker Build                        ]   |           "reservedSpace": "20GiB"
[S21 Final Project Pipeline/6. Docker Build                        ]   |         },
[S21 Final Project Pipeline/6. Docker Build                        ]   |         {
[S21 Final Project Pipeline/6. Docker Build                        ]   |           "all": true,
[S21 Final Project Pipeline/6. Docker Build                        ]   |           "reservedSpace": "20GiB"
[S21 Final Project Pipeline/6. Docker Build                        ]   |         }
[S21 Final Project Pipeline/6. Docker Build                        ]   |       ]
[S21 Final Project Pipeline/6. Docker Build                        ]   |     }
[S21 Final Project Pipeline/6. Docker Build                        ]   |   ],
[S21 Final Project Pipeline/6. Docker Build                        ]   |   "name": "default",
[S21 Final Project Pipeline/6. Docker Build                        ]   |   "driver": "docker",
[S21 Final Project Pipeline/6. Docker Build                        ]   |   "lastActivity": "2026-10-07T14:00:36.000Z"
[S21 Final Project Pipeline/6. Docker Build                        ]   | }
[S21 Final Project Pipeline/6. Docker Build                        ]   ❓  ::endgroup::
[S21 Final Project Pipeline/6. Docker Build                        ]   | [command]/usr/bin/docker buildx build --build-arg APP_VERSION=1.1.0 --build-arg GIT_SHA=3ba758e0669b9efc0a1ecd4b57040d1310aa1eef --file Final-DevOps-Project-&-Troubleshooting/docker/frontend.Dockerfile --iidfile /tmp/docker-actions-toolkit-zoaBhd/build-iidfile-022f9860d3.txt --label org.opencontainers.image.source=https://github.com/kartavya37/DevOps-Assignment --output type=docker,dest=/tmp/frontend.tar --tag ghcr.io/kartavya37/taskboard-frontend:3ba758e0669b9efc0a1ecd4b57040d1310aa1eef --tag ghcr.io/kartavya37/taskboard-frontend:latest --metadata-file /tmp/docker-actions-toolkit-zoaBhd/build-metadata-7f2b6c6998.json Final-DevOps-Project-&-Troubleshooting/application/frontend
[S21 Final Project Pipeline/6. Docker Build                        ]   | #0 building with "default" instance using docker driver
[S21 Final Project Pipeline/6. Docker Build                        ]   | 
[S21 Final Project Pipeline/6. Docker Build                        ]   | #1 [internal] load build definition from frontend.Dockerfile
[S21 Final Project Pipeline/6. Docker Build                        ]   | #1 transferring dockerfile: 1.69kB done
[S21 Final Project Pipeline/6. Docker Build                        ]   | #1 DONE 0.0s
[S21 Final Project Pipeline/6. Docker Build                        ]   | 
[S21 Final Project Pipeline/6. Docker Build                        ]   | #2 [internal] load metadata for docker.io/library/nginx:1.31-alpine
[S21 Final Project Pipeline/6. Docker Build                        ]   | #2 DONE 0.0s
[S21 Final Project Pipeline/6. Docker Build                        ]   | 
[S21 Final Project Pipeline/6. Docker Build                        ]   | #3 [internal] load metadata for docker.io/library/node:22-alpine
[S21 Final Project Pipeline/6. Docker Build                        ]   | #3 DONE 0.0s
[S21 Final Project Pipeline/6. Docker Build                        ]   | 
[S21 Final Project Pipeline/6. Docker Build                        ]   | #4 [internal] load .dockerignore
[S21 Final Project Pipeline/6. Docker Build                        ]   | #4 transferring context: 63B done
[S21 Final Project Pipeline/6. Docker Build                        ]   | #4 DONE 0.0s
[S21 Final Project Pipeline/6. Docker Build                        ]   | 
[S21 Final Project Pipeline/6. Docker Build                        ]   | #5 [build 1/7] FROM docker.io/library/node:22-alpine@sha256:0a7108bf6c7bf5de370ffb1a3ed6be93d405b43ff159f681a8d18c0e2bc2e402
[S21 Final Project Pipeline/6. Docker Build                        ]   | #5 resolve docker.io/library/node:22-alpine@sha256:0a7108bf6c7bf5de370ffb1a3ed6be93d405b43ff159f681a8d18c0e2bc2e402 0.0s done
[S21 Final Project Pipeline/6. Docker Build                        ]   | #5 DONE 0.0s
[S21 Final Project Pipeline/6. Docker Build                        ]   | 
[S21 Final Project Pipeline/6. Docker Build                        ]   | #6 [runtime 1/4] FROM docker.io/library/nginx:1.31-alpine@sha256:df221db836e1754089190208cee7eeda94f233197056426eda74a43ab1abeac2
[S21 Final Project Pipeline/6. Docker Build                        ]   | #6 resolve docker.io/library/nginx:1.31-alpine@sha256:df221db836e1754089190208cee7eeda94f233197056426eda74a43ab1abeac2 0.0s done
[S21 Final Project Pipeline/6. Docker Build                        ]   | #6 DONE 0.0s
[S21 Final Project Pipeline/6. Docker Build                        ]   | 
[S21 Final Project Pipeline/6. Docker Build                        ]   | #7 [internal] load build context
[S21 Final Project Pipeline/6. Docker Build                        ]   | #7 transferring context: 42.26kB done
[S21 Final Project Pipeline/6. Docker Build                        ]   | #7 DONE 0.0s
[S21 Final Project Pipeline/6. Docker Build                        ]   | 
[S21 Final Project Pipeline/6. Docker Build                        ]   | #8 [build 2/7] WORKDIR /app
[S21 Final Project Pipeline/6. Docker Build                        ]   | #8 CACHED
[S21 Final Project Pipeline/6. Docker Build                        ]   | 
[S21 Final Project Pipeline/6. Docker Build                        ]   | #9 [build 3/7] COPY package.json package-lock.json ./
[S21 Final Project Pipeline/6. Docker Build                        ]   | #9 CACHED
[S21 Final Project Pipeline/6. Docker Build                        ]   | 
[S21 Final Project Pipeline/6. Docker Build                        ]   | #10 [build 5/7] COPY index.html vite.config.js ./
[S21 Final Project Pipeline/6. Docker Build                        ]   | #10 CACHED
[S21 Final Project Pipeline/6. Docker Build                        ]   | 
[S21 Final Project Pipeline/6. Docker Build                        ]   | #11 [runtime 2/4] RUN apk upgrade --no-cache     && sed -i -e '/^user /d' -e 's#^pid .*#pid /tmp/nginx.pid;#' /etc/nginx/nginx.conf     && sed -i '/^http {/a \    client_body_temp_path /tmp/client_temp;\n    proxy_temp_path /tmp/proxy_temp;\n    fastcgi_temp_path /tmp/fastcgi_temp;\n    uwsgi_temp_path /tmp/uwsgi_temp;\n    scgi_temp_path /tmp/scgi_temp;' /etc/nginx/nginx.conf     && rm -f /etc/nginx/conf.d/default.conf     && chown -R 101:101 /etc/nginx/conf.d /var/cache/nginx
[S21 Final Project Pipeline/6. Docker Build                        ]   | #11 CACHED
[S21 Final Project Pipeline/6. Docker Build                        ]   | 
[S21 Final Project Pipeline/6. Docker Build                        ]   | #12 [build 4/7] RUN npm ci --no-audit --no-fund
[S21 Final Project Pipeline/6. Docker Build                        ]   | #12 CACHED
[S21 Final Project Pipeline/6. Docker Build                        ]   | 
[S21 Final Project Pipeline/6. Docker Build                        ]   | #13 [build 7/7] RUN npm run build
[S21 Final Project Pipeline/6. Docker Build                        ]   | #13 CACHED
[S21 Final Project Pipeline/6. Docker Build                        ]   | 
[S21 Final Project Pipeline/6. Docker Build                        ]   | #14 [build 6/7] COPY src ./src
[S21 Final Project Pipeline/6. Docker Build                        ]   | #14 CACHED
[S21 Final Project Pipeline/6. Docker Build                        ]   | 
[S21 Final Project Pipeline/6. Docker Build                        ]   | #15 [runtime 3/4] COPY nginx.conf.template /etc/nginx/templates/default.conf.template
[S21 Final Project Pipeline/6. Docker Build                        ]   | #15 CACHED
[S21 Final Project Pipeline/6. Docker Build                        ]   | 
[S21 Final Project Pipeline/6. Docker Build                        ]   | #16 [runtime 4/4] COPY --from=build /app/dist /usr/share/nginx/html
[S21 Final Project Pipeline/6. Docker Build                        ]   | #16 CACHED
[S21 Final Project Pipeline/6. Docker Build                        ]   | 
[S21 Final Project Pipeline/6. Docker Build                        ]   | #17 exporting to docker image format
[S21 Final Project Pipeline/6. Docker Build                        ]   | #17 exporting layers done
[S21 Final Project Pipeline/6. Docker Build                        ]   | #17 exporting manifest sha256:c316999bcfe0e1964f9e6ff9deed63ab7cb010a5b26106214c77283e733c428a done
[S21 Final Project Pipeline/6. Docker Build                        ]   | #17 exporting config sha256:80f810877b7cf3022ed322ee9ae6c0032b2c44e5a26b81ded734b8dc65b8ee84 done
[S21 Final Project Pipeline/6. Docker Build                        ]   | #17 sending tarball
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | aquasecurity/trivy info found version: 0.75.0 for v0.75.0/Linux/ARM64
[S21 Final Project Pipeline/6. Docker Build                        ]   | #17 sending tarball 0.4s done
[S21 Final Project Pipeline/6. Docker Build                        ]   | #17 DONE 0.4s
[S21 Final Project Pipeline/6. Docker Build                        ]   | 
[S21 Final Project Pipeline/6. Docker Build                        ]   | #18 resolving provenance for metadata file
[S21 Final Project Pipeline/6. Docker Build                        ]   | #18 DONE 0.0s
[S21 Final Project Pipeline/6. Docker Build                        ]   ❓  ::group::ImageID
[S21 Final Project Pipeline/6. Docker Build                        ]   | sha256:80f810877b7cf3022ed322ee9ae6c0032b2c44e5a26b81ded734b8dc65b8ee84
[S21 Final Project Pipeline/6. Docker Build                        ]   ❓  ::endgroup::
[S21 Final Project Pipeline/6. Docker Build                        ]   ❓  ::group::Digest
[S21 Final Project Pipeline/6. Docker Build                        ]   | sha256:c316999bcfe0e1964f9e6ff9deed63ab7cb010a5b26106214c77283e733c428a
[S21 Final Project Pipeline/6. Docker Build                        ]   ❓  ::endgroup::
[S21 Final Project Pipeline/6. Docker Build                        ]   ❓  ::group::Metadata
[S21 Final Project Pipeline/6. Docker Build                        ]   ⚙  ::stop-commands::0f966381-c066-445f-b063-2312f5bebb5b
[S21 Final Project Pipeline/6. Docker Build                        ]   | {
[S21 Final Project Pipeline/6. Docker Build                        ]   |   "buildx.build.provenance": {
[S21 Final Project Pipeline/6. Docker Build                        ]   |     "builder": {
[S21 Final Project Pipeline/6. Docker Build                        ]   |       "id": ""
[S21 Final Project Pipeline/6. Docker Build                        ]   |     },
[S21 Final Project Pipeline/6. Docker Build                        ]   |     "buildType": "https://mobyproject.org/buildkit@v1",
[S21 Final Project Pipeline/6. Docker Build                        ]   |     "materials": [
[S21 Final Project Pipeline/6. Docker Build                        ]   |       {
[S21 Final Project Pipeline/6. Docker Build                        ]   |         "uri": "pkg:docker/nginx@1.31-alpine?platform=linux%2Farm64",
[S21 Final Project Pipeline/6. Docker Build                        ]   |         "digest": {
[S21 Final Project Pipeline/6. Docker Build                        ]   |           "sha256": "df221db836e1754089190208cee7eeda94f233197056426eda74a43ab1abeac2"
[S21 Final Project Pipeline/6. Docker Build                        ]   |         }
[S21 Final Project Pipeline/6. Docker Build                        ]   |       },
[S21 Final Project Pipeline/6. Docker Build                        ]   |       {
[S21 Final Project Pipeline/6. Docker Build                        ]   |         "uri": "pkg:docker/node@22-alpine?platform=linux%2Farm64",
[S21 Final Project Pipeline/6. Docker Build                        ]   |         "digest": {
[S21 Final Project Pipeline/6. Docker Build                        ]   |           "sha256": "0a7108bf6c7bf5de370ffb1a3ed6be93d405b43ff159f681a8d18c0e2bc2e402"
[S21 Final Project Pipeline/6. Docker Build                        ]   |         }
[S21 Final Project Pipeline/6. Docker Build                        ]   |       }
[S21 Final Project Pipeline/6. Docker Build                        ]   |     ],
[S21 Final Project Pipeline/6. Docker Build                        ]   |     "invocation": {
[S21 Final Project Pipeline/6. Docker Build                        ]   |       "configSource": {
[S21 Final Project Pipeline/6. Docker Build                        ]   |         "entryPoint": "frontend.Dockerfile"
[S21 Final Project Pipeline/6. Docker Build                        ]   |       },
[S21 Final Project Pipeline/6. Docker Build                        ]   |       "parameters": {
[S21 Final Project Pipeline/6. Docker Build                        ]   |         "frontend": "dockerfile.v0",
[S21 Final Project Pipeline/6. Docker Build                        ]   |         "args": {
[S21 Final Project Pipeline/6. Docker Build                        ]   |           "build-arg:APP_VERSION": "1.1.0",
[S21 Final Project Pipeline/6. Docker Build                        ]   |           "build-arg:GIT_SHA": "3ba758e0669b9efc0a1ecd4b57040d1310aa1eef",
[S21 Final Project Pipeline/6. Docker Build                        ]   |           "label:org.opencontainers.image.source": "https://github.com/kartavya37/DevOps-Assignment"
[S21 Final Project Pipeline/6. Docker Build                        ]   |         },
[S21 Final Project Pipeline/6. Docker Build                        ]   |         "locals": [
[S21 Final Project Pipeline/6. Docker Build                        ]   |           {
[S21 Final Project Pipeline/6. Docker Build                        ]   |             "name": "context"
[S21 Final Project Pipeline/6. Docker Build                        ]   |           },
[S21 Final Project Pipeline/6. Docker Build                        ]   |           {
[S21 Final Project Pipeline/6. Docker Build                        ]   |             "name": "dockerfile"
[S21 Final Project Pipeline/6. Docker Build                        ]   |           }
[S21 Final Project Pipeline/6. Docker Build                        ]   |         ],
[S21 Final Project Pipeline/6. Docker Build                        ]   |         "root": {
[S21 Final Project Pipeline/6. Docker Build                        ]   |           "configSource": {
[S21 Final Project Pipeline/6. Docker Build                        ]   |             "path": "frontend.Dockerfile"
[S21 Final Project Pipeline/6. Docker Build                        ]   |           },
[S21 Final Project Pipeline/6. Docker Build                        ]   |           "request": {
[S21 Final Project Pipeline/6. Docker Build                        ]   |             "args": {
[S21 Final Project Pipeline/6. Docker Build                        ]   |               "build-arg:APP_VERSION": "1.1.0",
[S21 Final Project Pipeline/6. Docker Build                        ]   |               "build-arg:GIT_SHA": "3ba758e0669b9efc0a1ecd4b57040d1310aa1eef",
[S21 Final Project Pipeline/6. Docker Build                        ]   |               "label:org.opencontainers.image.source": "https://github.com/kartavya37/DevOps-Assignment",
[S21 Final Project Pipeline/6. Docker Build                        ]   |               "vcs:localdir:context": "Final-DevOps-Project-&-Troubleshooting/application/frontend",
[S21 Final Project Pipeline/6. Docker Build                        ]   |               "vcs:localdir:dockerfile": "Final-DevOps-Project-&-Troubleshooting/docker",
[S21 Final Project Pipeline/6. Docker Build                        ]   |               "vcs:revision": "3ba758e0669b9efc0a1ecd4b57040d1310aa1eef",
[S21 Final Project Pipeline/6. Docker Build                        ]   |               "vcs:source": "https://github.com/kartavya37/DevOps-Assignment.git"
[S21 Final Project Pipeline/6. Docker Build                        ]   |             }
[S21 Final Project Pipeline/6. Docker Build                        ]   |           }
[S21 Final Project Pipeline/6. Docker Build                        ]   |         },
[S21 Final Project Pipeline/6. Docker Build                        ]   |         "compatibilityVersion": 30
[S21 Final Project Pipeline/6. Docker Build                        ]   |       },
[S21 Final Project Pipeline/6. Docker Build                        ]   |       "environment": {
[S21 Final Project Pipeline/6. Docker Build                        ]   |         "dockerfileVersion": "1.26.0",
[S21 Final Project Pipeline/6. Docker Build                        ]   |         "platform": "linux/arm64"
[S21 Final Project Pipeline/6. Docker Build                        ]   |       }
[S21 Final Project Pipeline/6. Docker Build                        ]   |     }
[S21 Final Project Pipeline/6. Docker Build                        ]   |   },
[S21 Final Project Pipeline/6. Docker Build                        ]   |   "buildx.build.ref": "default/default/juk08gm60q5cn8vz2aej4frkz",
[S21 Final Project Pipeline/6. Docker Build                        ]   |   "containerimage.config.digest": "sha256:80f810877b7cf3022ed322ee9ae6c0032b2c44e5a26b81ded734b8dc65b8ee84",
[S21 Final Project Pipeline/6. Docker Build                        ]   |   "containerimage.descriptor": {
[S21 Final Project Pipeline/6. Docker Build                        ]   |     "mediaType": "application/vnd.oci.image.manifest.v1+json",
[S21 Final Project Pipeline/6. Docker Build                        ]   |     "digest": "sha256:c316999bcfe0e1964f9e6ff9deed63ab7cb010a5b26106214c77283e733c428a",
[S21 Final Project Pipeline/6. Docker Build                        ]   |     "size": 2379,
[S21 Final Project Pipeline/6. Docker Build                        ]   |     "annotations": {
[S21 Final Project Pipeline/6. Docker Build                        ]   |       "org.opencontainers.image.created": "2026-10-07T14:00:39Z"
[S21 Final Project Pipeline/6. Docker Build                        ]   |     },
[S21 Final Project Pipeline/6. Docker Build                        ]   |     "platform": {
[S21 Final Project Pipeline/6. Docker Build                        ]   |       "architecture": "arm64",
[S21 Final Project Pipeline/6. Docker Build                        ]   |       "os": "linux"
[S21 Final Project Pipeline/6. Docker Build                        ]   |     }
[S21 Final Project Pipeline/6. Docker Build                        ]   |   },
[S21 Final Project Pipeline/6. Docker Build                        ]   |   "containerimage.digest": "sha256:c316999bcfe0e1964f9e6ff9deed63ab7cb010a5b26106214c77283e733c428a",
[S21 Final Project Pipeline/6. Docker Build                        ]   |   "image.name": "ghcr.io/kartavya37/taskboard-frontend:3ba758e0669b9efc0a1ecd4b57040d1310aa1eef,ghcr.io/kartavya37/taskboard-frontend:latest"
[S21 Final Project Pipeline/6. Docker Build                        ]   | }
[S21 Final Project Pipeline/6. Docker Build                        ]   ⚙  ::0f966381-c066-445f-b063-2312f5bebb5b::
[S21 Final Project Pipeline/6. Docker Build                        ]   ❓  ::endgroup::
[S21 Final Project Pipeline/6. Docker Build                        ]   ❓  ::group::Reference
[S21 Final Project Pipeline/6. Docker Build                        ]   | default/default/juk08gm60q5cn8vz2aej4frkz
[S21 Final Project Pipeline/6. Docker Build                        ]   ❓  ::endgroup::
[S21 Final Project Pipeline/6. Docker Build                        ]   ❓  ::group::Check build summary support
[S21 Final Project Pipeline/6. Docker Build                        ]   | Build summary supported!
[S21 Final Project Pipeline/6. Docker Build                        ]   ❓  ::endgroup::
[S21 Final Project Pipeline/6. Docker Build                        ]   ✅  Success - Main Build the frontend image (tag = Git commit SHA) [2.408228167s]
[S21 Final Project Pipeline/6. Docker Build                        ]   ⚙  ::set-output:: imageid=sha256:80f810877b7cf3022ed322ee9ae6c0032b2c44e5a26b81ded734b8dc65b8ee84
[S21 Final Project Pipeline/6. Docker Build                        ]   ⚙  ::set-output:: digest=sha256:c316999bcfe0e1964f9e6ff9deed63ab7cb010a5b26106214c77283e733c428a
[S21 Final Project Pipeline/6. Docker Build                        ]   ⚙  ::set-output:: metadata={
  "buildx.build.provenance": {
    "builder": {
      "id": ""
    },
    "buildType": "https://mobyproject.org/buildkit@v1",
    "materials": [
      {
        "uri": "pkg:docker/nginx@1.31-alpine?platform=linux%2Farm64",
        "digest": {
          "sha256": "df221db836e1754089190208cee7eeda94f233197056426eda74a43ab1abeac2"
        }
      },
      {
        "uri": "pkg:docker/node@22-alpine?platform=linux%2Farm64",
        "digest": {
          "sha256": "0a7108bf6c7bf5de370ffb1a3ed6be93d405b43ff159f681a8d18c0e2bc2e402"
        }
      }
    ],
    "invocation": {
      "configSource": {
        "entryPoint": "frontend.Dockerfile"
      },
      "parameters": {
        "frontend": "dockerfile.v0",
        "args": {
          "build-arg:APP_VERSION": "1.1.0",
          "build-arg:GIT_SHA": "3ba758e0669b9efc0a1ecd4b57040d1310aa1eef",
          "label:org.opencontainers.image.source": "https://github.com/kartavya37/DevOps-Assignment"
        },
        "locals": [
          {
            "name": "context"
          },
          {
            "name": "dockerfile"
          }
        ],
        "root": {
          "configSource": {
            "path": "frontend.Dockerfile"
          },
          "request": {
            "args": {
              "build-arg:APP_VERSION": "1.1.0",
              "build-arg:GIT_SHA": "3ba758e0669b9efc0a1ecd4b57040d1310aa1eef",
              "label:org.opencontainers.image.source": "https://github.com/kartavya37/DevOps-Assignment",
              "vcs:localdir:context": "Final-DevOps-Project-&-Troubleshooting/application/frontend",
              "vcs:localdir:dockerfile": "Final-DevOps-Project-&-Troubleshooting/docker",
              "vcs:revision": "3ba758e0669b9efc0a1ecd4b57040d1310aa1eef",
              "vcs:source": "https://github.com/kartavya37/DevOps-Assignment.git"
            }
          }
        },
        "compatibilityVersion": 30
      },
      "environment": {
        "dockerfileVersion": "1.26.0",
        "platform": "linux/arm64"
      }
    }
  },
  "buildx.build.ref": "default/default/juk08gm60q5cn8vz2aej4frkz",
  "containerimage.config.digest": "sha256:80f810877b7cf3022ed322ee9ae6c0032b2c44e5a26b81ded734b8dc65b8ee84",
  "containerimage.descriptor": {
    "mediaType": "application/vnd.oci.image.manifest.v1+json",
    "digest": "sha256:c316999bcfe0e1964f9e6ff9deed63ab7cb010a5b26106214c77283e733c428a",
    "size": 2379,
    "annotations": {
      "org.opencontainers.image.created": "2026-10-07T14:00:39Z"
    },
    "platform": {
      "architecture": "arm64",
      "os": "linux"
    }
  },
  "containerimage.digest": "sha256:c316999bcfe0e1964f9e6ff9deed63ab7cb010a5b26106214c77283e733c428a",
  "image.name": "ghcr.io/kartavya37/taskboard-frontend:3ba758e0669b9efc0a1ecd4b57040d1310aa1eef,ghcr.io/kartavya37/taskboard-frontend:latest"
}
[S21 Final Project Pipeline/6. Docker Build                        ] ⭐ Run Main Upload the image tar files (the same images go to scan, push and deploy)
[S21 Final Project Pipeline/6. Docker Build                        ]   🐳  docker cp src=/Users/kp/.cache/act/actions-upload-artifact@v4/ dst=/var/run/act/actions/actions-upload-artifact@v4/
[S21 Final Project Pipeline/6. Docker Build                        ]   🐳  docker exec cmd=[/opt/acttoolcache/node/24.19.0/arm64/bin/node /var/run/act/actions/actions-upload-artifact@v4/dist/upload/index.js] user= workdir=
[S21 Final Project Pipeline/6. Docker Build                        ]   | (node:798) [DEP0040] DeprecationWarning: The `punycode` module is deprecated. Please use a userland alternative instead.
[S21 Final Project Pipeline/6. Docker Build                        ]   | (Use `node --trace-deprecation ...` to show where the warning was created)
[S21 Final Project Pipeline/6. Docker Build                        ]   | Multiple search paths detected. Calculating the least common ancestor of all paths
[S21 Final Project Pipeline/6. Docker Build                        ]   | The least common ancestor is /tmp. This will be the root directory of the artifact
[S21 Final Project Pipeline/6. Docker Build                        ]   | With the provided path, there will be 2 files uploaded
[S21 Final Project Pipeline/6. Docker Build                        ]   | Artifact name is valid!
[S21 Final Project Pipeline/6. Docker Build                        ]   | Root directory input is valid!
[S21 Final Project Pipeline/6. Docker Build                        ]   | Beginning upload of artifact content to blob storage
[S21 Final Project Pipeline/6. Docker Build                        ]   | (node:798) [DEP0169] DeprecationWarning: `url.parse()` behavior is not standardized and prone to errors that have security implications. Use the WHATWG URL API instead. CVEs are not issued for `url.parse()` vulnerabilities.
[S21 Final Project Pipeline/6. Docker Build                        ]   | Uploaded bytes 8388608
[S21 Final Project Pipeline/6. Docker Build                        ]   | Uploaded bytes 16777216
[S21 Final Project Pipeline/6. Docker Build                        ]   | Uploaded bytes 25165824
[S21 Final Project Pipeline/6. Docker Build                        ]   | Uploaded bytes 33554432
[S21 Final Project Pipeline/6. Docker Build                        ]   | Uploaded bytes 41943040
[S21 Final Project Pipeline/6. Docker Build                        ]   | Uploaded bytes 50331648
[S21 Final Project Pipeline/6. Docker Build                        ]   | Uploaded bytes 58720256
[S21 Final Project Pipeline/6. Docker Build                        ]   | Uploaded bytes 67108864
[S21 Final Project Pipeline/6. Docker Build                        ]   | Uploaded bytes 75497472
[S21 Final Project Pipeline/6. Docker Build                        ]   | Uploaded bytes 83886080
[S21 Final Project Pipeline/6. Docker Build                        ]   | Uploaded bytes 92274688
[S21 Final Project Pipeline/6. Docker Build                        ]   | Uploaded bytes 100663296
[S21 Final Project Pipeline/6. Docker Build                        ]   | Uploaded bytes 101735592
[S21 Final Project Pipeline/6. Docker Build                        ]   | Finished uploading artifact content to blob storage!
[S21 Final Project Pipeline/6. Docker Build                        ]   | SHA256 digest of uploaded artifact zip is 62e277eee5f4bfbaaf58a12f90c67dd4016a7284137abdcf0ba665db70b0bb7a
[S21 Final Project Pipeline/6. Docker Build                        ]   | Finalizing artifact upload
[S21 Final Project Pipeline/6. Docker Build                        ]   | Artifact docker-images.zip successfully finalized. Artifact ID 2254189770
[S21 Final Project Pipeline/6. Docker Build                        ]   | Artifact docker-images has been successfully uploaded! Final size is 101735592 bytes. Artifact ID is 2254189770
[S21 Final Project Pipeline/6. Docker Build                        ]   | Artifact download URL: https://github.com/kartavya37/DevOps-Assignment/actions/runs/1/artifacts/2254189770
[S21 Final Project Pipeline/6. Docker Build                        ]   ✅  Success - Main Upload the image tar files (the same images go to scan, push and deploy) [2.4303595s]
[S21 Final Project Pipeline/6. Docker Build                        ]   ⚙  ::set-output:: artifact-digest=62e277eee5f4bfbaaf58a12f90c67dd4016a7284137abdcf0ba665db70b0bb7a
[S21 Final Project Pipeline/6. Docker Build                        ]   ⚙  ::set-output:: artifact-url=https://github.com/kartavya37/DevOps-Assignment/actions/runs/1/artifacts/2254189770
[S21 Final Project Pipeline/6. Docker Build                        ]   ⚙  ::set-output:: artifact-id=2254189770
[S21 Final Project Pipeline/6. Docker Build                        ] ⭐ Run Post Build the frontend image (tag = Git commit SHA)
[S21 Final Project Pipeline/6. Docker Build                        ]   🐳  docker exec cmd=[/opt/acttoolcache/node/24.19.0/arm64/bin/node /var/run/act/actions/docker-build-push-action@v7/dist/index.cjs] user= workdir=
[S21 Final Project Pipeline/6. Docker Build                        ]   ❓  ::group::Generating build summary
[S21 Final Project Pipeline/6. Docker Build                        ]   | exporting build record to /tmp/docker-actions-toolkit-rnCeKN/export
[S21 Final Project Pipeline/6. Docker Build                        ]   | [command]/usr/bin/docker buildx history export --builder default --output /tmp/docker-actions-toolkit-rnCeKN/export/kartavya37~DevOps-Assignment~JUK08G.dockerbuild juk08gm60q5cn8vz2aej4frkz --finalize
[S21 Final Project Pipeline/6. Docker Build                        ]   | Build record written to /tmp/docker-actions-toolkit-rnCeKN/export/kartavya37~DevOps-Assignment~JUK08G.dockerbuild (16.74 KB)
[S21 Final Project Pipeline/6. Docker Build                        ]   | Writing summary
[S21 Final Project Pipeline/6. Docker Build                        ]   ❓  ::endgroup::
[S21 Final Project Pipeline/6. Docker Build                        ]   ❓  ::group::Removing temp folder /tmp/docker-actions-toolkit-zoaBhd
[S21 Final Project Pipeline/6. Docker Build                        ]   ❓  ::endgroup::
[S21 Final Project Pipeline/6. Docker Build                        ]   ❓  ::group::Post cache
[S21 Final Project Pipeline/6. Docker Build                        ]   | State not set
[S21 Final Project Pipeline/6. Docker Build                        ]   ❓  ::endgroup::
[S21 Final Project Pipeline/6. Docker Build                        ]   ✅  Success - Post Build the frontend image (tag = Git commit SHA) [406.834166ms]
[S21 Final Project Pipeline/6. Docker Build                        ]   ⚙  Summary - <h2>Docker Build summary</h2>
<p>The following table provides a brief summary of your build.<br>
For a detailed look at the build, including timing, dependencies, results, logs, traces, and other information, consider enabling the export of the build record so you can import it into Docker Desktop's Builds view. <a href="https://www.docker.com/blog/new-beta-feature-deep-dive-into-github-actions-docker-builds-with-docker-desktop/?utm_source=github&utm_medium=actions">Learn more</a></p><p>Find this useful? <a href="https://docs.docker.com/feedback/gha-build-summary">Let us know</a></p><p><table><tr><th>ID</th><th>Name</th><th>Status</th><th>Cached</th><th>Duration</th></tr><tr><td><code>JUK08G</code></td><td><strong>&#x46;&#x69;&#x6e;&#x61;&#x6c;&#x2d;&#x44;&#x65;&#x76;&#x4f;&#x70;&#x73;&#x2d;&#x50;&#x72;&#x6f;&#x6a;&#x65;&#x63;&#x74;&#x2d;&#x26;&#x2d;&#x54;&#x72;&#x6f;&#x75;&#x62;&#x6c;&#x65;&#x73;&#x68;&#x6f;&#x6f;&#x74;&#x69;&#x6e;&#x67;&#x2f;&#x61;&#x70;&#x70;&#x6c;&#x69;&#x63;&#x61;&#x74;&#x69;&#x6f;&#x6e;&#x2f;&#x66;&#x72;&#x6f;&#x6e;&#x74;&#x65;&#x6e;&#x64;</strong></td><td>:white_check_mark: completed</td><td>53%</td><td>0s</td></tr></table>
</p><details><summary><strong>Build inputs</strong></summary><pre lang="yaml"><code>build-args:
  - APP_VERSION=1.1.0
  - GIT_SHA=3ba758e0669b9efc0a1ecd4b57040d1310aa1eef
context: Final-DevOps-Project-&-Troubleshooting/application/frontend
file: Final-DevOps-Project-&-Troubleshooting/docker/frontend.Dockerfile
labels:
  - org.opencontainers.image.source=https://github.com/kartavya37/DevOps-Assignment
outputs:
  - type=docker,dest=/tmp/frontend.tar
tags:
  - ghcr.io/kartavya37/taskboard-frontend:3ba758e0669b9efc0a1ecd4b57040d1310aa1eef
  - ghcr.io/kartavya37/taskboard-frontend:latest
</code></pre>
</details><hr>
[S21 Final Project Pipeline/6. Docker Build                        ] ⭐ Run Post Build the backend image (tag = Git commit SHA)
[S21 Final Project Pipeline/6. Docker Build                        ]   🐳  docker exec cmd=[/opt/acttoolcache/node/24.19.0/arm64/bin/node /var/run/act/actions/docker-build-push-action@v7/dist/index.cjs] user= workdir=
[S21 Final Project Pipeline/6. Docker Build                        ]   ❓  ::group::Generating build summary
[S21 Final Project Pipeline/6. Docker Build                        ]   | exporting build record to /tmp/docker-actions-toolkit-pVUCBR/export
[S21 Final Project Pipeline/6. Docker Build                        ]   | [command]/usr/bin/docker buildx history export --builder default --output /tmp/docker-actions-toolkit-pVUCBR/export/kartavya37~DevOps-Assignment~ULJA44.dockerbuild ulja44iqgppj8o2m6ps1talho --finalize
[S21 Final Project Pipeline/6. Docker Build                        ]   | Build record written to /tmp/docker-actions-toolkit-pVUCBR/export/kartavya37~DevOps-Assignment~ULJA44.dockerbuild (16.34 KB)
[S21 Final Project Pipeline/6. Docker Build                        ]   | Writing summary
[S21 Final Project Pipeline/6. Docker Build                        ]   ❓  ::endgroup::
[S21 Final Project Pipeline/6. Docker Build                        ]   ❓  ::group::Removing temp folder /tmp/docker-actions-toolkit-F4MBd3
[S21 Final Project Pipeline/6. Docker Build                        ]   ❓  ::endgroup::
[S21 Final Project Pipeline/6. Docker Build                        ]   ❓  ::group::Post cache
[S21 Final Project Pipeline/6. Docker Build                        ]   | State not set
[S21 Final Project Pipeline/6. Docker Build                        ]   ❓  ::endgroup::
[S21 Final Project Pipeline/6. Docker Build                        ]   ✅  Success - Post Build the backend image (tag = Git commit SHA) [401.698042ms]
[S21 Final Project Pipeline/6. Docker Build                        ]   ⚙  Summary - <h2>Docker Build summary</h2>
<p>The following table provides a brief summary of your build.<br>
For a detailed look at the build, including timing, dependencies, results, logs, traces, and other information, consider enabling the export of the build record so you can import it into Docker Desktop's Builds view. <a href="https://www.docker.com/blog/new-beta-feature-deep-dive-into-github-actions-docker-builds-with-docker-desktop/?utm_source=github&utm_medium=actions">Learn more</a></p><p>Find this useful? <a href="https://docs.docker.com/feedback/gha-build-summary">Let us know</a></p><p><table><tr><th>ID</th><th>Name</th><th>Status</th><th>Cached</th><th>Duration</th></tr><tr><td><code>ULJA44</code></td><td><strong>&#x46;&#x69;&#x6e;&#x61;&#x6c;&#x2d;&#x44;&#x65;&#x76;&#x4f;&#x70;&#x73;&#x2d;&#x50;&#x72;&#x6f;&#x6a;&#x65;&#x63;&#x74;&#x2d;&#x26;&#x2d;&#x54;&#x72;&#x6f;&#x75;&#x62;&#x6c;&#x65;&#x73;&#x68;&#x6f;&#x6f;&#x74;&#x69;&#x6e;&#x67;&#x2f;&#x61;&#x70;&#x70;&#x6c;&#x69;&#x63;&#x61;&#x74;&#x69;&#x6f;&#x6e;&#x2f;&#x62;&#x61;&#x63;&#x6b;&#x65;&#x6e;&#x64;</strong></td><td>:white_check_mark: completed</td><td>60%</td><td>1s</td></tr></table>
</p><details><summary><strong>Build inputs</strong></summary><pre lang="yaml"><code>build-args:
  - APP_VERSION=1.1.0
  - GIT_SHA=3ba758e0669b9efc0a1ecd4b57040d1310aa1eef
context: Final-DevOps-Project-&-Troubleshooting/application/backend
file: Final-DevOps-Project-&-Troubleshooting/docker/backend.Dockerfile
labels:
  - org.opencontainers.image.source=https://github.com/kartavya37/DevOps-Assignment
outputs:
  - type=docker,dest=/tmp/backend.tar
tags:
  - ghcr.io/kartavya37/taskboard-backend:3ba758e0669b9efc0a1ecd4b57040d1310aa1eef
  - ghcr.io/kartavya37/taskboard-backend:latest
</code></pre>
</details><hr>
[S21 Final Project Pipeline/6. Docker Build                        ] ⭐ Run Post Set up Docker Buildx
[S21 Final Project Pipeline/6. Docker Build                        ]   🐳  docker exec cmd=[/opt/acttoolcache/node/24.19.0/arm64/bin/node /var/run/act/actions/docker-setup-buildx-action@v4/dist/index.cjs] user= workdir=
[S21 Final Project Pipeline/6. Docker Build                        ]   ❓  ::group::Cleaning up certificates
[S21 Final Project Pipeline/6. Docker Build                        ]   ❓  ::endgroup::
[S21 Final Project Pipeline/6. Docker Build                        ]   ❓  ::group::Post cache
[S21 Final Project Pipeline/6. Docker Build                        ]   | State not set
[S21 Final Project Pipeline/6. Docker Build                        ]   ❓  ::endgroup::
[S21 Final Project Pipeline/6. Docker Build                        ]   ✅  Success - Post Set up Docker Buildx [121.486291ms]
[S21 Final Project Pipeline/6. Docker Build                        ] ⭐ Run Complete job
[S21 Final Project Pipeline/6. Docker Build                        ] Cleaning up container for job 6. Docker Build
[S21 Final Project Pipeline/5. Secret Scan (Gitleaks)              ]   | gitleaks_8.30.1_linux_arm64.tar.gz: OK
[S21 Final Project Pipeline/6. Docker Build                        ]   ✅  Success - Complete job
[S21 Final Project Pipeline/6. Docker Build                        ] 🏁  Job succeeded
[S21 Final Project Pipeline/5. Secret Scan (Gitleaks)              ]   | 8.30.1
[S21 Final Project Pipeline/5. Secret Scan (Gitleaks)              ]   ✅  Success - Main Install Gitleaks (checksum verified) [13.693436625s]
[S21 Final Project Pipeline/5. Secret Scan (Gitleaks)              ] ⭐ Run Main Scan this folder for secrets
[S21 Final Project Pipeline/5. Secret Scan (Gitleaks)              ]   🐳  docker exec cmd=[bash --noprofile --norc -e -o pipefail /var/run/act/workflow/2.sh] user= workdir=Final-DevOps-Project-&-Troubleshooting
[S21 Final Project Pipeline/5. Secret Scan (Gitleaks)              ]   | Finding:     {"DB_PASSWORD":"REDACTED","DB_USER":"dGFza2Jv...
[S21 Final Project Pipeline/5. Secret Scan (Gitleaks)              ]   | Secret:      REDACTED
[S21 Final Project Pipeline/5. Secret Scan (Gitleaks)              ]   | RuleID:      generic-api-key
[S21 Final Project Pipeline/5. Secret Scan (Gitleaks)              ]   | Entropy:     4.334962
[S21 Final Project Pipeline/5. Secret Scan (Gitleaks)              ]   | File:        README.md
[S21 Final Project Pipeline/5. Secret Scan (Gitleaks)              ]   | Line:        487
[S21 Final Project Pipeline/5. Secret Scan (Gitleaks)              ]   | Fingerprint: README.md:generic-api-key:487
[S21 Final Project Pipeline/5. Secret Scan (Gitleaks)              ]   | 
[S21 Final Project Pipeline/5. Secret Scan (Gitleaks)              ]   | 2:00PM INF scanned ~686700 bytes (686.70 KB) in 49.8ms
[S21 Final Project Pipeline/5. Secret Scan (Gitleaks)              ]   | 2:00PM WRN leaks found: 1
[S21 Final Project Pipeline/5. Secret Scan (Gitleaks)              ]   ✅  Success - Main Scan this folder for secrets [317.796625ms]
[S21 Final Project Pipeline/5. Secret Scan (Gitleaks)              ] ⭐ Run Main Upload secret scan report
[S21 Final Project Pipeline/5. Secret Scan (Gitleaks)              ]   🐳  docker cp src=/Users/kp/.cache/act/actions-upload-artifact@v4/ dst=/var/run/act/actions/actions-upload-artifact@v4/
[S21 Final Project Pipeline/5. Secret Scan (Gitleaks)              ]   🐳  docker exec cmd=[/opt/acttoolcache/node/24.19.0/arm64/bin/node /var/run/act/actions/actions-upload-artifact@v4/dist/upload/index.js] user= workdir=
[S21 Final Project Pipeline/5. Secret Scan (Gitleaks)              ]   | (node:89) [DEP0040] DeprecationWarning: The `punycode` module is deprecated. Please use a userland alternative instead.
[S21 Final Project Pipeline/5. Secret Scan (Gitleaks)              ]   | (Use `node --trace-deprecation ...` to show where the warning was created)
[S21 Final Project Pipeline/5. Secret Scan (Gitleaks)              ]   | With the provided path, there will be 1 file uploaded
[S21 Final Project Pipeline/5. Secret Scan (Gitleaks)              ]   | Artifact name is valid!
[S21 Final Project Pipeline/5. Secret Scan (Gitleaks)              ]   | Root directory input is valid!
[S21 Final Project Pipeline/5. Secret Scan (Gitleaks)              ]   | Beginning upload of artifact content to blob storage
[S21 Final Project Pipeline/5. Secret Scan (Gitleaks)              ]   | (node:89) [DEP0169] DeprecationWarning: `url.parse()` behavior is not standardized and prone to errors that have security implications. Use the WHATWG URL API instead. CVEs are not issued for `url.parse()` vulnerabilities.
[S21 Final Project Pipeline/5. Secret Scan (Gitleaks)              ]   | Uploaded bytes 437
[S21 Final Project Pipeline/5. Secret Scan (Gitleaks)              ]   | Finished uploading artifact content to blob storage!
[S21 Final Project Pipeline/5. Secret Scan (Gitleaks)              ]   | SHA256 digest of uploaded artifact zip is 1d347b93eba363a331ea28a79963a6237c200241b78b9342ba0187f3085be8e8
[S21 Final Project Pipeline/5. Secret Scan (Gitleaks)              ]   | Finalizing artifact upload
[S21 Final Project Pipeline/5. Secret Scan (Gitleaks)              ]   | Artifact secret-scan-report.zip successfully finalized. Artifact ID 761529410
[S21 Final Project Pipeline/5. Secret Scan (Gitleaks)              ]   | Artifact secret-scan-report has been successfully uploaded! Final size is 437 bytes. Artifact ID is 761529410
[S21 Final Project Pipeline/5. Secret Scan (Gitleaks)              ]   | Artifact download URL: https://github.com/kartavya37/DevOps-Assignment/actions/runs/1/artifacts/761529410
[S21 Final Project Pipeline/5. Secret Scan (Gitleaks)              ]   ✅  Success - Main Upload secret scan report [578.548625ms]
[S21 Final Project Pipeline/5. Secret Scan (Gitleaks)              ]   ⚙  ::set-output:: artifact-id=761529410
[S21 Final Project Pipeline/5. Secret Scan (Gitleaks)              ]   ⚙  ::set-output:: artifact-digest=1d347b93eba363a331ea28a79963a6237c200241b78b9342ba0187f3085be8e8
[S21 Final Project Pipeline/5. Secret Scan (Gitleaks)              ]   ⚙  ::set-output:: artifact-url=https://github.com/kartavya37/DevOps-Assignment/actions/runs/1/artifacts/761529410
[S21 Final Project Pipeline/5. Secret Scan (Gitleaks)              ] ⭐ Run Complete job
[S21 Final Project Pipeline/5. Secret Scan (Gitleaks)              ] Cleaning up container for job 5. Secret Scan (Gitleaks)
[S21 Final Project Pipeline/5. Secret Scan (Gitleaks)              ]   ✅  Success - Complete job
[S21 Final Project Pipeline/5. Secret Scan (Gitleaks)              ] 🏁  Job succeeded
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | aquasecurity/trivy info installed /root/.local/bin/trivy-bin/trivy
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   ✅  Success - Main Install Trivy [19.590027583s]
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ] ⭐ Run Main Add Trivy binary to $GITHUB_PATH
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   🐳  docker exec cmd=[bash --noprofile --norc -e -o pipefail /var/run/act/workflow/2-composite-0-composite-5.sh] user= workdir=
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   ✅  Success - Main Add Trivy binary to $GITHUB_PATH [54.666083ms]
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   ⚙  ::add-path:: /root/.local/bin/trivy-bin
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ] ⭐ Run Main Save Trivy binary to cache
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   🐳  docker cp src=/Users/kp/.cache/act/actions-cache-save@9255dc7a253b0ccc959486e2bca901246202afeb/ dst=/var/run/act/actions/actions-cache-save@9255dc7a253b0ccc959486e2bca901246202afeb/
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   🐳  docker exec cmd=[/opt/acttoolcache/node/24.19.0/arm64/bin/node /var/run/act/actions/actions-cache-save@9255dc7a253b0ccc959486e2bca901246202afeb/dist/save-only/index.js] user= workdir=
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | [command]/usr/bin/tar --posix -cf cache.tzst --exclude cache.tzst -P -C /Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment --files-from manifest.txt --use-compress-program zstdmt
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | /usr/bin/tar: /Users/kp/SST/3rd: Cannot open: No such file or directory
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | /usr/bin/tar: Error is not recoverable: exiting now
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   🚧  ::warning::Failed to save: "/usr/bin/tar" failed with error: The process '/usr/bin/tar' failed with exit code 2
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   🚧  ::warning::Cache save failed.
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   ✅  Success - Main Save Trivy binary to cache [1.16134875s]
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   ✅  Success - Main Install Trivy [27.534205125s]
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ] ⭐ Run Main Get current date
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   🐳  docker exec cmd=[bash --noprofile --norc -e -o pipefail /var/run/act/workflow/2-composite-date.sh] user= workdir=
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   ✅  Success - Main Get current date [67.438708ms]
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   ⚙  ::set-output:: date=2026-10-07
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ] ⭐ Run Main Restore DB from cache
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   🐳  docker cp src=/Users/kp/.cache/act/actions-cache@27d5ce7f107fe9357f9df03efb73ab90386fccae/ dst=/var/run/act/actions/actions-cache@27d5ce7f107fe9357f9df03efb73ab90386fccae/
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   🐳  docker exec cmd=[/opt/acttoolcache/node/24.19.0/arm64/bin/node /var/run/act/actions/actions-cache@27d5ce7f107fe9357f9df03efb73ab90386fccae/dist/restore/index.js] user= workdir=
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | Cache not found for input keys: cache-trivy-2026-10-07, cache-trivy-
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   ✅  Success - Main Restore DB from cache [1.233033833s]
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ] ⭐ Run Main Set GitHub Path
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   🐳  docker exec cmd=[bash --noprofile --norc -e -o pipefail /var/run/act/workflow/2-composite-3.sh] user= workdir=
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   ✅  Success - Main Set GitHub Path [73.348667ms]
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   ⚙  ::add-path:: /var/run/act/actions/aquasecurity-trivy-action@ed142fd0673e97e23eac54620cfb913e5ce36c25
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ] ⭐ Run Main Clear Trivy Envs file
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   🐳  docker exec cmd=[bash --noprofile --norc -e -o pipefail /var/run/act/workflow/2-composite-4.sh] user= workdir=
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   ✅  Success - Main Clear Trivy Envs file [57.362042ms]
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | No known vulnerabilities found
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ] ⭐ Run Main Set Trivy environment variables
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   🐳  docker exec cmd=[bash --noprofile --norc -e -o pipefail /var/run/act/workflow/2-composite-5.sh] user= workdir=
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   ✅  Success - Main Set Trivy environment variables [66.26425ms]
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ] ⭐ Run Main Run Trivy
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   🐳  docker exec cmd=[bash --noprofile --norc -e -o pipefail /var/run/act/workflow/2-composite-6.sh] user= workdir=
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | Found ignorefile 'Final-DevOps-Project-&-Troubleshooting/security/.trivyignore':
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | # Trivy ignore file (SCA "trivy fs", container image scans and the IaC "trivy config" scan).
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | #
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | # Add one ID per line ONLY when the risk is accepted, with a reason and an expiry date.
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | # The security gate does not count ignored findings. Review this file before each expiry date.
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | 
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | # AWS-0104 (CRITICAL, terraform/security.tf): the EKS cluster and node security groups allow all outbound traffic.
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | # Reason: the nodes must reach GHCR/ECR, the AWS APIs and the NAT gateway. The VPC has no proxy or VPC endpoints yet.
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | # Plan: add VPC endpoints (ECR, S3, STS) and an egress proxy, then restrict egress to them.
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | AWS-0104 exp:2027-03-31
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | Running Trivy with options: trivy config Final-DevOps-Project-&-Troubleshooting/kubernetes
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | No known vulnerabilities found
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ✅  Success - Main Audit the Python dependencies (pip-audit) [31.237840458s]
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   ✅  Success - Main Run Trivy [2.730545041s]
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)] ⭐ Run Main Set up Node.js
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ] ⭐ Run Main Remove Trivy Envs file
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   🐳  docker cp src=/Users/kp/.cache/act/actions-setup-node@v7/ dst=/var/run/act/actions/actions-setup-node@v7/
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   🐳  docker exec cmd=[bash --noprofile --norc -e -o pipefail /var/run/act/workflow/2-composite-7.sh] user= workdir=
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   ✅  Success - Main Remove Trivy Envs file [71.14975ms]
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   ✅  Success - Main Scan the Kubernetes manifests (Trivy config) [32.647094542s]
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ] ⭐ Run Main Scan the Helm chart, the Dockerfiles and Terraform, then merge the reports
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   🐳  docker exec cmd=[bash --noprofile --norc -e -o pipefail /var/run/act/workflow/3.sh] user= workdir=Final-DevOps-Project-&-Troubleshooting
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   🐳  docker exec cmd=[/opt/acttoolcache/node/24.19.0/arm64/bin/node /var/run/act/actions/actions-setup-node@v7/dist/setup/index.js] user= workdir=
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | Found in cache @ /opt/hostedtoolcache/node/22.23.3/arm64
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ❓  ::group::Environment details
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | node: v22.23.3
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | npm: 10.9.9
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | yarn: 
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ❓  ::endgroup::
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ❓ add-matcher /run/act/actions/actions-setup-node@v7/.github/tsc.json
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ❓ add-matcher /run/act/actions/actions-setup-node@v7/.github/eslint-stylish.json
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ❓ add-matcher /run/act/actions/actions-setup-node@v7/.github/eslint-compact.json
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ✅  Success - Main Set up Node.js [1.354463875s]
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ⚙  ::set-output:: node-version=v22.23.3
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ⚙  ::add-path:: /opt/hostedtoolcache/node/22.23.3/arm64/bin
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)] ⭐ Run Main Audit the frontend dependencies (npm audit)
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   🐳  docker exec cmd=[bash --noprofile --norc -e -o pipefail /var/run/act/workflow/4.sh] user= workdir=Final-DevOps-Project-&-Troubleshooting/application/frontend
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | found 0 vulnerabilities
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ✅  Success - Main Audit the frontend dependencies (npm audit) [1.490714417s]
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)] ⭐ Run Main Scan the dependency files (Trivy fs)
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   🐳  docker cp src=/Users/kp/.cache/act/aquasecurity-trivy-action@ed142fd0673e97e23eac54620cfb913e5ce36c25/ dst=/var/run/act/actions/aquasecurity-trivy-action@ed142fd0673e97e23eac54620cfb913e5ce36c25/
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)] ⭐ Run Main Install Trivy
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   🐳  docker cp src=/Users/kp/.cache/act/aquasecurity-setup-trivy@3fb12ec12f41e471780db15c232d5dd185dcb514/ dst=/var/run/act/actions/aquasecurity-setup-trivy@3fb12ec12f41e471780db15c232d5dd185dcb514/
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)] ⭐ Run Main Binary dir
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   🐳  docker exec cmd=[bash --noprofile --norc -e -o pipefail /var/run/act/workflow/5-composite-0-composite-binary-dir.sh] user= workdir=
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ✅  Success - Main Binary dir [63.514792ms]
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ⚙  ::set-output:: dir=/root/.local/bin/trivy-bin
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)] ⭐ Run Main Restore Trivy binary from cache
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   🐳  docker cp src=/Users/kp/.cache/act/actions-cache-restore@9255dc7a253b0ccc959486e2bca901246202afeb/ dst=/var/run/act/actions/actions-cache-restore@9255dc7a253b0ccc959486e2bca901246202afeb/
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | == kubernetes (HIGH and CRITICAL)
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | 
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | Report Summary
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | 
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | ┌───────────────────┬────────────┬───────────────────┐
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | │      Target       │    Type    │ Misconfigurations │
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | ├───────────────────┼────────────┼───────────────────┤
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | │ 00-namespace.yaml │ kubernetes │         0         │
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | ├───────────────────┼────────────┼───────────────────┤
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | │ 01-configmap.yaml │ kubernetes │         0         │
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | ├───────────────────┼────────────┼───────────────────┤
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | │ 02-secret.yaml    │ kubernetes │         0         │
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | ├───────────────────┼────────────┼───────────────────┤
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | │ 03-postgres.yaml  │ kubernetes │         0         │
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | ├───────────────────┼────────────┼───────────────────┤
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | │ 04-backend.yaml   │ kubernetes │         0         │
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | ├───────────────────┼────────────┼───────────────────┤
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | │ 05-frontend.yaml  │ kubernetes │         0         │
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | ├───────────────────┼────────────┼───────────────────┤
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | │ 06-ingress.yaml   │ kubernetes │         0         │
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | ├───────────────────┼────────────┼───────────────────┤
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | │ 07-hpa.yaml       │ kubernetes │         0         │
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | └───────────────────┴────────────┴───────────────────┘
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | Legend:
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | - '-': Not scanned
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | - '0': Clean (no security findings detected)
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | 
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | == helm (HIGH and CRITICAL)
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | 
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | Report Summary
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | 
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | ┌────────────────────────────────────┬──────┬───────────────────┐
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | │               Target               │ Type │ Misconfigurations │
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | ├────────────────────────────────────┼──────┼───────────────────┤
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | │ taskboard/templates/backend.yaml   │ helm │         0         │
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | ├────────────────────────────────────┼──────┼───────────────────┤
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | │ taskboard/templates/configmap.yaml │ helm │         0         │
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | ├────────────────────────────────────┼──────┼───────────────────┤
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | │ taskboard/templates/frontend.yaml  │ helm │         0         │
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | ├────────────────────────────────────┼──────┼───────────────────┤
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | │ taskboard/templates/hpa.yaml       │ helm │         0         │
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | ├────────────────────────────────────┼──────┼───────────────────┤
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | │ taskboard/templates/ingress.yaml   │ helm │         0         │
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | ├────────────────────────────────────┼──────┼───────────────────┤
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | │ taskboard/templates/postgres.yaml  │ helm │         0         │
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | ├────────────────────────────────────┼──────┼───────────────────┤
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | │ taskboard/templates/secret.yaml    │ helm │         0         │
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | └────────────────────────────────────┴──────┴───────────────────┘
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | Legend:
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | - '-': Not scanned
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | - '0': Clean (no security findings detected)
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | 
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | == docker (HIGH and CRITICAL)
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | 
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | Report Summary
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | 
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | ┌─────────────────────┬────────────┬───────────────────┐
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | │       Target        │    Type    │ Misconfigurations │
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | ├─────────────────────┼────────────┼───────────────────┤
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | │ backend.Dockerfile  │ dockerfile │         0         │
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | ├─────────────────────┼────────────┼───────────────────┤
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | │ frontend.Dockerfile │ dockerfile │         0         │
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | └─────────────────────┴────────────┴───────────────────┘
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | Legend:
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | - '-': Not scanned
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | - '0': Clean (no security findings detected)
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | 
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | == terraform (HIGH and CRITICAL)
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | 
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | Report Summary
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | 
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | ┌─────────────┬───────────┬───────────────────┐
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | │   Target    │   Type    │ Misconfigurations │
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | ├─────────────┼───────────┼───────────────────┤
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | │ .           │ terraform │         0         │
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | ├─────────────┼───────────┼───────────────────┤
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | │ network.tf  │ terraform │         0         │
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | ├─────────────┼───────────┼───────────────────┤
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | │ security.tf │ terraform │         0         │
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | ├─────────────┼───────────┼───────────────────┤
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | │ storage.tf  │ terraform │         0         │
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | └─────────────┴───────────┴───────────────────┘
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | Legend:
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | - '-': Not scanned
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | - '0': Clean (no security findings detected)
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | 
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   ✅  Success - Main Scan the Helm chart, the Dockerfiles and Terraform, then merge the reports [4.010730458s]
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ] ⭐ Run Main Upload IaC report
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   🐳  docker cp src=/Users/kp/.cache/act/actions-upload-artifact@v4/ dst=/var/run/act/actions/actions-upload-artifact@v4/
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   🐳  docker exec cmd=[/opt/acttoolcache/node/24.19.0/arm64/bin/node /var/run/act/actions/actions-cache-restore@9255dc7a253b0ccc959486e2bca901246202afeb/dist/restore-only/index.js] user= workdir=
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   🐳  docker exec cmd=[/opt/acttoolcache/node/24.19.0/arm64/bin/node /var/run/act/actions/actions-upload-artifact@v4/dist/upload/index.js] user= workdir=
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ⚙  ***
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | (node:499) [DEP0040] DeprecationWarning: The `punycode` module is deprecated. Please use a userland alternative instead.
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | (Use `node --trace-deprecation ...` to show where the warning was created)
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | With the provided path, there will be 1 file uploaded
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | Artifact name is valid!
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | Root directory input is valid!
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | Beginning upload of artifact content to blob storage
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | Cache Size: ~41 MB (42628276 B)
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | [command]/usr/bin/tar -xf /tmp/b1082754-7ca6-4ecc-87e1-a858a2c917aa/cache.tzst -P -C /Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment --use-compress-program unzstd
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | (node:499) [DEP0169] DeprecationWarning: `url.parse()` behavior is not standardized and prone to errors that have security implications. Use the WHATWG URL API instead. CVEs are not issued for `url.parse()` vulnerabilities.
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | Uploaded bytes 4857
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | Finished uploading artifact content to blob storage!
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | SHA256 digest of uploaded artifact zip is a69b78b92ec101da32254af92585be485f3bef7f80d8c4b37b85519b1b12480b
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | Finalizing artifact upload
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | Artifact iac-report.zip successfully finalized. Artifact ID 1472450981
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | Artifact iac-report has been successfully uploaded! Final size is 4857 bytes. Artifact ID is 1472450981
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | Artifact download URL: https://github.com/kartavya37/DevOps-Assignment/actions/runs/1/artifacts/1472450981
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   ✅  Success - Main Upload IaC report [877.143209ms]
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   ⚙  ::set-output:: artifact-id=1472450981
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   ⚙  ::set-output:: artifact-digest=a69b78b92ec101da32254af92585be485f3bef7f80d8c4b37b85519b1b12480b
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   ⚙  ::set-output:: artifact-url=https://github.com/kartavya37/DevOps-Assignment/actions/runs/1/artifacts/1472450981
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ] ⭐ Run Post Scan the Kubernetes manifests (Trivy config)
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   🐳  docker cp src=/Users/kp/.cache/act/aquasecurity-trivy-action@ed142fd0673e97e23eac54620cfb913e5ce36c25/ dst=/var/run/act/actions/aquasecurity-trivy-action@ed142fd0673e97e23eac54620cfb913e5ce36c25/
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | /usr/bin/tar: Year/Devops/SST-Assignments/DevOps-Assignment: Not found in archive
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | /usr/bin/tar: Exiting with failure status due to previous errors
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   🚧  ::warning::Failed to restore: "/usr/bin/tar" failed with error: The process '/usr/bin/tar' failed with exit code 2
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | Cache not found for input keys: trivy-binary-v0.75.0-Linux-ARM64
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ✅  Success - Main Restore Trivy binary from cache [1.932719042s]
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ] ⭐ Run Post Restore DB from cache
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ⚙  ::set-output:: cache-primary-key=trivy-binary-v0.75.0-Linux-ARM64
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   🐳  docker exec cmd=[/opt/acttoolcache/node/24.19.0/arm64/bin/node /var/run/act/actions/actions-cache@27d5ce7f107fe9357f9df03efb73ab90386fccae/dist/save/index.js] user= workdir=
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)] ⭐ Run Main Checkout install script
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   🐳  docker cp src=/Users/kp/.cache/act/actions-checkout@8e8c483db84b4bee98b60c0593521ed34d9990e8/ dst=/var/run/act/actions/actions-checkout@8e8c483db84b4bee98b60c0593521ed34d9990e8/
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | [command]/usr/bin/tar --posix -cf cache.tzst --exclude cache.tzst -P -C /Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment --files-from manifest.txt --use-compress-program zstdmt
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | /usr/bin/tar: /Users/kp/SST/3rd: Cannot open: No such file or directory
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   | /usr/bin/tar: Error is not recoverable: exiting now
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   🚧  ::warning::Failed to save: "/usr/bin/tar" failed with error: The process '/usr/bin/tar' failed with exit code 2
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   ✅  Success - Post Restore DB from cache [132.999583ms]
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ] ⭐ Run Post Install Trivy
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   🐳  docker cp src=/Users/kp/.cache/act/aquasecurity-setup-trivy@3fb12ec12f41e471780db15c232d5dd185dcb514/ dst=/var/run/act/actions/aquasecurity-setup-trivy@3fb12ec12f41e471780db15c232d5dd185dcb514/
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ] ⭐ Run Post Checkout install script
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   🐳  docker exec cmd=[/opt/acttoolcache/node/24.19.0/arm64/bin/node /var/run/act/actions/actions-checkout@8e8c483db84b4bee98b60c0593521ed34d9990e8/dist/index.js] user= workdir=
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   ✅  Success - Post Checkout install script [126.180083ms]
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   ✅  Success - Post Install Trivy [207.76ms]
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   ✅  Success - Post Scan the Kubernetes manifests (Trivy config) [571.45325ms]
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ] ⭐ Run Complete job
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ] Cleaning up container for job 4. IaC Scan (Trivy config)
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   🐳  docker exec cmd=[/opt/acttoolcache/node/24.19.0/arm64/bin/node /var/run/act/actions/actions-checkout@8e8c483db84b4bee98b60c0593521ed34d9990e8/dist/index.js] user= workdir=
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ❓ add-matcher /run/act/actions/actions-checkout@8e8c483db84b4bee98b60c0593521ed34d9990e8/dist/problem-matcher.json
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | Syncing repository: aquasecurity/trivy
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ❓  ::group::Getting Git version info
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | Working directory is '/Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment/trivy'
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | [command]/usr/bin/git version
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | git version 2.55.0
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ❓  ::endgroup::
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ⚙  ***
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | Temporarily overriding HOME='/tmp/05f8f73b-f011-4b07-9532-0cc4a7b747d5' before making global git config changes
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | Adding repository directory to the temporary git global config as a safe directory
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | [command]/usr/bin/git config --global --add safe.directory /Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment/trivy
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ❓  ::group::Initializing the repository
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | [command]/usr/bin/git init /Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment/trivy
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | hint: Using 'master' as the name for the initial branch. This default branch name
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | hint: will change to "main" in Git 3.0. To configure the initial branch name
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | hint: to use in all of your new repositories, which will suppress this warning,
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | hint: call:
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | hint:
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | hint: 	git config --global init.defaultBranch <name>
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | hint:
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | hint: Names commonly chosen instead of 'master' are 'main', 'trunk' and
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | hint: 'development'. The just-created branch can be renamed via this command:
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | hint:
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | hint: 	git branch -m <name>
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | hint:
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | hint: Disable this message with "git config set advice.defaultBranchName false"
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | Initialized empty Git repository in /Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment/trivy/.git/
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | [command]/usr/bin/git remote add origin https://github.com/aquasecurity/trivy
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ❓  ::endgroup::
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ❓  ::group::Disabling automatic garbage collection
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | [command]/usr/bin/git config --local gc.auto 0
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ❓  ::endgroup::
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ❓  ::group::Setting up auth
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | Removing SSH command configuration
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | [command]/usr/bin/git config --local --name-only --get-regexp core\.sshCommand
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | [command]/usr/bin/git submodule foreach --recursive sh -c "git config --local --name-only --get-regexp 'core\.sshCommand' && git config --local --unset-all 'core.sshCommand' || :"
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | Removing HTTP extra header
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | [command]/usr/bin/git config --local --name-only --get-regexp http\.https\:\/\/github\.com\/\.extraheader
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | [command]/usr/bin/git submodule foreach --recursive sh -c "git config --local --name-only --get-regexp 'http\.https\:\/\/github\.com\/\.extraheader' && git config --local --unset-all 'http.https://github.com/.extraheader' || :"
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | Removing includeIf entries pointing to credentials config files
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | [command]/usr/bin/git config --local --name-only --get-regexp ^includeIf\.gitdir:
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ]   ✅  Success - Complete job
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | [command]/usr/bin/git submodule foreach --recursive git config --local --show-origin --name-only --get-regexp remote.origin.url
[S21 Final Project Pipeline/4. IaC Scan (Trivy config)             ] 🏁  Job succeeded
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | [command]/usr/bin/git config --file /tmp/git-credentials-1d391b7b-9b72-4a15-995c-04c764d7431e.config http.https://github.com/.extraheader AUTHORIZATION: basic ***
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | [command]/usr/bin/git config --local includeIf.gitdir:/Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment/trivy/.git.path /tmp/git-credentials-1d391b7b-9b72-4a15-995c-04c764d7431e.config
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | [command]/usr/bin/git config --local includeIf.gitdir:/Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment/trivy/.git/worktrees/*.path /tmp/git-credentials-1d391b7b-9b72-4a15-995c-04c764d7431e.config
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | [command]/usr/bin/git config --local includeIf.gitdir:/github/workspace/trivy/.git.path /github/runner_temp/git-credentials-1d391b7b-9b72-4a15-995c-04c764d7431e.config
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | [command]/usr/bin/git config --local includeIf.gitdir:/github/workspace/trivy/.git/worktrees/*.path /github/runner_temp/git-credentials-1d391b7b-9b72-4a15-995c-04c764d7431e.config
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ❓  ::endgroup::
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ❓  ::group::Fetching the repository
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | [command]/usr/bin/git -c protocol.version=2 fetch --no-tags --prune --no-recurse-submodules --filter=blob:none --depth=1 origin 75c4dc0f45c5d7ffd05ae26df1e0c666787bdf2a
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | From https://github.com/aquasecurity/trivy
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   |  * branch            75c4dc0f45c5d7ffd05ae26df1e0c666787bdf2a -> FETCH_HEAD
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ❓  ::endgroup::
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ❓  ::group::Determining the checkout info
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ❓  ::endgroup::
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ❓  ::group::Setting up sparse checkout
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | [command]/usr/bin/git sparse-checkout set contrib
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ❓  ::endgroup::
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ❓  ::group::Checking out the ref
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | [command]/usr/bin/git checkout --progress --force 75c4dc0f45c5d7ffd05ae26df1e0c666787bdf2a
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | Updating files:   3% (1/28)Updating files:   7% (2/28)Updating files:  10% (3/28)Updating files:  14% (4/28)Updating files:  17% (5/28)Updating files:  21% (6/28)Updating files:  25% (7/28)Updating files:  28% (8/28)Updating files:  32% (9/28)Updating files:  35% (10/28)Updating files:  39% (11/28)Updating files:  42% (12/28)Updating files:  46% (13/28)Updating files:  50% (14/28)Updating files:  53% (15/28)Updating files:  57% (16/28)Updating files:  60% (17/28)Updating files:  64% (18/28)Updating files:  67% (19/28)Updating files:  71% (20/28)Updating files:  75% (21/28)Updating files:  78% (22/28)Updating files:  82% (23/28)Updating files:  85% (24/28)Updating files:  89% (25/28)Updating files:  92% (26/28)Updating files:  96% (27/28)Updating files: 100% (28/28)Updating files: 100% (28/28), done.
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | Note: switching to '75c4dc0f45c5d7ffd05ae26df1e0c666787bdf2a'.
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | 
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | You are in 'detached HEAD' state. You can look around, make experimental
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | changes and commit them, and you can discard any commits you make in this
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | state without impacting any branches by switching back to a branch.
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | 
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | If you want to create a new branch to retain commits you create, you may
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | do so (now or later) by using -c with the switch command. Example:
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | 
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   |   git switch -c <new-branch-name>
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | 
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | Or undo this operation with:
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | 
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   |   git switch -
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | 
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | Turn off this advice by setting config variable advice.detachedHead to false
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | 
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | HEAD is now at 75c4dc0 chore: add client option to install script (#9962)
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ❓  ::endgroup::
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | [command]/usr/bin/git log -1 --format=%H
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | 75c4dc0f45c5d7ffd05ae26df1e0c666787bdf2a
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ❓  ::remove-matcher owner=checkout-git::
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ✅  Success - Main Checkout install script [4.522116333s]
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ⚙  ::set-output:: commit=75c4dc0f45c5d7ffd05ae26df1e0c666787bdf2a
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ⚙  ::set-output:: ref=
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)] ⭐ Run Main Install Trivy
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   🐳  docker exec cmd=[bash --noprofile --norc -e -o pipefail /var/run/act/workflow/5-composite-0-composite-4.sh] user= workdir=
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | installing Trivy binary
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | aquasecurity/trivy info checking GitHub for tag 'v0.75.0'
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | aquasecurity/trivy info found version: 0.75.0 for v0.75.0/Linux/ARM64
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | aquasecurity/trivy info installed /root/.local/bin/trivy-bin/trivy
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ✅  Success - Main Install Trivy [24.881604875s]
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)] ⭐ Run Main Add Trivy binary to $GITHUB_PATH
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   🐳  docker exec cmd=[bash --noprofile --norc -e -o pipefail /var/run/act/workflow/5-composite-0-composite-5.sh] user= workdir=
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ✅  Success - Main Add Trivy binary to $GITHUB_PATH [68.751041ms]
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ⚙  ::add-path:: /root/.local/bin/trivy-bin
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)] ⭐ Run Main Save Trivy binary to cache
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   🐳  docker cp src=/Users/kp/.cache/act/actions-cache-save@9255dc7a253b0ccc959486e2bca901246202afeb/ dst=/var/run/act/actions/actions-cache-save@9255dc7a253b0ccc959486e2bca901246202afeb/
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   🐳  docker exec cmd=[/opt/acttoolcache/node/24.19.0/arm64/bin/node /var/run/act/actions/actions-cache-save@9255dc7a253b0ccc959486e2bca901246202afeb/dist/save-only/index.js] user= workdir=
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | [command]/usr/bin/tar --posix -cf cache.tzst --exclude cache.tzst -P -C /Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment --files-from manifest.txt --use-compress-program zstdmt
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | /usr/bin/tar: /Users/kp/SST/3rd: Cannot open: No such file or directory
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | /usr/bin/tar: Error is not recoverable: exiting now
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   🚧  ::warning::Failed to save: "/usr/bin/tar" failed with error: The process '/usr/bin/tar' failed with exit code 2
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   🚧  ::warning::Cache save failed.
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ✅  Success - Main Save Trivy binary to cache [1.116163958s]
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ✅  Success - Main Install Trivy [32.937770417s]
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)] ⭐ Run Main Get current date
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   🐳  docker exec cmd=[bash --noprofile --norc -e -o pipefail /var/run/act/workflow/5-composite-date.sh] user= workdir=
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ✅  Success - Main Get current date [54.116167ms]
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ⚙  ::set-output:: date=2026-10-07
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)] ⭐ Run Main Restore DB from cache
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   🐳  docker cp src=/Users/kp/.cache/act/actions-cache@27d5ce7f107fe9357f9df03efb73ab90386fccae/ dst=/var/run/act/actions/actions-cache@27d5ce7f107fe9357f9df03efb73ab90386fccae/
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   🐳  docker exec cmd=[/opt/acttoolcache/node/24.19.0/arm64/bin/node /var/run/act/actions/actions-cache@27d5ce7f107fe9357f9df03efb73ab90386fccae/dist/restore/index.js] user= workdir=
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | Cache not found for input keys: cache-trivy-2026-10-07, cache-trivy-
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ✅  Success - Main Restore DB from cache [1.143648708s]
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)] ⭐ Run Main Set GitHub Path
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   🐳  docker exec cmd=[bash --noprofile --norc -e -o pipefail /var/run/act/workflow/5-composite-3.sh] user= workdir=
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ✅  Success - Main Set GitHub Path [55.296542ms]
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ⚙  ::add-path:: /var/run/act/actions/aquasecurity-trivy-action@ed142fd0673e97e23eac54620cfb913e5ce36c25
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)] ⭐ Run Main Clear Trivy Envs file
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   🐳  docker exec cmd=[bash --noprofile --norc -e -o pipefail /var/run/act/workflow/5-composite-4.sh] user= workdir=
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ✅  Success - Main Clear Trivy Envs file [58.887959ms]
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)] ⭐ Run Main Set Trivy environment variables
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   🐳  docker exec cmd=[bash --noprofile --norc -e -o pipefail /var/run/act/workflow/5-composite-5.sh] user= workdir=
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ✅  Success - Main Set Trivy environment variables [60.355792ms]
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)] ⭐ Run Main Run Trivy
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   🐳  docker exec cmd=[bash --noprofile --norc -e -o pipefail /var/run/act/workflow/5-composite-6.sh] user= workdir=
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | Found ignorefile 'Final-DevOps-Project-&-Troubleshooting/security/.trivyignore':
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | # Trivy ignore file (SCA "trivy fs", container image scans and the IaC "trivy config" scan).
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | #
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | # Add one ID per line ONLY when the risk is accepted, with a reason and an expiry date.
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | # The security gate does not count ignored findings. Review this file before each expiry date.
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | 
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | # AWS-0104 (CRITICAL, terraform/security.tf): the EKS cluster and node security groups allow all outbound traffic.
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | # Reason: the nodes must reach GHCR/ECR, the AWS APIs and the NAT gateway. The VPC has no proxy or VPC endpoints yet.
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | # Plan: add VPC endpoints (ECR, S3, STS) and an egress proxy, then restrict egress to them.
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | AWS-0104 exp:2027-03-31
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | Running Trivy with options: trivy fs Final-DevOps-Project-&-Troubleshooting/application
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ✅  Success - Main Run Trivy [59.419695084s]
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)] ⭐ Run Main Remove Trivy Envs file
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   🐳  docker exec cmd=[bash --noprofile --norc -e -o pipefail /var/run/act/workflow/5-composite-7.sh] user= workdir=
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ✅  Success - Main Remove Trivy Envs file [141.836916ms]
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ✅  Success - Main Scan the dependency files (Trivy fs) [1m34.552125s]
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)] ⭐ Run Main Show the Trivy fs result
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   🐳  docker exec cmd=[bash --noprofile --norc -e -o pipefail /var/run/act/workflow/6.sh] user= workdir=Final-DevOps-Project-&-Troubleshooting
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | 
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | Report Summary
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | 
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | ┌────────────────────────────┬──────┬─────────────────┐
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | │           Target           │ Type │ Vulnerabilities │
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | ├────────────────────────────┼──────┼─────────────────┤
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | │ backend/requirements.txt   │ pip  │        0        │
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | ├────────────────────────────┼──────┼─────────────────┤
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | │ frontend/package-lock.json │ npm  │        0        │
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | └────────────────────────────┴──────┴─────────────────┘
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | Legend:
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | - '-': Not scanned
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | - '0': Clean (no security findings detected)
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | 
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ✅  Success - Main Show the Trivy fs result [346.334083ms]
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)] ⭐ Run Main Upload SCA reports
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   🐳  docker cp src=/Users/kp/.cache/act/actions-upload-artifact@v4/ dst=/var/run/act/actions/actions-upload-artifact@v4/
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   🐳  docker exec cmd=[/opt/acttoolcache/node/24.19.0/arm64/bin/node /var/run/act/actions/actions-upload-artifact@v4/dist/upload/index.js] user= workdir=
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | (node:602) [DEP0040] DeprecationWarning: The `punycode` module is deprecated. Please use a userland alternative instead.
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | (Use `node --trace-deprecation ...` to show where the warning was created)
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | Multiple search paths detected. Calculating the least common ancestor of all paths
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | The least common ancestor is /Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment/Final-DevOps-Project-&-Troubleshooting/reports. This will be the root directory of the artifact
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | With the provided path, there will be 3 files uploaded
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | Artifact name is valid!
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | Root directory input is valid!
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | Beginning upload of artifact content to blob storage
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | (node:602) [DEP0169] DeprecationWarning: `url.parse()` behavior is not standardized and prone to errors that have security implications. Use the WHATWG URL API instead. CVEs are not issued for `url.parse()` vulnerabilities.
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | Uploaded bytes 1993
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | Finished uploading artifact content to blob storage!
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | SHA256 digest of uploaded artifact zip is efac1480ca570eceb174f23d8dd5ab40b3138221542157f752124074bdaf5a70
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | Finalizing artifact upload
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | Artifact sca-report.zip successfully finalized. Artifact ID 3243087279
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | Artifact sca-report has been successfully uploaded! Final size is 1993 bytes. Artifact ID is 3243087279
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | Artifact download URL: https://github.com/kartavya37/DevOps-Assignment/actions/runs/1/artifacts/3243087279
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ✅  Success - Main Upload SCA reports [1.008450333s]
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ⚙  ::set-output:: artifact-id=3243087279
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ⚙  ::set-output:: artifact-digest=efac1480ca570eceb174f23d8dd5ab40b3138221542157f752124074bdaf5a70
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ⚙  ::set-output:: artifact-url=https://github.com/kartavya37/DevOps-Assignment/actions/runs/1/artifacts/3243087279
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)] ⭐ Run Post Scan the dependency files (Trivy fs)
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   🐳  docker cp src=/Users/kp/.cache/act/aquasecurity-trivy-action@ed142fd0673e97e23eac54620cfb913e5ce36c25/ dst=/var/run/act/actions/aquasecurity-trivy-action@ed142fd0673e97e23eac54620cfb913e5ce36c25/
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)] ⭐ Run Post Restore DB from cache
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   🐳  docker exec cmd=[/opt/acttoolcache/node/24.19.0/arm64/bin/node /var/run/act/actions/actions-cache@27d5ce7f107fe9357f9df03efb73ab90386fccae/dist/save/index.js] user= workdir=
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | [command]/usr/bin/tar --posix -cf cache.tzst --exclude cache.tzst -P -C /Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment --files-from manifest.txt --use-compress-program zstdmt
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | /usr/bin/tar: /Users/kp/SST/3rd: Cannot open: No such file or directory
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   | /usr/bin/tar: Error is not recoverable: exiting now
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   🚧  ::warning::Failed to save: "/usr/bin/tar" failed with error: The process '/usr/bin/tar' failed with exit code 2
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ✅  Success - Post Restore DB from cache [149.811417ms]
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)] ⭐ Run Post Install Trivy
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   🐳  docker cp src=/Users/kp/.cache/act/aquasecurity-setup-trivy@3fb12ec12f41e471780db15c232d5dd185dcb514/ dst=/var/run/act/actions/aquasecurity-setup-trivy@3fb12ec12f41e471780db15c232d5dd185dcb514/
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)] ⭐ Run Post Checkout install script
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   🐳  docker exec cmd=[/opt/acttoolcache/node/24.19.0/arm64/bin/node /var/run/act/actions/actions-checkout@8e8c483db84b4bee98b60c0593521ed34d9990e8/dist/index.js] user= workdir=
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ✅  Success - Post Checkout install script [96.965541ms]
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ✅  Success - Post Install Trivy [160.025333ms]
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ✅  Success - Post Scan the dependency files (Trivy fs) [542.229584ms]
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)] ⭐ Run Post Set up Node.js
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   🐳  docker exec cmd=[/opt/acttoolcache/node/24.19.0/arm64/bin/node /var/run/act/actions/actions-setup-node@v7/dist/cache-save/index.js] user= workdir=
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ✅  Success - Post Set up Node.js [129.040584ms]
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)] ⭐ Run Post Set up Python
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   🐳  docker exec cmd=[/opt/acttoolcache/node/24.19.0/arm64/bin/node /var/run/act/actions/actions-setup-python@v7/dist/cache-save/index.js] user= workdir=
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ✅  Success - Post Set up Python [135.968917ms]
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)] ⭐ Run Complete job
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)] Cleaning up container for job 3. SCA (pip-audit, npm audit, Trivy fs)
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)]   ✅  Success - Complete job
[S21 Final Project Pipeline/3. SCA (pip-audit, npm audit, Trivy fs)] 🏁  Job succeeded
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ] ⭐ Run Set up job
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ] 🚀  Start image=catthehacker/ubuntu:act-latest
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   🐳  docker pull image=catthehacker/ubuntu:act-latest platform=linux/arm64 username= forcePull=false
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   🐳  docker create image=catthehacker/ubuntu:act-latest platform=linux/arm64 entrypoint=["tail" "-f" "/dev/null"] cmd=[] network="host"
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   🐳  docker run image=catthehacker/ubuntu:act-latest platform=linux/arm64 entrypoint=["tail" "-f" "/dev/null"] cmd=[] network="host"
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   🐳  docker exec cmd=[node --no-warnings -e console.log(process.execPath)] user= workdir=
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ✅  Success - Set up job
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ☁  git clone 'https://github.com/actions/download-artifact' # ref=v4
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ☁  git clone 'https://github.com/aquasecurity/trivy-action' # ref=ed142fd0673e97e23eac54620cfb913e5ce36c25
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ] ⭐ Run Pre Scan the backend image (Trivy)
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ☁  git clone 'https://github.com/aquasecurity/setup-trivy' # ref=3fb12ec12f41e471780db15c232d5dd185dcb514
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ] ⭐ Run Pre Install Trivy
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ☁  git clone 'https://github.com/actions/cache' # ref=9255dc7a253b0ccc959486e2bca901246202afeb
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ☁  git clone 'https://github.com/actions/checkout' # ref=8e8c483db84b4bee98b60c0593521ed34d9990e8
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ☁  git clone 'https://github.com/actions/cache' # ref=9255dc7a253b0ccc959486e2bca901246202afeb
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ✅  Success - Pre Install Trivy [247.918958ms]
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ☁  git clone 'https://github.com/actions/cache' # ref=27d5ce7f107fe9357f9df03efb73ab90386fccae
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ✅  Success - Pre Scan the backend image (Trivy) [407.741ms]
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ☁  git clone 'https://github.com/aquasecurity/trivy-action' # ref=ed142fd0673e97e23eac54620cfb913e5ce36c25
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ] ⭐ Run Pre Scan the frontend image (Trivy)
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ☁  git clone 'https://github.com/aquasecurity/setup-trivy' # ref=3fb12ec12f41e471780db15c232d5dd185dcb514
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ] ⭐ Run Pre Install Trivy
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ☁  git clone 'https://github.com/actions/cache' # ref=9255dc7a253b0ccc959486e2bca901246202afeb
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ☁  git clone 'https://github.com/actions/checkout' # ref=8e8c483db84b4bee98b60c0593521ed34d9990e8
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ☁  git clone 'https://github.com/actions/cache' # ref=9255dc7a253b0ccc959486e2bca901246202afeb
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ✅  Success - Pre Install Trivy [197.861791ms]
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ☁  git clone 'https://github.com/actions/cache' # ref=27d5ce7f107fe9357f9df03efb73ab90386fccae
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ✅  Success - Pre Scan the frontend image (Trivy) [334.162333ms]
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ☁  git clone 'https://github.com/actions/upload-artifact' # ref=v4
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ] ⭐ Run Main Checkout source code
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   🐳  docker cp src=/Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment/. dst=/Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ✅  Success - Main Checkout source code [1.083714583s]
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ] ⭐ Run Main Download the image tar files
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   🐳  docker cp src=/Users/kp/.cache/act/actions-download-artifact@v4/ dst=/var/run/act/actions/actions-download-artifact@v4/
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   🐳  docker exec cmd=[/opt/acttoolcache/node/24.19.0/arm64/bin/node /var/run/act/actions/actions-download-artifact@v4/dist/index.js] user= workdir=
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | Downloading single artifact
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | (node:31) [DEP0040] DeprecationWarning: The `punycode` module is deprecated. Please use a userland alternative instead.
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | (Use `node --trace-deprecation ...` to show where the warning was created)
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | Preparing to download the following artifacts:
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | - docker-images (ID: 2254189770, Size: 96, Expected Digest: undefined)
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | Redirecting to blob download url: http://0.0.0.0:18791/twirp/github.actions.results.api.v1.ArtifactService/DownloadArtifact
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | Starting download of artifact to: /tmp/images
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | (node:31) [DEP0005] DeprecationWarning: Buffer() is deprecated due to security and usability issues. Please use the Buffer.alloc(), Buffer.allocUnsafe(), or Buffer.from() methods instead.
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | SHA256 digest of downloaded artifact is 62e277eee5f4bfbaaf58a12f90c67dd4016a7284137abdcf0ba665db70b0bb7a
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | Artifact download completed successfully.
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | Total of 1 artifact(s) downloaded
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | Download artifact has finished successfully
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ✅  Success - Main Download the image tar files [1.198146583s]
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ⚙  ::set-output:: download-path=/tmp/images
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ] ⭐ Run Main Create the reports folder
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   🐳  docker exec cmd=[bash --noprofile --norc -e -o pipefail /var/run/act/workflow/2.sh] user= workdir=Final-DevOps-Project-&-Troubleshooting
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ✅  Success - Main Create the reports folder [50.227917ms]
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ] ⭐ Run Main Scan the backend image (Trivy)
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   🐳  docker cp src=/Users/kp/.cache/act/aquasecurity-trivy-action@ed142fd0673e97e23eac54620cfb913e5ce36c25/ dst=/var/run/act/actions/aquasecurity-trivy-action@ed142fd0673e97e23eac54620cfb913e5ce36c25/
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ] ⭐ Run Main Install Trivy
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   🐳  docker cp src=/Users/kp/.cache/act/aquasecurity-setup-trivy@3fb12ec12f41e471780db15c232d5dd185dcb514/ dst=/var/run/act/actions/aquasecurity-setup-trivy@3fb12ec12f41e471780db15c232d5dd185dcb514/
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ] ⭐ Run Main Binary dir
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   🐳  docker exec cmd=[bash --noprofile --norc -e -o pipefail /var/run/act/workflow/3-composite-0-composite-binary-dir.sh] user= workdir=
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ✅  Success - Main Binary dir [44.429ms]
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ⚙  ::set-output:: dir=/root/.local/bin/trivy-bin
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ] ⭐ Run Main Restore Trivy binary from cache
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   🐳  docker cp src=/Users/kp/.cache/act/actions-cache-restore@9255dc7a253b0ccc959486e2bca901246202afeb/ dst=/var/run/act/actions/actions-cache-restore@9255dc7a253b0ccc959486e2bca901246202afeb/
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   🐳  docker exec cmd=[/opt/acttoolcache/node/24.19.0/arm64/bin/node /var/run/act/actions/actions-cache-restore@9255dc7a253b0ccc959486e2bca901246202afeb/dist/restore-only/index.js] user= workdir=
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ⚙  ***
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | Cache Size: ~41 MB (42628276 B)
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | [command]/usr/bin/tar -xf /tmp/3bef7fbe-0a7f-4621-8a52-5e32112c9066/cache.tzst -P -C /Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment --use-compress-program unzstd
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | /usr/bin/tar: Year/Devops/SST-Assignments/DevOps-Assignment: Not found in archive
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | /usr/bin/tar: Exiting with failure status due to previous errors
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   🚧  ::warning::Failed to restore: "/usr/bin/tar" failed with error: The process '/usr/bin/tar' failed with exit code 2
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | Cache not found for input keys: trivy-binary-v0.75.0-Linux-ARM64
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ✅  Success - Main Restore Trivy binary from cache [1.362698625s]
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ⚙  ::set-output:: cache-primary-key=trivy-binary-v0.75.0-Linux-ARM64
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ] ⭐ Run Main Checkout install script
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   🐳  docker cp src=/Users/kp/.cache/act/actions-checkout@8e8c483db84b4bee98b60c0593521ed34d9990e8/ dst=/var/run/act/actions/actions-checkout@8e8c483db84b4bee98b60c0593521ed34d9990e8/
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   🐳  docker exec cmd=[/opt/acttoolcache/node/24.19.0/arm64/bin/node /var/run/act/actions/actions-checkout@8e8c483db84b4bee98b60c0593521ed34d9990e8/dist/index.js] user= workdir=
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ❓ add-matcher /run/act/actions/actions-checkout@8e8c483db84b4bee98b60c0593521ed34d9990e8/dist/problem-matcher.json
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | Syncing repository: aquasecurity/trivy
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ❓  ::group::Getting Git version info
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | Working directory is '/Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment/trivy'
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | [command]/usr/bin/git version
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | git version 2.55.0
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ❓  ::endgroup::
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ⚙  ***
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | Temporarily overriding HOME='/tmp/82fada77-24be-4ba2-86a4-7c5426c2cb17' before making global git config changes
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | Adding repository directory to the temporary git global config as a safe directory
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | [command]/usr/bin/git config --global --add safe.directory /Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment/trivy
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ❓  ::group::Initializing the repository
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | [command]/usr/bin/git init /Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment/trivy
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | hint: Using 'master' as the name for the initial branch. This default branch name
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | hint: will change to "main" in Git 3.0. To configure the initial branch name
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | hint: to use in all of your new repositories, which will suppress this warning,
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | hint: call:
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | hint:
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | hint: 	git config --global init.defaultBranch <name>
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | hint:
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | hint: Names commonly chosen instead of 'master' are 'main', 'trunk' and
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | hint: 'development'. The just-created branch can be renamed via this command:
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | hint:
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | hint: 	git branch -m <name>
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | hint:
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | hint: Disable this message with "git config set advice.defaultBranchName false"
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | Initialized empty Git repository in /Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment/trivy/.git/
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | [command]/usr/bin/git remote add origin https://github.com/aquasecurity/trivy
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ❓  ::endgroup::
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ❓  ::group::Disabling automatic garbage collection
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | [command]/usr/bin/git config --local gc.auto 0
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ❓  ::endgroup::
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ❓  ::group::Setting up auth
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | Removing SSH command configuration
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | [command]/usr/bin/git config --local --name-only --get-regexp core\.sshCommand
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | [command]/usr/bin/git submodule foreach --recursive sh -c "git config --local --name-only --get-regexp 'core\.sshCommand' && git config --local --unset-all 'core.sshCommand' || :"
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | Removing HTTP extra header
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | [command]/usr/bin/git config --local --name-only --get-regexp http\.https\:\/\/github\.com\/\.extraheader
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | [command]/usr/bin/git submodule foreach --recursive sh -c "git config --local --name-only --get-regexp 'http\.https\:\/\/github\.com\/\.extraheader' && git config --local --unset-all 'http.https://github.com/.extraheader' || :"
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | Removing includeIf entries pointing to credentials config files
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | [command]/usr/bin/git config --local --name-only --get-regexp ^includeIf\.gitdir:
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | [command]/usr/bin/git submodule foreach --recursive git config --local --show-origin --name-only --get-regexp remote.origin.url
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | [command]/usr/bin/git config --file /tmp/git-credentials-f1d89335-55a0-4593-b8aa-83eb542112bc.config http.https://github.com/.extraheader AUTHORIZATION: basic ***
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | [command]/usr/bin/git config --local includeIf.gitdir:/Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment/trivy/.git.path /tmp/git-credentials-f1d89335-55a0-4593-b8aa-83eb542112bc.config
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | [command]/usr/bin/git config --local includeIf.gitdir:/Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment/trivy/.git/worktrees/*.path /tmp/git-credentials-f1d89335-55a0-4593-b8aa-83eb542112bc.config
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | [command]/usr/bin/git config --local includeIf.gitdir:/github/workspace/trivy/.git.path /github/runner_temp/git-credentials-f1d89335-55a0-4593-b8aa-83eb542112bc.config
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | [command]/usr/bin/git config --local includeIf.gitdir:/github/workspace/trivy/.git/worktrees/*.path /github/runner_temp/git-credentials-f1d89335-55a0-4593-b8aa-83eb542112bc.config
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ❓  ::endgroup::
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ❓  ::group::Fetching the repository
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | [command]/usr/bin/git -c protocol.version=2 fetch --no-tags --prune --no-recurse-submodules --filter=blob:none --depth=1 origin 75c4dc0f45c5d7ffd05ae26df1e0c666787bdf2a
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | From https://github.com/aquasecurity/trivy
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   |  * branch            75c4dc0f45c5d7ffd05ae26df1e0c666787bdf2a -> FETCH_HEAD
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ❓  ::endgroup::
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ❓  ::group::Determining the checkout info
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ❓  ::endgroup::
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ❓  ::group::Setting up sparse checkout
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | [command]/usr/bin/git sparse-checkout set contrib
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ❓  ::endgroup::
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ❓  ::group::Checking out the ref
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | [command]/usr/bin/git checkout --progress --force 75c4dc0f45c5d7ffd05ae26df1e0c666787bdf2a
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | Updating files:   3% (1/28)Updating files:   7% (2/28)Updating files:  10% (3/28)Updating files:  14% (4/28)Updating files:  17% (5/28)Updating files:  21% (6/28)Updating files:  25% (7/28)Updating files:  28% (8/28)Updating files:  32% (9/28)Updating files:  35% (10/28)Updating files:  39% (11/28)Updating files:  42% (12/28)Updating files:  46% (13/28)Updating files:  50% (14/28)Updating files:  53% (15/28)Updating files:  57% (16/28)Updating files:  60% (17/28)Updating files:  64% (18/28)Updating files:  67% (19/28)Updating files:  71% (20/28)Updating files:  75% (21/28)Updating files:  78% (22/28)Updating files:  82% (23/28)Updating files:  85% (24/28)Updating files:  89% (25/28)Updating files:  92% (26/28)Updating files:  96% (27/28)Updating files: 100% (28/28)Updating files: 100% (28/28), done.
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | Note: switching to '75c4dc0f45c5d7ffd05ae26df1e0c666787bdf2a'.
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | 
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | You are in 'detached HEAD' state. You can look around, make experimental
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | changes and commit them, and you can discard any commits you make in this
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | state without impacting any branches by switching back to a branch.
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | 
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | If you want to create a new branch to retain commits you create, you may
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | do so (now or later) by using -c with the switch command. Example:
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | 
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   |   git switch -c <new-branch-name>
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | 
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | Or undo this operation with:
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | 
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   |   git switch -
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | 
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | Turn off this advice by setting config variable advice.detachedHead to false
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | 
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | HEAD is now at 75c4dc0 chore: add client option to install script (#9962)
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ❓  ::endgroup::
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | [command]/usr/bin/git log -1 --format=%H
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | 75c4dc0f45c5d7ffd05ae26df1e0c666787bdf2a
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ❓  ::remove-matcher owner=checkout-git::
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ✅  Success - Main Checkout install script [3.323768208s]
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ⚙  ::set-output:: commit=75c4dc0f45c5d7ffd05ae26df1e0c666787bdf2a
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ⚙  ::set-output:: ref=
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ] ⭐ Run Main Install Trivy
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   🐳  docker exec cmd=[bash --noprofile --norc -e -o pipefail /var/run/act/workflow/3-composite-0-composite-4.sh] user= workdir=
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | installing Trivy binary
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | aquasecurity/trivy info checking GitHub for tag 'v0.75.0'
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | aquasecurity/trivy info found version: 0.75.0 for v0.75.0/Linux/ARM64
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | aquasecurity/trivy info installed /root/.local/bin/trivy-bin/trivy
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ✅  Success - Main Install Trivy [10.536376667s]
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ] ⭐ Run Main Add Trivy binary to $GITHUB_PATH
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   🐳  docker exec cmd=[bash --noprofile --norc -e -o pipefail /var/run/act/workflow/3-composite-0-composite-5.sh] user= workdir=
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ✅  Success - Main Add Trivy binary to $GITHUB_PATH [51.057208ms]
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ⚙  ::add-path:: /root/.local/bin/trivy-bin
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ] ⭐ Run Main Save Trivy binary to cache
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   🐳  docker cp src=/Users/kp/.cache/act/actions-cache-save@9255dc7a253b0ccc959486e2bca901246202afeb/ dst=/var/run/act/actions/actions-cache-save@9255dc7a253b0ccc959486e2bca901246202afeb/
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   🐳  docker exec cmd=[/opt/acttoolcache/node/24.19.0/arm64/bin/node /var/run/act/actions/actions-cache-save@9255dc7a253b0ccc959486e2bca901246202afeb/dist/save-only/index.js] user= workdir=
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | [command]/usr/bin/tar --posix -cf cache.tzst --exclude cache.tzst -P -C /Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment --files-from manifest.txt --use-compress-program zstdmt
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | /usr/bin/tar: /Users/kp/SST/3rd: Cannot open: No such file or directory
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | /usr/bin/tar: Error is not recoverable: exiting now
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   🚧  ::warning::Failed to save: "/usr/bin/tar" failed with error: The process '/usr/bin/tar' failed with exit code 2
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   🚧  ::warning::Cache save failed.
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ✅  Success - Main Save Trivy binary to cache [1.122513834s]
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ✅  Success - Main Install Trivy [16.788662917s]
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ] ⭐ Run Main Get current date
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   🐳  docker exec cmd=[bash --noprofile --norc -e -o pipefail /var/run/act/workflow/3-composite-date.sh] user= workdir=
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ✅  Success - Main Get current date [67.8135ms]
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ⚙  ::set-output:: date=2026-10-07
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ] ⭐ Run Main Restore DB from cache
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   🐳  docker cp src=/Users/kp/.cache/act/actions-cache@27d5ce7f107fe9357f9df03efb73ab90386fccae/ dst=/var/run/act/actions/actions-cache@27d5ce7f107fe9357f9df03efb73ab90386fccae/
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   🐳  docker exec cmd=[/opt/acttoolcache/node/24.19.0/arm64/bin/node /var/run/act/actions/actions-cache@27d5ce7f107fe9357f9df03efb73ab90386fccae/dist/restore/index.js] user= workdir=
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | Cache not found for input keys: cache-trivy-2026-10-07, cache-trivy-
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ✅  Success - Main Restore DB from cache [1.362542416s]
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ] ⭐ Run Main Set GitHub Path
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   🐳  docker exec cmd=[bash --noprofile --norc -e -o pipefail /var/run/act/workflow/3-composite-3.sh] user= workdir=
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ✅  Success - Main Set GitHub Path [106.544333ms]
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ⚙  ::add-path:: /var/run/act/actions/aquasecurity-trivy-action@ed142fd0673e97e23eac54620cfb913e5ce36c25
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ] ⭐ Run Main Clear Trivy Envs file
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   🐳  docker exec cmd=[bash --noprofile --norc -e -o pipefail /var/run/act/workflow/3-composite-4.sh] user= workdir=
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ✅  Success - Main Clear Trivy Envs file [85.306541ms]
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ] ⭐ Run Main Set Trivy environment variables
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   🐳  docker exec cmd=[bash --noprofile --norc -e -o pipefail /var/run/act/workflow/3-composite-5.sh] user= workdir=
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ✅  Success - Main Set Trivy environment variables [135.619333ms]
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ] ⭐ Run Main Run Trivy
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   🐳  docker exec cmd=[bash --noprofile --norc -e -o pipefail /var/run/act/workflow/3-composite-6.sh] user= workdir=
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | Found ignorefile 'Final-DevOps-Project-&-Troubleshooting/security/.trivyignore':
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | # Trivy ignore file (SCA "trivy fs", container image scans and the IaC "trivy config" scan).
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | #
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | # Add one ID per line ONLY when the risk is accepted, with a reason and an expiry date.
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | # The security gate does not count ignored findings. Review this file before each expiry date.
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | 
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | # AWS-0104 (CRITICAL, terraform/security.tf): the EKS cluster and node security groups allow all outbound traffic.
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | # Reason: the nodes must reach GHCR/ECR, the AWS APIs and the NAT gateway. The VPC has no proxy or VPC endpoints yet.
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | # Plan: add VPC endpoints (ECR, S3, STS) and an egress proxy, then restrict egress to them.
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | AWS-0104 exp:2027-03-31
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | Running Trivy with options: trivy image .
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ✅  Success - Main Run Trivy [19.4880345s]
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ] ⭐ Run Main Remove Trivy Envs file
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   🐳  docker exec cmd=[bash --noprofile --norc -e -o pipefail /var/run/act/workflow/3-composite-7.sh] user= workdir=
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ✅  Success - Main Remove Trivy Envs file [68.346209ms]
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ✅  Success - Main Scan the backend image (Trivy) [38.802375792s]
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ] ⭐ Run Main Scan the frontend image (Trivy)
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   🐳  docker cp src=/Users/kp/.cache/act/aquasecurity-trivy-action@ed142fd0673e97e23eac54620cfb913e5ce36c25/ dst=/var/run/act/actions/aquasecurity-trivy-action@ed142fd0673e97e23eac54620cfb913e5ce36c25/
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ] ⭐ Run Main Get current date
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   🐳  docker exec cmd=[bash --noprofile --norc -e -o pipefail /var/run/act/workflow/4-composite-date.sh] user= workdir=
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ✅  Success - Main Get current date [65.179417ms]
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ⚙  ::set-output:: date=2026-10-07
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ] ⭐ Run Main Restore DB from cache
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   🐳  docker cp src=/Users/kp/.cache/act/actions-cache@27d5ce7f107fe9357f9df03efb73ab90386fccae/ dst=/var/run/act/actions/actions-cache@27d5ce7f107fe9357f9df03efb73ab90386fccae/
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   🐳  docker exec cmd=[/opt/acttoolcache/node/24.19.0/arm64/bin/node /var/run/act/actions/actions-cache@27d5ce7f107fe9357f9df03efb73ab90386fccae/dist/restore/index.js] user= workdir=
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | Cache not found for input keys: cache-trivy-2026-10-07, cache-trivy-
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ✅  Success - Main Restore DB from cache [980.03275ms]
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ] ⭐ Run Main Set GitHub Path
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   🐳  docker exec cmd=[bash --noprofile --norc -e -o pipefail /var/run/act/workflow/4-composite-3.sh] user= workdir=
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ✅  Success - Main Set GitHub Path [91.023292ms]
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ⚙  ::add-path:: /var/run/act/actions/aquasecurity-trivy-action@ed142fd0673e97e23eac54620cfb913e5ce36c25
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ] ⭐ Run Main Clear Trivy Envs file
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   🐳  docker exec cmd=[bash --noprofile --norc -e -o pipefail /var/run/act/workflow/4-composite-4.sh] user= workdir=
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ✅  Success - Main Clear Trivy Envs file [69.12225ms]
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ] ⭐ Run Main Set Trivy environment variables
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   🐳  docker exec cmd=[bash --noprofile --norc -e -o pipefail /var/run/act/workflow/4-composite-5.sh] user= workdir=
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ✅  Success - Main Set Trivy environment variables [58.851375ms]
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ] ⭐ Run Main Run Trivy
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   🐳  docker exec cmd=[bash --noprofile --norc -e -o pipefail /var/run/act/workflow/4-composite-6.sh] user= workdir=
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | Found ignorefile 'Final-DevOps-Project-&-Troubleshooting/security/.trivyignore':
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | # Trivy ignore file (SCA "trivy fs", container image scans and the IaC "trivy config" scan).
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | #
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | # Add one ID per line ONLY when the risk is accepted, with a reason and an expiry date.
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | # The security gate does not count ignored findings. Review this file before each expiry date.
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | 
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | # AWS-0104 (CRITICAL, terraform/security.tf): the EKS cluster and node security groups allow all outbound traffic.
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | # Reason: the nodes must reach GHCR/ECR, the AWS APIs and the NAT gateway. The VPC has no proxy or VPC endpoints yet.
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | # Plan: add VPC endpoints (ECR, S3, STS) and an egress proxy, then restrict egress to them.
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | AWS-0104 exp:2027-03-31
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | Running Trivy with options: trivy image .
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ✅  Success - Main Run Trivy [609.572292ms]
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ] ⭐ Run Main Remove Trivy Envs file
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   🐳  docker exec cmd=[bash --noprofile --norc -e -o pipefail /var/run/act/workflow/4-composite-7.sh] user= workdir=
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ✅  Success - Main Remove Trivy Envs file [86.08925ms]
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ✅  Success - Main Scan the frontend image (Trivy) [2.49820825s]
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ] ⭐ Run Main Show the scan results (counts and HIGH/CRITICAL tables)
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   🐳  docker exec cmd=[bash --noprofile --norc -e -o pipefail /var/run/act/workflow/5.sh] user= workdir=Final-DevOps-Project-&-Troubleshooting
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | == backend
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | /tmp/images/backend.tar | fixed vulnerabilities by severity: none
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | == frontend
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | /tmp/images/frontend.tar | fixed vulnerabilities by severity: none
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ✅  Success - Main Show the scan results (counts and HIGH/CRITICAL tables) [351.547334ms]
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ] ⭐ Run Main Upload image scan reports
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   🐳  docker cp src=/Users/kp/.cache/act/actions-upload-artifact@v4/ dst=/var/run/act/actions/actions-upload-artifact@v4/
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   🐳  docker exec cmd=[/opt/acttoolcache/node/24.19.0/arm64/bin/node /var/run/act/actions/actions-upload-artifact@v4/dist/upload/index.js] user= workdir=
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | (node:515) [DEP0040] DeprecationWarning: The `punycode` module is deprecated. Please use a userland alternative instead.
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | (Use `node --trace-deprecation ...` to show where the warning was created)
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | Multiple search paths detected. Calculating the least common ancestor of all paths
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | The least common ancestor is /Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment/Final-DevOps-Project-&-Troubleshooting/reports. This will be the root directory of the artifact
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | With the provided path, there will be 2 files uploaded
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | Artifact name is valid!
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | Root directory input is valid!
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | Beginning upload of artifact content to blob storage
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | (node:515) [DEP0169] DeprecationWarning: `url.parse()` behavior is not standardized and prone to errors that have security implications. Use the WHATWG URL API instead. CVEs are not issued for `url.parse()` vulnerabilities.
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | Uploaded bytes 64095
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | Finished uploading artifact content to blob storage!
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | SHA256 digest of uploaded artifact zip is 5a93833e96b7524df33787f8c50a2b4a6fd6835d2617df2cb37854693f6952f7
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | Finalizing artifact upload
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | Artifact image-scan-report.zip successfully finalized. Artifact ID 4235555473
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | Artifact image-scan-report has been successfully uploaded! Final size is 64095 bytes. Artifact ID is 4235555473
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | Artifact download URL: https://github.com/kartavya37/DevOps-Assignment/actions/runs/1/artifacts/4235555473
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ✅  Success - Main Upload image scan reports [997.116541ms]
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ⚙  ::set-output:: artifact-id=4235555473
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ⚙  ::set-output:: artifact-digest=5a93833e96b7524df33787f8c50a2b4a6fd6835d2617df2cb37854693f6952f7
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ⚙  ::set-output:: artifact-url=https://github.com/kartavya37/DevOps-Assignment/actions/runs/1/artifacts/4235555473
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ] ⭐ Run Post Scan the frontend image (Trivy)
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   🐳  docker cp src=/Users/kp/.cache/act/aquasecurity-trivy-action@ed142fd0673e97e23eac54620cfb913e5ce36c25/ dst=/var/run/act/actions/aquasecurity-trivy-action@ed142fd0673e97e23eac54620cfb913e5ce36c25/
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ] ⭐ Run Post Restore DB from cache
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   🐳  docker exec cmd=[/opt/acttoolcache/node/24.19.0/arm64/bin/node /var/run/act/actions/actions-cache@27d5ce7f107fe9357f9df03efb73ab90386fccae/dist/save/index.js] user= workdir=
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | [command]/usr/bin/tar --posix -cf cache.tzst --exclude cache.tzst -P -C /Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment --files-from manifest.txt --use-compress-program zstdmt
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | /usr/bin/tar: /Users/kp/SST/3rd: Cannot open: No such file or directory
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | /usr/bin/tar: Error is not recoverable: exiting now
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   🚧  ::warning::Failed to save: "/usr/bin/tar" failed with error: The process '/usr/bin/tar' failed with exit code 2
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ✅  Success - Post Restore DB from cache [192.462667ms]
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ✅  Success - Post Scan the frontend image (Trivy) [333.513625ms]
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ] ⭐ Run Post Scan the backend image (Trivy)
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   🐳  docker cp src=/Users/kp/.cache/act/aquasecurity-trivy-action@ed142fd0673e97e23eac54620cfb913e5ce36c25/ dst=/var/run/act/actions/aquasecurity-trivy-action@ed142fd0673e97e23eac54620cfb913e5ce36c25/
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ] ⭐ Run Post Restore DB from cache
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   🐳  docker exec cmd=[/opt/acttoolcache/node/24.19.0/arm64/bin/node /var/run/act/actions/actions-cache@27d5ce7f107fe9357f9df03efb73ab90386fccae/dist/save/index.js] user= workdir=
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | [command]/usr/bin/tar --posix -cf cache.tzst --exclude cache.tzst -P -C /Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment --files-from manifest.txt --use-compress-program zstdmt
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | /usr/bin/tar: /Users/kp/SST/3rd: Cannot open: No such file or directory
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   | /usr/bin/tar: Error is not recoverable: exiting now
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   🚧  ::warning::Failed to save: "/usr/bin/tar" failed with error: The process '/usr/bin/tar' failed with exit code 2
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ✅  Success - Post Restore DB from cache [235.1495ms]
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ] ⭐ Run Post Install Trivy
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   🐳  docker cp src=/Users/kp/.cache/act/aquasecurity-setup-trivy@3fb12ec12f41e471780db15c232d5dd185dcb514/ dst=/var/run/act/actions/aquasecurity-setup-trivy@3fb12ec12f41e471780db15c232d5dd185dcb514/
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ] ⭐ Run Post Checkout install script
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   🐳  docker exec cmd=[/opt/acttoolcache/node/24.19.0/arm64/bin/node /var/run/act/actions/actions-checkout@8e8c483db84b4bee98b60c0593521ed34d9990e8/dist/index.js] user= workdir=
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ✅  Success - Post Checkout install script [112.065708ms]
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ✅  Success - Post Install Trivy [204.71575ms]
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ✅  Success - Post Scan the backend image (Trivy) [683.082042ms]
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ] ⭐ Run Complete job
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ] Cleaning up container for job 7. Image Scan (Trivy)
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ]   ✅  Success - Complete job
[S21 Final Project Pipeline/7. Image Scan (Trivy)                  ] 🏁  Job succeeded
[S21 Final Project Pipeline/8. Security Gate                       ] ⭐ Run Set up job
[S21 Final Project Pipeline/8. Security Gate                       ] 🚀  Start image=catthehacker/ubuntu:act-latest
[S21 Final Project Pipeline/8. Security Gate                       ]   🐳  docker pull image=catthehacker/ubuntu:act-latest platform=linux/arm64 username= forcePull=false
[S21 Final Project Pipeline/8. Security Gate                       ]   🐳  docker create image=catthehacker/ubuntu:act-latest platform=linux/arm64 entrypoint=["tail" "-f" "/dev/null"] cmd=[] network="host"
[S21 Final Project Pipeline/8. Security Gate                       ]   🐳  docker run image=catthehacker/ubuntu:act-latest platform=linux/arm64 entrypoint=["tail" "-f" "/dev/null"] cmd=[] network="host"
[S21 Final Project Pipeline/8. Security Gate                       ]   🐳  docker exec cmd=[node --no-warnings -e console.log(process.execPath)] user= workdir=
[S21 Final Project Pipeline/8. Security Gate                       ]   ✅  Success - Set up job
[S21 Final Project Pipeline/8. Security Gate                       ]   ☁  git clone 'https://github.com/actions/download-artifact' # ref=v4
[S21 Final Project Pipeline/8. Security Gate                       ] ⭐ Run Main Checkout source code
[S21 Final Project Pipeline/8. Security Gate                       ]   🐳  docker cp src=/Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment/. dst=/Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment
[S21 Final Project Pipeline/8. Security Gate                       ]   ✅  Success - Main Checkout source code [1.151840292s]
[S21 Final Project Pipeline/8. Security Gate                       ] ⭐ Run Main Download all scan reports
[S21 Final Project Pipeline/8. Security Gate                       ]   🐳  docker cp src=/Users/kp/.cache/act/actions-download-artifact@v4/ dst=/var/run/act/actions/actions-download-artifact@v4/
[S21 Final Project Pipeline/8. Security Gate                       ]   🐳  docker exec cmd=[/opt/acttoolcache/node/24.19.0/arm64/bin/node /var/run/act/actions/actions-download-artifact@v4/dist/index.js] user= workdir=
[S21 Final Project Pipeline/8. Security Gate                       ]   | (node:31) [DEP0040] DeprecationWarning: The `punycode` module is deprecated. Please use a userland alternative instead.
[S21 Final Project Pipeline/8. Security Gate                       ]   | (Use `node --trace-deprecation ...` to show where the warning was created)
[S21 Final Project Pipeline/8. Security Gate                       ]   | Found 7 artifact(s)
[S21 Final Project Pipeline/8. Security Gate                       ]   | Filtering artifacts by pattern '*-report'
[S21 Final Project Pipeline/8. Security Gate                       ]   | Preparing to download the following artifacts:
[S21 Final Project Pipeline/8. Security Gate                       ]   | - image-scan-report (ID: 4235555473, Size: 96, Expected Digest: undefined)
[S21 Final Project Pipeline/8. Security Gate                       ]   | - sca-report (ID: 3243087279, Size: 96, Expected Digest: undefined)
[S21 Final Project Pipeline/8. Security Gate                       ]   | - iac-report (ID: 1472450981, Size: 96, Expected Digest: undefined)
[S21 Final Project Pipeline/8. Security Gate                       ]   | - secret-scan-report (ID: 761529410, Size: 96, Expected Digest: undefined)
[S21 Final Project Pipeline/8. Security Gate                       ]   | - sast-report (ID: 574075399, Size: 96, Expected Digest: undefined)
[S21 Final Project Pipeline/8. Security Gate                       ]   | Redirecting to blob download url: http://0.0.0.0:18791/twirp/github.actions.results.api.v1.ArtifactService/DownloadArtifact
[S21 Final Project Pipeline/8. Security Gate                       ]   | Starting download of artifact to: /Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment/Final-DevOps-Project-&-Troubleshooting/reports
[S21 Final Project Pipeline/8. Security Gate                       ]   | (node:31) [DEP0005] DeprecationWarning: Buffer() is deprecated due to security and usability issues. Please use the Buffer.alloc(), Buffer.allocUnsafe(), or Buffer.from() methods instead.
[S21 Final Project Pipeline/8. Security Gate                       ]   | Redirecting to blob download url: http://0.0.0.0:18791/twirp/github.actions.results.api.v1.ArtifactService/DownloadArtifact
[S21 Final Project Pipeline/8. Security Gate                       ]   | Starting download of artifact to: /Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment/Final-DevOps-Project-&-Troubleshooting/reports
[S21 Final Project Pipeline/8. Security Gate                       ]   | Redirecting to blob download url: http://0.0.0.0:18791/twirp/github.actions.results.api.v1.ArtifactService/DownloadArtifact
[S21 Final Project Pipeline/8. Security Gate                       ]   | Starting download of artifact to: /Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment/Final-DevOps-Project-&-Troubleshooting/reports
[S21 Final Project Pipeline/8. Security Gate                       ]   | Redirecting to blob download url: http://0.0.0.0:18791/twirp/github.actions.results.api.v1.ArtifactService/DownloadArtifact
[S21 Final Project Pipeline/8. Security Gate                       ]   | Starting download of artifact to: /Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment/Final-DevOps-Project-&-Troubleshooting/reports
[S21 Final Project Pipeline/8. Security Gate                       ]   | Redirecting to blob download url: http://0.0.0.0:18791/twirp/github.actions.results.api.v1.ArtifactService/DownloadArtifact
[S21 Final Project Pipeline/8. Security Gate                       ]   | Starting download of artifact to: /Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment/Final-DevOps-Project-&-Troubleshooting/reports
[S21 Final Project Pipeline/8. Security Gate                       ]   | SHA256 digest of downloaded artifact is 1d347b93eba363a331ea28a79963a6237c200241b78b9342ba0187f3085be8e8
[S21 Final Project Pipeline/8. Security Gate                       ]   | Artifact download completed successfully.
[S21 Final Project Pipeline/8. Security Gate                       ]   | SHA256 digest of downloaded artifact is efac1480ca570eceb174f23d8dd5ab40b3138221542157f752124074bdaf5a70
[S21 Final Project Pipeline/8. Security Gate                       ]   | Artifact download completed successfully.
[S21 Final Project Pipeline/8. Security Gate                       ]   | SHA256 digest of downloaded artifact is 5cc78c92ec791f7f8985a5610af77fdd36c8f2d8967874170005e3749301a549
[S21 Final Project Pipeline/8. Security Gate                       ]   | Artifact download completed successfully.
[S21 Final Project Pipeline/8. Security Gate                       ]   | SHA256 digest of downloaded artifact is a69b78b92ec101da32254af92585be485f3bef7f80d8c4b37b85519b1b12480b
[S21 Final Project Pipeline/8. Security Gate                       ]   | Artifact download completed successfully.
[S21 Final Project Pipeline/8. Security Gate                       ]   | SHA256 digest of downloaded artifact is 5a93833e96b7524df33787f8c50a2b4a6fd6835d2617df2cb37854693f6952f7
[S21 Final Project Pipeline/8. Security Gate                       ]   | Artifact download completed successfully.
[S21 Final Project Pipeline/8. Security Gate                       ]   | Total of 5 artifact(s) downloaded
[S21 Final Project Pipeline/8. Security Gate                       ]   | Download artifact has finished successfully
[S21 Final Project Pipeline/8. Security Gate                       ]   ✅  Success - Main Download all scan reports [589.238042ms]
[S21 Final Project Pipeline/8. Security Gate                       ]   ⚙  ::set-output:: download-path=/Users/kp/SST/3rd Year/Devops/SST-Assignments/DevOps-Assignment/Final-DevOps-Project-&-Troubleshooting/reports
[S21 Final Project Pipeline/8. Security Gate                       ] ⭐ Run Main Apply the security policy (block on HIGH/CRITICAL)
[S21 Final Project Pipeline/8. Security Gate                       ]   🐳  docker exec cmd=[bash --noprofile --norc -e -o pipefail /var/run/act/workflow/2.sh] user= workdir=Final-DevOps-Project-&-Troubleshooting
[S21 Final Project Pipeline/8. Security Gate                       ]   | total 636
[S21 Final Project Pipeline/8. Security Gate                       ]   | -rw-r--r-- 1 root root   2434 Oct  7 14:03 bandit.json
[S21 Final Project Pipeline/8. Security Gate                       ]   | -rw-r--r-- 1 root root    514 Oct  7 14:03 gitleaks.json
[S21 Final Project Pipeline/8. Security Gate                       ]   | -rw-r--r-- 1 root root    361 Oct  7 14:03 npm-audit.json
[S21 Final Project Pipeline/8. Security Gate                       ]   | -rw-r--r-- 1 root root   1719 Oct  7 14:03 pip-audit.json
[S21 Final Project Pipeline/8. Security Gate                       ]   | -rw-r--r-- 1 root root  64255 Oct  7 14:03 trivy-config.json
[S21 Final Project Pipeline/8. Security Gate                       ]   | -rw-r--r-- 1 root root   5598 Oct  7 14:03 trivy-fs.json
[S21 Final Project Pipeline/8. Security Gate                       ]   | -rw-r--r-- 1 root root 392668 Oct  7 14:03 trivy-image-backend.json
[S21 Final Project Pipeline/8. Security Gate                       ]   | -rw-r--r-- 1 root root 164571 Oct  7 14:03 trivy-image-frontend.json
[S21 Final Project Pipeline/8. Security Gate                       ]   | ==================================================================
[S21 Final Project Pipeline/8. Security Gate                       ]   | SECURITY GATE (block on HIGH/CRITICAL, any secret, fail closed)
[S21 Final Project Pipeline/8. Security Gate                       ]   | ==================================================================
[S21 Final Project Pipeline/8. Security Gate                       ]   | Stage        Tool            Findings  Blocking  Result
[S21 Final Project Pipeline/8. Security Gate                       ]   | -----------  --------------  --------  --------  ------
[S21 Final Project Pipeline/8. Security Gate                       ]   | SAST         Bandit          0         0         PASS  
[S21 Final Project Pipeline/8. Security Gate                       ]   | SCA          pip-audit       0         0         PASS  
[S21 Final Project Pipeline/8. Security Gate                       ]   | SCA          npm audit       0         0         PASS  
[S21 Final Project Pipeline/8. Security Gate                       ]   | SCA          Trivy fs        0         0         PASS  
[S21 Final Project Pipeline/8. Security Gate                       ]   | IaC          Trivy config    22        0         PASS  
[S21 Final Project Pipeline/8. Security Gate                       ]   | Secret scan  Gitleaks        1         1         FAIL  
[S21 Final Project Pipeline/8. Security Gate                       ]   | Image scan   Trivy backend   0         0         PASS  
[S21 Final Project Pipeline/8. Security Gate                       ]   | Image scan   Trivy frontend  0         0         PASS  
[S21 Final Project Pipeline/8. Security Gate                       ]   | 
[S21 Final Project Pipeline/8. Security Gate                       ]   | Blocking findings:
[S21 Final Project Pipeline/8. Security Gate                       ]   |   - [Gitleaks] generic-api-key in README.md:487
[S21 Final Project Pipeline/8. Security Gate                       ]   | 
[S21 Final Project Pipeline/8. Security Gate                       ]   | Security gate FAILED: the pipeline stops here. Fix the findings above.
[S21 Final Project Pipeline/8. Security Gate                       ]   ❌  Failure - Main Apply the security policy (block on HIGH/CRITICAL) [79.416667ms]
[S21 Final Project Pipeline/8. Security Gate                       ]   ⚙  Summary - ### Security gate

| Stage | Tool | Findings | Blocking | Result |
|---|---|---|---|---|
| SAST | Bandit | 0 | 0 | PASS |
| SCA | pip-audit | 0 | 0 | PASS |
| SCA | npm audit | 0 | 0 | PASS |
| SCA | Trivy fs | 0 | 0 | PASS |
| IaC | Trivy config | 22 | 0 | PASS |
| Secret scan | Gitleaks | 1 | 1 | FAIL |
| Image scan | Trivy backend | 0 | 0 | PASS |
| Image scan | Trivy frontend | 0 | 0 | PASS |

**Security gate FAILED: the pipeline stops here. Fix the findings above.**
- [Gitleaks] generic-api-key in README.md:487
[S21 Final Project Pipeline/8. Security Gate                       ] exitcode '1': failure
[S21 Final Project Pipeline/8. Security Gate                       ] ⭐ Run Complete job
[S21 Final Project Pipeline/8. Security Gate                       ]   ✅  Success - Complete job
[S21 Final Project Pipeline/8. Security Gate                       ] 🏁  Job failed
Error: Job '8. Security Gate' failed
act exit=1
