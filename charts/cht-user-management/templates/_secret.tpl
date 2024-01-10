{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "chtUserManagement.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Looks if there is an existing secret and reuse its key. If not generate a new key and use it.
*/}}
{{- define "chtUserManagement.COOKIE_PRIVATE_KEY" -}}
{{- $secret := (lookup "v1" "Secret" (.Release.Namespace) (include "chtUserManagement.fullname" .) ) }}
{{- if $secret }}
{{- index $secret "data" "COOKIE_PRIVATE_KEY" }}
{{- else }}
{{- (randAlphaNum 45) | b64enc | quote }}
{{- end }}
{{- end }}
