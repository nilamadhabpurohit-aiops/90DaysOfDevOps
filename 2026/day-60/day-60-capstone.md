# Day 60 – Kubernetes Capstone Project (WordPress + MySQL)

## Project Goal

The goal of this capstone was to deploy a real-world application stack using multiple Kubernetes concepts learned during the journey. The application consisted of a WordPress frontend and a MySQL backend deployed inside a dedicated namespace.

This exercise combined:

Namespaces  
Secrets  
ConfigMaps  
StatefulSets  
Deployments  
Services  
PVC  
Resource management  
Health probes  
HPA  

This was the first time combining all core Kubernetes primitives into one deployment.

---

## Architecture Overview

Architecture flow:

User → NodePort Service → WordPress Deployment → MySQL StatefulSet → Persistent Volume

Components used:

Namespace → capstone  
Secret → MySQL credentials  
ConfigMap → WordPress DB config  
StatefulSet → MySQL database  
Deployment → WordPress application  
PVC → Database storage  
Headless Service → MySQL DNS  
NodePort Service → WordPress access  
HPA → Autoscaling  
Probes → Health monitoring  

---

## Namespace Creation

Command:

`kubectl create namespace capstone`

Set default:

`kubectl config set-context --current --namespace=capstone`

Learning:

Namespaces isolate workloads.

---

## MySQL Deployment

Secret created:
```yaml
apiVersion: v1
kind: Secret

metadata:
  name: mysql-secret

type: Opaque

stringData:

  MYSQL_ROOT_PASSWORD: rootpass
  MYSQL_DATABASE: wordpress
  MYSQL_USER: wpuser
  MYSQL_PASSWORD: wppassword
```
StatefulSet used for MySQL.

Reason:

Stable identity  
Persistent storage  
Ordered startup  

Storage:

1Gi PVC mounted at:

/var/lib/mysql

Verification:

`kubectl exec -it mysql-0 -- mysql -u wpuser -pwppassword -e "SHOW DATABASES;"`

Result:

wordpress database visible.

Learning:

Stateful workloads require persistent storage.

---

## WordPress Deployment

Deployment created with:

2 replicas  
Resource limits  
Liveness probe  
Readiness probe  

ConfigMap used for:

WORDPRESS_DB_HOST
WORDPRESS_DB_NAME

Secret used for:

WORDPRESS_DB_USER
WORDPRESS_DB_PASSWORD

Learning:

ConfigMaps → configuration  
Secrets → credentials  

---

## WordPress Exposure

Service:

NodePort 30080

Access via:

`kubectl port-forward svc/wordpress 8080:80`

Verification:

WordPress setup page accessible.

Learning:

Services expose workloads.

---

## Self Healing Test

Test 1:

kubectl delete pod wordpress-xxxxx

Result:

New pod created automatically.

Test 2:

kubectl delete pod mysql-0

Result:

StatefulSet recreated pod.

Verification:

Website still working.

Learning:

Kubernetes self-healing works.

---

## Persistence Test

Created blog post.

Deleted MySQL pod.

After restart:

Blog post still present.

Reason:

PVC preserved data.

Learning:

Persistent storage survives pod deletion.

---

## Horizontal Pod Autoscaler

HPA created:

CPU target → 50%

Min replicas → 2

Max replicas → 10

Verification:

kubectl get hpa

Learning:

Autoscaling adjusts workload capacity automatically.

---

## Concepts Used

| Concept | Purpose | Day Learned |
|---------|---------|-------------|
| Namespace | Isolation | Day 52 |
| Deployment | Stateless apps | Day 52 |
| Service | Networking | Day 53 |
| ConfigMap | Configuration | Day 54 |
| Secret | Credentials | Day 54 |
| PVC | Storage | Day 55 |
| StatefulSet | Database | Day 56 |
| Resources | Stability | Day 57 |
| Probes | Health | Day 57 |
| HPA | Scaling | Day 58 |
| Helm | Packaging | Day 59 |

---

## Challenges Faced

Main difficulties:

Metrics server configuration
Service networking issues
PVC binding delays
Probe timing adjustments

Biggest learning:

Debugging Kubernetes teaches more than deploying.

---

## Production Improvements (What I would add)

If deploying in production:

Ingress controller
TLS certificates
External database backups
Monitoring (Prometheus)
Logging (Loki/ELK)
GitOps deployment
Pod disruption budgets

Learning:

Production Kubernetes requires observability and resilience planning.

---

## Key Learnings

This project reinforced:

Kubernetes is not about containers.

It is about:

Reliability  
Desired state  
Self healing  
Scalability  
Automation  

Most important realization:

Kubernetes is a reconciliation system constantly correcting drift.

---

## Learning Outcome

This capstone demonstrated how multiple Kubernetes components work together to run a real application. I now better understand how Kubernetes handles deployment, storage, networking, health checks, and scaling in a production-like environment.
