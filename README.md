# eks-version-exporter
Simple Prometheus exporter that helps keep EKS version up to date

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

Override tag and platform when needed:

```sh
make build TAG=v1.0.0 PLATFORM=linux/amd64
make build-and-push TAG=v1.0.0 PLATFORM=linux/amd64
```
