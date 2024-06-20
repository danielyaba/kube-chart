# Kube-Chart - Helm Library Chart For Reusable Kubernetes Templates

This Helm chart is a library which can simplified deployments with a single values file.

## Usage Guide

1. Create an application chart ('my-application')
```
my-application/
  ├── Chart.yaml
  ├── values.yaml
  └── templates/
      └── resources.yaml
```

2. Edit the Chart.yaml in my-application to include the library chart as a dependency:  
```
apiVersion: v2
name: my-application
description: A Helm chart for deploying my application
version: 0.1.0
dependencies:
- name: kube-chart
  version: "0.1.0"
  repository: "file://../kube-chart"

```

3. Create the resources.yaml in my-application which include relevent resources: 
```
{{- include "kube-chart.deployment" . }}
{{- include "kube-chart.service" . }}
{{- include "kube-chart.secret" . }}
{{- include "kube-chart.configmap" . }}
{{- include "kube-chart.serviceaccount" . }}
# Add more includes as needed
```

4. Define Application-specific Values in values.yaml
```
name: my-app
replicaCount: 2

image:
  repository: custom-repo/custom-app
  tag: v1.0.0

service:
  type: ClusterIP
  port: 8080

env:
  - name: ENV_VAR
    value: "value"

envFrom:
  - configMapRef: custom-config-map
  - secretRef: custom-secret

volumeMounts:
  - name: config-volume
    mountPath: /etc/config

volumes:
  - name: config-volume
    configMap:
      name: config-map-name

initContainers:
  - name: init-container
    image: busybox
    command: ["sh", "-c", "echo Init"]
    volumeMounts:
      - name: config-volume
        mountPath: /etc/config
```

## Examples

### Basic Example
This creates a simple deployment with service
```
name: my-app
deployment:
  create: true
  replicaCount: 2
  image: 
    repository: custom-repo/custom-image
    tag: v1.0.0

service:
  create: true
  type: ClusterIP
  port: 8080
```

### Service-Account
This creates a Service Account and adds it to the deployment.  
```
serviceAccount:
  create: true
  name: my-service-account
  annotations:
    iam.gke.io/gcp-service-account: my-app-sa@my-project.iam.gserviceaccount.com    
```

### 