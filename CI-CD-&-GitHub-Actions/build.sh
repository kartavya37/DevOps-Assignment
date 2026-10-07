#!/bin/bash
# Build step of the CI pipeline (adapted from 10-final-cicd-pipeline/build.sh).
# It packages the application source and writes build metadata into build/.
set -euo pipefail

echo "================================="
echo "Starting Application Build"
echo "================================="

rm -rf build
mkdir -p build/app
cp app/*.py build/app/
cp requirements.txt build/

cat > build/build-info.txt <<INFO
Application: Session 16 Calculator
Build Status: SUCCESS
Commit: ${GITHUB_SHA:-local}
Run number: ${GITHUB_RUN_NUMBER:-local}
Runner: ${RUNNER_OS:-$(uname -s)} / ${RUNNER_ARCH:-$(uname -m)}
Build Date: $(date -u +%Y-%m-%dT%H:%M:%SZ)
INFO

tar -czf build/calculator-app.tar.gz -C build app requirements.txt

echo ""
echo "Build files:"
find build -type f | sort
echo ""
cat build/build-info.txt
echo ""
echo "Build completed successfully."
