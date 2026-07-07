IMAGE ?= samdidfds/eks-version-exporter
TAG ?= latest
PLATFORM ?= linux/amd64

.PHONY: build push build-and-push

build:
	docker build --platform $(PLATFORM) -t $(IMAGE):$(TAG) .

push:
	docker push $(IMAGE):$(TAG)

build-and-push: build push
