# Day 52 – Kubernetes Namespaces and Deployments

## What are Namespaces?

Namespaces are logical partitions inside a Kubernetes cluster used to organize and isolate resources. They help separate environments like development, staging, and production inside the same cluster.

Why namespaces are useful:

- Environment separation (dev, staging, prod)
- Resource organization
- Access control (RBAC)
- Resource quotas
- Multi-team usage

Default namespaces in Kubernetes:

- default → user workloads
- kube-system → Kubernetes components
- kube-public → public resources
- kube-node-lease → node heartbeat tracking

Command used:

kubectl get namespaces

---

## Namespaces Created

Created namespaces:

kubectl create namespace dev

kubectl create namespace staging

Namespace manifest:
```yml
apiVersion: v1
kind: Namespace
metadata:
  name: production
```
kubectl apply -f namespace.yaml

Verification:

`kubectl get namespaces`

---

## Running Pods in Namespaces

Commands:
```bash
kubectl run nginx-dev --image=nginx -n dev

kubectl run nginx-staging --image=nginx -n staging
```
Verify:

`kubectl get pods -A`

Observation:

`kubectl get pods` ->  only shows default namespace.

`kubectl get pods -A` ->  shows all namespaces.

---

## Deployment Manifest

File: nginx-deployment.yaml
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  namespace: dev
  labels:
    app: nginx
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.24
        ports:
        - containerPort: 80
```

---

## Deployment Section Explanation

`apiVersion: apps/v1` -> Used for Deployments and ReplicaSets.

`kind: Deployment` -> Defines the resource type.

`metadata` -> Defines name, namespace and labels.

`replicas` -> Defines how many pods should run.

`selector` -> Connects deployment to pods.

`template` -> Pod blueprint used by Deployment.

`containers` -> Defines container configuration.

---

## Deployment Verification

Commands used:
```bash
kubectl apply -f nginx-deployment.yaml

kubectl get deployments -n dev

kubectl get pods -n dev
```
Example output:
```bash
$ kubectl get deployments -n dev
NAME               READY   UP-TO-DATE   AVAILABLE   AGE
nginx-deployment   0/3     3            0           7s

$ kubectl get pods -n dev
NAME                                READY   STATUS              RESTARTS   AGE
nginx-deployment-5d9c84579f-j5s77   0/1     ContainerCreating   0          17s
nginx-deployment-5d9c84579f-lsnrb   0/1     ContainerCreating   0          17s
nginx-deployment-5d9c84579f-nsvg6   0/1     ContainerCreating   0          17s
nginx-dev                           1/1     Running             0          74s
```

Meaning:

READY → running pods  
UP-TO-DATE → updated pods  
AVAILABLE → healthy pods

---

## Self Healing Behavior

Command:

`kubectl delete pod nginx-deployment-5d9c84579f-lsnrb -n dev`

Result:

- Deployment automatically created a new pod.

Observation:

- New pod name was different.

Learning:

- Deployment ensures desired state always maintained.

Difference:

**Standalone Pod:**
Deleted permanently.

**Deployment Pod:**
Recreated automatically.

---

## Scaling Deployment

Imperative scaling:

`kubectl scale deployment nginx-deployment --replicas=5 -n dev`

`kubectl get pods -n dev`

Scaled down:

`kubectl scale deployment nginx-deployment --replicas=2 -n dev`

Observation:

- Extra pods terminated automatically.
- Declarative scaling:
- Change replicas in YAML:
```
replicas: 4
kubectl apply -f nginx-deployment.yaml
```

---

## Rolling Update

Updated image:

`kubectl set image deployment/nginx-deployment nginx=nginx:1.25 -n dev`

Verification:

`kubectl rollout status deployment/nginx-deployment -n dev`

Observation:

- Pods updated one by one.
- Zero downtime achieved.

Check history:

`kubectl rollout history deployment/nginx-deployment -n dev`

Rollback:

`kubectl rollout undo deployment/nginx-deployment -n dev`

Verification:

`kubectl describe deployment nginx-deployment -n dev | grep Image`

Result:

Image reverted to nginx:1.24

---

## How Rolling Update Works

Steps:

1 New pod created  
2 Health check passes  
3 Old pod terminated  
4 Repeat process  

Ensures:

Zero downtime deployment.

---

## Cleanup

Commands:

kubectl delete deployment nginx-deployment -n dev

kubectl delete pod nginx-dev -n dev

kubectl delete pod nginx-staging -n staging

kubectl delete namespace dev staging production

Verification:

kubectl get namespaces

kubectl get pods -A

Result:

All resources removed.

---

## Key Learnings

Today I learned:

- Namespaces organize Kubernetes resources
- Deployments manage Pods automatically
- Pods are recreated automatically
- Scaling changes replica count
- Rolling updates provide zero downtime
- Rollbacks restore previous versions

Important learning:

Pods should not be used directly in production.

Deployments should always be used.

---

## Commands Practiced
```bash
kubectl get namespaces

kubectl get pods -A

kubectl get deployments

kubectl scale deployment

kubectl rollout status

kubectl rollout history

kubectl rollout undo

kubectl delete namespace
```
---

## Learning Outcome

Today I learned how Kubernetes manages applications using Deployments instead of standalone Pods. I also learned how namespaces help isolate environments. I practiced scaling applications and performing rolling updates with zero downtime.
