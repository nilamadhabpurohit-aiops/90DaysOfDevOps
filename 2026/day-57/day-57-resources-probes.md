# Day 57 – Kubernetes Resource Requests, Limits and Probes

## Why resource management is important

Kubernetes needs to know how much CPU and memory a Pod requires so it can schedule workloads efficiently and prevent resource starvation.

Two important concepts:

Requests → Minimum guaranteed resources  
Limits → Maximum allowed resources  

Requests are used by the scheduler.
Limits are enforced by kubelet.

---

## Resource Requests and Limits

resource-pod.yaml
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: resource-pod
spec:
  containers:
  - name: nginx
    image: nginx
    resources:
      requests:
        cpu: "100m"
        memory: "128Mi"
      limits:
        cpu: "250m"
        memory: "256Mi"
```

Apply:
`kubectl apply -f resource-pod.yaml`

**Verification:**
`kubectl describe pod resource-pod`

**Observation:**

Requests:
    CPU: 100m
    Memory: 128Mi

Limits:
    CPU: 250m
    Memory: 256Mi

QoS Class:

Burstable

Reason:

Requests < Limits

QoS Classes:

Guaranteed → requests = limits  
Burstable → requests < limits  
BestEffort → no resources defined  

---

## OOMKilled demonstration

oom-pod.yaml
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: stress-pod
spec:
  containers:
  - name: stress
    image: polinux/stress
    resources:
      limits:
        memory: "100Mi"
    command: ["stress"]
    args: ["--vm","1","--vm-bytes","200M","--vm-hang","1"]
```

Apply:

`kubectl apply -f oom-pod.yaml`

Verification:

`kubectl describe pod stress-pod`

Observation:
```bash
NAME         READY   STATUS      RESTARTS       AGE
stress-pod   0/1     OOMKilled   6 (3h4m ago)   4h37m
```
Reason: `OOMKilled`

Exit Code: `137`

Learning:

- CPU exceeding → throttled  
- Memory exceeding → container killed

Important concept:

Exit Code 137 = OOMKilled

---

## Pending Pod demonstration

pending-pod.yaml

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: big-request
spec:
  containers:
  - name: nginx
    image: nginx
    resources:
      requests:
        cpu: "100"
        memory: "128Gi"
```

Apply:

`kubectl apply -f pending-pod.yaml`

Verification:

`kubectl get pods`

Result:

```bash
NAME          READY   STATUS             RESTARTS        AGE
big-request   0/1     Pending            0               8s
```

STATUS → Pending

Check:

`kubectl describe pod big-request`

Observation:

Scheduler event:

- Insufficient CPU
- Insufficient memory

Learning:

- Pod remains Pending if cluster lacks resources.

---

## Liveness Probe

liveness-pod.yaml
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: liveness-pod
spec:
  containers:
  - name: busybox
    image: busybox
    command:
      - sh
      - -c
      - |
        touch /tmp/healthy
        sleep 30
        rm -f /tmp/healthy
        sleep 600
    livenessProbe:
      exec:
        command:
          - cat
          - /tmp/healthy
      initialDelaySeconds: 5
      periodSeconds: 5
      failureThreshold: 3
```
Apply:

`kubectl apply -f liveness-pod.yaml`

Watch:

`kubectl get pod liveness-pod -w`

Observation:

- Container restarted after probe failures.

Learning:

- Liveness probe restarts unhealthy containers.

---

## Readiness Probe

readiness-pod.yaml
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: readiness-pod
spec:
  containers:
  - name: nginx
    image: nginx
    readinessProbe:
      httpGet:
        path: /
        port: 80
      initialDelaySeconds: 5
      periodSeconds: 10
```

Apply:

`kubectl apply -f readiness-pod.yaml`

Expose:

`kubectl expose pod readiness-pod --port=80 --name=readiness-svc`

Verification:

`kubectl get endpoints readiness-svc`

Break readiness:

`kubectl exec readiness-pod -- rm /usr/share/nginx/html/index.html`

Observation:

- Pod READY → 0/1
- Endpoints empty.
- Container not restarted.

Learning:

- Readiness failure removes traffic but does not restart container.

---

## Startup Probe

startup-pod.yaml
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: startup-pod
spec:
  containers:
  - name: busybox
    image: busybox
    command:
    - sh
    - -c
    - "sleep 20; touch /tmp/started; sleep 600"
    startupProbe:
      exec:
        command:
        - cat
        - /tmp/started
      periodSeconds: 5
      failureThreshold: 12
    livenessProbe:
      exec:
        command:
        - cat
        - /tmp/started
      periodSeconds: 5
```
Apply:

`kubectl apply -f startup-pod.yaml`

Learning:

- Startup probe prevents premature liveness failures.
- If failureThreshold was 2:
- Container would restart before startup completes.

---

## Liveness vs Readiness vs Startup

| Probe | Purpose | Action |
|-------|---------|--------|
| Liveness | Detect stuck container | Restart |
| Readiness | Detect availability | Remove traffic |
| Startup | Allow slow startup | Delay checks |

---

## Key Learnings

Today I learned:

- Requests define scheduling requirements
- Limits define maximum usage
- CPU is throttled when exceeded
- Memory exceeding causes OOMKilled
- Liveness probe restarts containers
- Readiness probe controls traffic
- Startup probe handles slow applications

Important production learning:

Always configure probes for reliability.

---

## Important Commands Practiced

kubectl describe pod
kubectl get pods
kubectl get events
kubectl get endpoints
kubectl expose pod
kubectl exec
kubectl logs

---

## Learning Outcome

Today I learned how Kubernetes manages resource allocation and container health using requests, limits and probes. I observed OOMKilled behavior, scheduling failures, and self-healing mechanisms using liveness and readiness probes.

