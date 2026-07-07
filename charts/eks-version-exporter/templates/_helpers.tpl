{{- define "eks-version-exporter.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "eks-version-exporter.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- include "eks-version-exporter.name" . -}}
{{- end -}}
{{- end -}}

{{- define "eks-version-exporter.labels" -}}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}
app.kubernetes.io/name: {{ include "eks-version-exporter.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{- define "eks-version-exporter.selectorLabels" -}}
app: {{ include "eks-version-exporter.name" . }}
{{- end -}}

{{- define "eks-version-exporter.namespace" -}}
{{- default .Release.Namespace .Values.namespaceOverride -}}
{{- end -}}
