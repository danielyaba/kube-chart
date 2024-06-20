{{- define "kube-chart.labels" -}}
app.kubernetes.io/name: {{ .Values.name }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernets.io/env: {{ .Values.env }}
app.kubernets.io/owner: {{ .Values.owner }}
app.kubernets.io/owner-team: {{ .Values.owner-team }}
app.kubernets.io/owner-email: {{ .Values.owner-email }}
{{- end -}}