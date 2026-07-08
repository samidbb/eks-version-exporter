# eks-version-exporter

## Source Code

Project repository: https://github.com/samidbb/eks-version-exporter

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"samdidfds/eks-version-exporter"` |  |
| image.tag | string | `nil` |  |
| nameOverride | string | `""` |  |
| namespaceOverride | string | `""` |  |
| serviceMonitor.enabled | bool | `true` |  |
| serviceMonitor.interval | string | `"3600s"` |  |
| serviceMonitor.metricRelabelings[0].action | string | `"keep"` |  |
| serviceMonitor.metricRelabelings[0].regex | string | `"eks_version_exporter|eks_version_exporter_is_outdated|eks_version_exporter_is_past_eol"` |  |
| serviceMonitor.metricRelabelings[0].sourceLabels[0] | string | `"__name__"` |  |
| serviceMonitor.path | string | `"/metrics"` | default path is /metrics, but you can override it if you have a different path |
| serviceMonitor.releaseLabel | string | `"prometheus"` |  |
