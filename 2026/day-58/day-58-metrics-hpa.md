# Day 58 – Kubernetes Metrics Server and Horizontal Pod Autoscaler (HPA)

## Why Metrics Server is required

Kubernetes by default does not track real-time CPU and memory usage of Pods. The Metrics Server collects resource metrics from kubelets and exposes them via the Kubernetes Metrics API.

This data is required for:

- Horizontal Pod Autoscaler (HPA)
- kubectl top command
- Resource monitoring
- Capacity planning

Without Metrics Server:

kubectl top → fails  
HPA → shows <unknown>

---

## Metrics Server Installation

Verify:

kubectl get pods -n kube-system | grep metrics-server

If not present:

`kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml`

For local clusters (kind/minikube):

Add flag:

Edit With this command: `kubectl edit deployment metrics-server -n kube-system`

Find args section and change it to:
```yaml
containers:
- name: metrics-server
  args:
  - --cert-dir=/tmp
  - --secure-port=10250
  - --kubelet-preferred-address-types=InternalIP
  - --kubelet-insecure-tls
```
Important:
Add this line:
`--kubelet-insecure-tls`

Verification:

kubectl top nodes
kubectl top pods -A

Observation:

- CPU and memory usage visible.

Learning:

- Metrics Server collects runtime resource usage.

---

## kubectl top exploration

Commands:

kubectl top nodes

kubectl top pods -A

kubectl top pods -A --sort-by=cpu

Observation:

Shows:

Real usage  
Not requests  
Not limits  

Difference:

Requests → scheduling value  
Limits → maximum allowed  
Usage → real consumption  

Learning:

kubectl top shows live consumption.

---

## Deployment for HPA testing

php-apache.yaml

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: php-apache
spec:
  replicas: 1
  selector:
    matchLabels:
      app: php-apache
  template:
    metadata:
      labels:
        app: php-apache
    spec:
      containers:
      - name: php-apache
        image: registry.k8s.io/hpa-example
        ports:
        - containerPort: 80
        resources:
          requests:
            cpu: 200m
```


Apply:

`kubectl apply -f php-apache.yaml`

Expose:

`kubectl expose deployment php-apache --port=80`

Learning:

- HPA requires CPU requests.

Without requests:

- TARGETS → unknown

---

## Horizontal Pod Autoscaler (Imperative)

Command:

```bash
kubectl autoscale deployment php-apache \
--cpu-percent=50 \
--min=1 \
--max=10
```

Verify:

`kubectl get hpa`

`kubectl describe hpa php-apache`

Observation:

- TARGETS example: 60% / 50%

- Meaning:
Current CPU usage = 60%
Target CPU usage = 50%

Learning:

- Scaling happens when usage exceeds target.

---

## HPA Scaling Formula

Kubernetes calculates replicas using:

desiredReplicas =
ceil(currentReplicas × (currentUsage / targetUsage))

Example:

Current replicas = 1  
CPU usage = 80%  
Target = 50%

Calculation:

1 × (80/50) = 1.6 → 2 replicas

Learning:

Autoscaling is math driven.

---

## Load generation

Command:
```bash 
kubectl run load-generator \
--image=busybox:1.36 \
--restart=Never \
-- /bin/sh -c \
"while true; do wget -q -O- http://php-apache; done"
```
Watch scaling:

`kubectl get hpa php-apache --watch`

Observation:

CPU increases  
Replicas increase  

Stop load:

`kubectl delete pod load-generator`

Observation:

Scale down happens slowly.

Reason:

Stabilization window prevents rapid scaling changes.

Learning:

Scale up fast.
Scale down slow.

---

## Declarative HPA

hpa.yaml
```yaml
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: php-apache
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: php-apache
  minReplicas: 1
  maxReplicas: 10
  metrics:
  - type: Resource
    resource:
      name: cpu
      target:
        type: Utilization
        averageUtilization: 50
  behavior:
    scaleUp:
      stabilizationWindowSeconds: 0
    scaleDown:
      stabilizationWindowSeconds: 300
```
Apply:

`kubectl apply -f hpa.yaml`

Verify:

`kubectl describe hpa php-apache`

Learning:

behavior controls scaling speed.

---

## autoscaling/v1 vs autoscaling/v2

| Feature | v1 | v2 |
|---------|----|----|
| CPU metrics | Yes | Yes |
| Memory metrics | No | Yes |
| Custom metrics | No | Yes |
| Scaling behavior | No | Yes |

Learning:

Use v2 for production.

---

## Key Learnings

Today I learned:

- Metrics Server provides runtime usage data
- HPA depends on resource requests
- Autoscaling decisions are mathematical
- Load testing demonstrates scaling behavior
- Scale up is aggressive
- Scale down is conservative
- autoscaling/v2 provides advanced control

Important production learning:

Incorrect resource requests cause bad autoscaling.

---

## Important Commands Practiced

kubectl top nodes

kubectl top pods

kubectl get hpa

kubectl describe hpa

kubectl autoscale deployment

kubectl delete hpa

kubectl get deployment

kubectl get pods

---

## Learning Outcome

Today I learned how Kubernetes automatically scales workloads using the Horizontal Pod Autoscaler based on real resource usage. I observed how Metrics Server enables autoscaling decisions and how Kubernetes balances performance and stability through controlled scaling behavior.

#90DaysOfDevOps  
#Kubernetes  
#DevOps  
#TrainWithShubham