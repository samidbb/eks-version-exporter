# eks-version-exporter
Simple Prometheus exporter that helps keep EKS version up to date

## Helm chart

A Helm chart is available at [charts/eks-version-exporter](charts/eks-version-exporter).

Install from GitHub Pages:

```sh
helm repo add eks-version-exporter https://samidbb.github.io/eks-version-exporter
helm repo update
helm upgrade --install eks-version-exporter eks-version-exporter/eks-version-exporter
```

Install into a specific namespace:

```sh
helm upgrade --install eks-version-exporter eks-version-exporter/eks-version-exporter \
  --namespace monitoring \
  --create-namespace
```

Render/install to a specific namespace via chart value (useful for GitOps templating):

```sh
helm template eks-version-exporter eks-version-exporter/eks-version-exporter \
  --set namespaceOverride=monitoring
```

Render manifests locally with the published chart:

```sh
helm template eks-version-exporter eks-version-exporter/eks-version-exporter
```

Disable `ServiceMonitor` if Prometheus Operator CRDs are not installed:

```sh
helm install eks-version-exporter eks-version-exporter/eks-version-exporter \
  --set serviceMonitor.enabled=false
```

For local chart development from the repository root:

```sh
helm install eks-version-exporter ./charts/eks-version-exporter
```

Local chart install in a specific namespace:

```sh
helm install eks-version-exporter ./charts/eks-version-exporter \
  --namespace monitoring \
  --create-namespace
```

## Build and push image

This repository includes a [Makefile](Makefile) for building and pushing the Docker image.

Default values:
- image: `samdidfds/eks-version-exporter`
- tag: `latest`
- platform: `linux/amd64`

Commands:

```sh
make build
make push
make build-and-push
```

Important:
- `make push` and `make build-and-push` require `TAG` to be a semantic version (for example: `1.2.3`, `v1.2.3`, `1.2.3-rc.1`).
- `TAG=latest` is rejected for push targets.
- On push targets, `charts/eks-version-exporter/Chart.yaml` `version` is automatically patch-bumped.
- On push targets, `charts/eks-version-exporter/Chart.yaml` `appVersion` is automatically updated to match `TAG`.

Override tag and platform when needed:

```sh
make build TAG=v1.0.0 PLATFORM=linux/amd64
make push TAG=v1.0.0
make build-and-push TAG=v1.0.0 PLATFORM=linux/amd64
```


## Local chart development
Render chart locally:
```sh
helm template ./charts/eks-version-exporter
```

Generate Helm chart documentation (writes `charts/*/README.md`):

```sh
make helm-docs
```

Pre-commit integration:

```sh
pre-commit install
```

After installation, the `helm-docs` hook runs on each commit and refreshes chart documentation under `charts/`.
