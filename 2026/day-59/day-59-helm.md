# Day 59 – Helm (Kubernetes Package Manager)

## What is Helm?

Helm is a package manager for Kubernetes that helps manage complex Kubernetes applications using reusable templates called charts. Instead of managing multiple YAML manifests manually, Helm allows deploying complete applications using a single command.

Helm simplifies:

- Application deployment
- Configuration management
- Version upgrades
- Rollbacks
- Environment consistency

Helm is similar to:

apt → Ubuntu packages  
yum → RHEL packages  
helm → Kubernetes packages  

---

## Core Helm Concepts

### Chart
A Helm Chart is a collection of Kubernetes YAML templates bundled together as an application package.

Example contents:

Deployment  
Service  
ConfigMap  
Secret  
PVC  

---

### Release

A Release is a running instance of a chart inside a Kubernetes cluster.

Example:

Chart → nginx  
Release → my-nginx  

You can install the same chart multiple times with different release names.

---

### Repository

A Repository is a collection of Helm charts.

Example:

Bitnami repo contains hundreds of production-ready charts.

---

## Helm Installation

Verify installation:

`helm version`

`helm env`

Example output:

version.BuildInfo{
Version:"v3.x.x"
}

Learning:

Helm v3 does not require Tiller (removed from Helm v2).

---

## Adding Repository

Add Bitnami repo:

`helm repo add bitnami https://charts.bitnami.com/bitnami`

Update repo:

`helm repo update`

Search charts:

`helm search repo nginx`

helm search repo bitnami

Learning:

Repositories act as package sources.

---

## Installing a Chart

Install nginx:

`helm install my-nginx bitnami/nginx`

Verify:

`helm list`

`kubectl get pods`

`kubectl get svc`

Inspect:

`helm status my-nginx`

`helm get manifest my-nginx`

Observation:

Helm created:

Deployment  
Service  
ConfigMap  

Learning:

One Helm command replaces multiple YAML files.

---

## Customizing Helm Values

View default values:

helm show values bitnami/nginx

Install with override:
```bash
helm install custom-nginx bitnami/nginx \
--set replicaCount=3 \
--set service.type=NodePort
```
---

## Using values.yaml

custom-values.yaml
```yaml
replicaCount: 3
service:
  type: NodePort
resources:
  limits:
    cpu: 200m
    memory: 256Mi
  requests:
    cpu: 100m
    memory: 128Mi
```
Install:
```bash
helm install nginx-custom bitnami/nginx \
-f custom-values.yaml
```

Verify:

`helm get values nginx-custom`

Learning:

values.yaml enables environment customization.

---

## Upgrade Helm Release

Upgrade:
```bash
helm upgrade my-nginx bitnami/nginx \
--set replicaCount=5
```
Verify:

`kubectl get pods`

Check history:

`helm history my-nginx`

Learning:

Helm tracks revisions automatically.

---

## Rollback Release

Rollback:

`helm rollback my-nginx 1`

Verify:

`helm history my-nginx`

Observation:

Rollback creates new revision.

Example:

Revision 1 → Install  
Revision 2 → Upgrade  
Revision 3 → Rollback  

Learning:

Rollback does not overwrite history.

---

## Creating Custom Helm Chart

Create chart:

helm create my-app

Structure:

my-app/

Chart.yaml  
values.yaml  
templates/  
charts/  

Important files:

Chart.yaml → metadata  
values.yaml → configuration  
templates → Kubernetes manifests  

---

## Go Template Basics

Example:

{{ .Values.replicaCount }}

Meaning:

Take value from values.yaml.

Example:

{{ .Chart.Name }}

Chart name.

Example:

{{ .Release.Name }}

Release name.

Learning:

Helm uses Go templating.

---

## Modify values.yaml

Example:

`replicaCount: 3`

image:

  `repository: nginx`

  `tag: "1.25"`

Validate:

`helm lint my-app`

Preview:

helm template my-release ./my-app

Install:

helm install my-release ./my-app

Upgrade:

helm upgrade my-release ./my-app \
--set replicaCount=5

Verify:

kubectl get pods

Learning:

Helm enables reusable infrastructure templates.

---

## Helm vs kubectl apply

| Feature | kubectl | Helm |
|---------|---------|------|
| Raw YAML | Yes | No |
| Templates | No | Yes |
| Version control | No | Yes |
| Rollback | Limited | Built-in |
| Reusability | Low | High |

Learning:

Helm improves Kubernetes maintainability.

---

## Important Helm Commands

helm list

helm status <release>

helm history <release>

helm get values <release>

helm uninstall <release>

helm upgrade <release>

helm rollback <release>

helm template

helm lint

---

## Key Learnings

Today I learned:

- Helm simplifies Kubernetes deployments
- Charts package Kubernetes resources
- Releases track deployments
- values.yaml enables configuration management
- Helm supports upgrade and rollback
- Helm uses Go templating
- Helm improves deployment consistency

Important production learning:

Helm is standard for production Kubernetes deployments.

---

## Learning Outcome

Today I learned how Helm simplifies Kubernetes application deployment using charts, values, and templates. I practiced installing charts, customizing configurations, upgrading releases, and performing rollbacks. I also created a custom Helm chart and understood Helm templating basics.

