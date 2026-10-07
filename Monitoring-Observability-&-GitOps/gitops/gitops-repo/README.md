# s20 GitOps demo repository

This folder is the content of the Git repository `gitops-admin/gitops-demo` on the in-cluster Gitea server.
Argo CD watches the `app/` path on the `main` branch and applies it to the cluster.

```text
app/
├── namespace.yaml
├── deployment.yaml
└── service.yaml
```

To change the application, edit a file in `app/`, then commit and push. Do not use `kubectl apply` or `kubectl edit`.
