IMAGE ?= samdidfds/eks-version-exporter
TAG ?= latest
PLATFORM ?= linux/amd64
CHART_FILE ?= charts/eks-version-exporter/Chart.yaml

.PHONY: build push build-and-push update-chart-app-version guard-tag

build:
	docker build --platform $(PLATFORM) -t $(IMAGE):$(TAG) .

push: guard-tag update-chart-app-version
	docker push $(IMAGE):$(TAG)

guard-tag:
	@if [ "$(TAG)" = "latest" ]; then \
		echo "Error: TAG must not be 'latest' for push. Use TAG=<semver>."; \
		exit 1; \
	fi
	@echo "$(TAG)" | grep -Eq '^v?(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)(-([0-9A-Za-z-]+(\.[0-9A-Za-z-]+)*))?(\+([0-9A-Za-z-]+(\.[0-9A-Za-z-]+)*))?$$' || { \
		echo "Error: TAG must be semantic versioning (examples: 1.2.3, v1.2.3, 1.2.3-rc.1, 1.2.3+build.5)."; \
		exit 1; \
	}

update-chart-app-version:
	awk -v tag='$(TAG)' 'BEGIN { updated = 0 } /^appVersion:/ { print "appVersion: \"" tag "\""; updated = 1; next } { print } END { if (!updated) print "appVersion: \"" tag "\"" }' $(CHART_FILE) > $(CHART_FILE).tmp
	mv $(CHART_FILE).tmp $(CHART_FILE)

build-and-push: build push
