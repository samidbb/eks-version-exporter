# eks-version-exporter

![Version: 0.1.3](https://img.shields.io/badge/Version-0.1.3-informational?style=flat-square)  ![AppVersion: 0.4.0](https://img.shields.io/badge/AppVersion-0.4.0-informational?style=flat-square)

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
| serviceMonitor.interval | string | `"3600s"` | default interval is 3600s |
| serviceMonitor.metricRelabelings | list | `[{"action":"keep","regex":"eks_version_exporter\|eks_version_exporter_is_outdated\|eks_version_exporter_is_past_eol","sourceLabels":["__name__"]}]` | default metric relabelings |
| serviceMonitor.path | string | `"/metrics"` | default path is /metrics |
| serviceMonitor.releaseLabel | string | `"prometheus"` | default release label is prometheus. Change this if you are using a different release name for your Prometheus Operator installation. |

