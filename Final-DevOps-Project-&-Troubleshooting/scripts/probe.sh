#!/bin/bash
# scripts/probe.sh SECONDS OUTFILE: send one request every 0.2 s through the Ingress and write the HTTP status codes.
# Use it during "helm upgrade" or "helm rollback" to count failed requests.
end=$(( $(date +%s) + $1 )); : > "$2"
while [ $(date +%s) -lt $end ]; do curl -s -o /dev/null -m 2 -w "%{http_code}\n" -H "Host: taskboard.s21.local" http://localhost:18700/api/tasks/stats >> "$2"; sleep 0.2; done
