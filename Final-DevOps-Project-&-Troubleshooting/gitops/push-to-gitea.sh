#!/usr/bin/env bash
# Create the GitOps repository "taskboard-gitops" in the in-cluster Gitea and push the Helm chart.
#
# Before you run it:
#   kubectl port-forward -n gitea svc/gitea-http 18705:3000
#   export GITEA_USER=$(kubectl get secret gitea-admin -n gitea -o jsonpath='{.data.username}' | base64 -d)
#   export GITEA_PASS=$(kubectl get secret gitea-admin -n gitea -o jsonpath='{.data.password}' | base64 -d)
# The password stays in the environment. It is not written to a file or to the Git remote URL.
set -euo pipefail

: "${GITEA_USER:?set GITEA_USER}" "${GITEA_PASS:?set GITEA_PASS}"
GITEA="${GITEA:-http://127.0.0.1:18705}"
REPO=taskboard-gitops
HERE="$(cd "$(dirname "$0")" && pwd)"
WORK="${1:-$(mktemp -d)}"

# 1. Create the repository (public, so Argo CD needs no credentials). "409" = it exists already.
curl -s -o /dev/null -w "create repo: HTTP %{http_code}\n" -u "$GITEA_USER:$GITEA_PASS" \
  -X POST -H 'Content-Type: application/json' "$GITEA/api/v1/user/repos" \
  -d "{\"name\":\"$REPO\",\"private\":false,\"default_branch\":\"main\",\"description\":\"TaskBoard GitOps (Session 21)\"}"

# 2. Repository content: the Helm chart + the GitOps values file.
mkdir -p "$WORK"
cp -R "$HERE/../helm/taskboard" "$WORK/taskboard"
cp "$HERE/values-gitops.yaml" "$WORK/taskboard/values-gitops.yaml"
cat > "$WORK/README.md" <<'MD'
# taskboard-gitops

Desired state of the TaskBoard application. Argo CD syncs the Helm chart in `taskboard/`
with `values-dev.yaml` and `values-gitops.yaml` to the namespace `s21-gitops`.
Change the cluster only with a commit to this repository.
MD

# 3. Commit and push. The credential helper reads the password from the environment.
cd "$WORK"
git init -q -b main
git config user.name "Kartavya Panchal"
git config user.email ""
git config credential.helper '!f() { echo "username=$GITEA_USER"; echo "password=$GITEA_PASS"; }; f'
git add .
git commit -q -m "Add TaskBoard Helm chart and GitOps values"
git remote add origin "$GITEA/$GITEA_USER/$REPO.git"
git push -q -u origin main
git log --oneline

# 4. Webhook: Gitea tells Argo CD about each push (sync starts in a few seconds, not after the 60 s poll).
curl -s -o /dev/null -w "webhook: HTTP %{http_code}\n" -u "$GITEA_USER:$GITEA_PASS" \
  -X POST -H 'Content-Type: application/json' "$GITEA/api/v1/repos/$GITEA_USER/$REPO/hooks" \
  -d '{"type":"gitea","active":true,"events":["push"],"config":{"url":"http://argocd-server.argocd.svc.cluster.local/api/webhook","content_type":"json"}}'
echo "Repository work tree: $WORK"
