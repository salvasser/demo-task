{{- define "symfony-chart.name" -}}
{{ .Chart.Name }}
{{- end }}

{{- define "symfony-chart.fullname" -}}
{{ .Release.Name }}
{{- end }}
