{{/* Chart name. */}}
{{- define "taskboard.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/* Full name: the release name, or "<release>-taskboard" if the release name does not contain the chart name. */}}
{{- define "taskboard.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else if contains (include "taskboard.name" .) .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name (include "taskboard.name" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/* Common labels. Call with (dict "ctx" . "component" "backend"). */}}
{{- define "taskboard.labels" -}}
helm.sh/chart: {{ printf "%s-%s" .ctx.Chart.Name .ctx.Chart.Version }}
app.kubernetes.io/managed-by: {{ .ctx.Release.Service }}
app.kubernetes.io/version: {{ .ctx.Chart.AppVersion | quote }}
{{ include "taskboard.selectorLabels" . }}
{{- end -}}

{{/* Selector labels. The "app" label is also the Loki/Alloy "app" label. */}}
{{- define "taskboard.selectorLabels" -}}
app.kubernetes.io/name: {{ include "taskboard.name" .ctx }}
app.kubernetes.io/instance: {{ .ctx.Release.Name }}
app.kubernetes.io/component: {{ .component }}
app: {{ include "taskboard.fullname" .ctx }}-{{ .component }}
{{- end -}}

{{- define "taskboard.secretName" -}}
{{- default (printf "%s-db" (include "taskboard.fullname" .)) .Values.database.existingSecret -}}
{{- end -}}

{{- define "taskboard.postgresHost" -}}
{{- printf "%s-postgres" (include "taskboard.fullname" .) -}}
{{- end -}}

{{/* Restricted container security context (non-root, no privilege escalation, read-only root file system). */}}
{{- define "taskboard.containerSecurityContext" -}}
allowPrivilegeEscalation: false
readOnlyRootFilesystem: true
capabilities:
  drop: ["ALL"]
{{- end -}}
