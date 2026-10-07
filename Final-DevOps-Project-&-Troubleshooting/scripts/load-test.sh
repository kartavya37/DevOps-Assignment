#!/usr/bin/env bash
# Modest in-cluster load test for the TaskBoard API (to show the HPA scale out).
#
# Usage:
#   scripts/load-test.sh start [NAMESPACE] [SECONDS] [WORKERS]   (defaults: s21-taskboard 180 2)
#   scripts/load-test.sh stop  [NAMESPACE]
#
# Each worker is one Pod of a Kubernetes Job. It sends GET requests to the backend Service
# (about 2% of them ask for a task that does not exist and get HTTP 404).
# "Connection: close" opens a new TCP connection for each request, so the Service
# spreads the requests over all backend Pods (also the new Pods that the HPA adds).
set -euo pipefail

ACTION="${1:-start}"
NS="${2:-s21-taskboard}"
DURATION="${3:-180}"
WORKERS="${4:-2}"
TARGET="${TARGET:-http://taskboard-backend:8000}"

if [ "$ACTION" = "stop" ]; then
  kubectl delete job taskboard-loadgen -n "$NS" --ignore-not-found
  exit 0
fi

kubectl delete job taskboard-loadgen -n "$NS" --ignore-not-found >/dev/null
cat <<YAML | kubectl apply -f -
apiVersion: batch/v1
kind: Job
metadata:
  name: taskboard-loadgen
  namespace: ${NS}
  labels:
    app: taskboard-loadgen
spec:
  parallelism: ${WORKERS}
  completions: ${WORKERS}
  backoffLimit: 0
  activeDeadlineSeconds: $((DURATION + 60))
  ttlSecondsAfterFinished: 300
  template:
    metadata:
      labels:
        app: taskboard-loadgen
    spec:
      restartPolicy: Never
      securityContext:
        runAsNonRoot: true
        runAsUser: 100
      containers:
        - name: loadgen
          image: curlimages/curl:latest
          imagePullPolicy: IfNotPresent
          command: ["sh", "-c"]
          args:
            - |
              end=\$(( \$(date +%s) + ${DURATION} ))
              n=0
              while [ \$(date +%s) -lt \$end ]; do
                curl -s -o /dev/null -H 'Connection: close' "${TARGET}/api/tasks?[1-200]"
                curl -s -o /dev/null -H 'Connection: close' "${TARGET}/api/tasks/stats?[1-200]"
                # A few requests for a task that does not exist (HTTP 404) for the error panel.
                curl -s -o /dev/null -H 'Connection: close' "${TARGET}/api/tasks/9999[0-9]"
                n=\$((n + 410))
              done
              echo "worker sent \$n requests"
          resources:
            requests: {cpu: 50m, memory: 16Mi}
            limits: {cpu: 300m, memory: 64Mi}
YAML
echo "Load test started: ${WORKERS} workers for ${DURATION}s against ${TARGET} (namespace ${NS})."
echo "Watch: kubectl get hpa -n ${NS} -w     Stop: $0 stop ${NS}"
