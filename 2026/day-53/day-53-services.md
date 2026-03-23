# Day 53 – Kubernetes Services

## Why Kubernetes Services are needed

Pods in Kubernetes are ephemeral and their IP addresses change whenever they restart. Also, a Deployment runs multiple Pods, so directly connecting to Pod IPs is not practical.

Kubernetes Services solve this by providing:

- Stable IP address
- Stable DNS name
- Load balancing across pods
- Service discovery

Architecture:

Client → Service → Pods

Service acts as a stable entry point while Pods can change behind it.

---

## Deployment Used

File: app-deployment.yaml
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web-app
  labels:
    app: web-app
spec:
  replicas: 3
  selector:
    matchLabels:
      app: web-app
  template:
    metadata:
      labels:
        app: web-app
    spec:
      containers:
      - name: nginx
        image: nginx:1.25
        ports:
        - containerPort: 80
```

Command:

`kubectl apply -f app-deployment.yaml`

Verification:

`kubectl get pods -o wide`

Observation:

Each pod has different IP but same label.

---

## ClusterIP Service

ClusterIP is default service type.

Used for:

Internal communication between services.

File: clusterip-service.yaml
```yaml
apiVersion: v1
kind: Service
metadata:
  name: web-app-clusterip
spec:
  type: ClusterIP
  selector:
    app: web-app
  ports:
  - port: 80
    targetPort: 80
```

Command:

`kubectl apply -f clusterip-service.yaml`

Verification:
`kubectl get services`

Testing inside cluster:

`kubectl run test-client --image=busybox --rm -it --restart=Never -- sh`

wget -qO- http://web-app-clusterip

Result:

Nginx welcome page received.

Learning:

Service distributed traffic across pods.

---

## Kubernetes DNS

Every service gets DNS:

service.namespace.svc.cluster.local

Example:

web-app-clusterip.default.svc.cluster.local

Test:

nslookup web-app-clusterip

Observation:

DNS resolved to ClusterIP.

Learning:

Kubernetes uses CoreDNS for service discovery.

---

## NodePort Service

NodePort exposes service externally via node port.

Use case:

Development and testing.

File: nodeport-service.yaml
```yaml
apiVersion: v1
kind: Service
metadata:
  name: web-app-nodeport
spec:
  type: NodePort
  selector:
    app: web-app
  ports:
  - port: 80
    targetPort: 80
    nodePort: 30080
```

Command:
```bash
kubectl apply -f nodeport-service.yaml
kubectl port-forward service/web-app-nodeport 30080:80
```

Verification:

kubectl get services

Access:

curl http://localhost:30080

Result:

Nginx welcome page visible.

Learning:

Traffic flow:

Client → NodePort → Service → Pod

---

## LoadBalancer Service

Used in cloud environments.

File: loadbalancer-service.yaml
```yaml
apiVersion: v1
kind: Service
metadata:
  name: web-app-loadbalancer
spec:
  type: LoadBalancer
  selector:
    app: web-app
  ports:
  - port: 80
    targetPort: 80
```

Command:

`kubectl apply -f loadbalancer-service.yaml`

Verification:

`kubectl get services`

Observation:

web-app-loadbalancer   LoadBalancer   10.96.246.218   <pending>     80:31325/TCP   13s

Reason:

Local cluster has no cloud provider.

Learning:

LoadBalancer works only in cloud environments.

---

## Service Types Comparison

| Service | Access | Use Case |
|---------|--------|----------|
| ClusterIP | Internal | Service communication |
| NodePort | External via node | Testing |
| LoadBalancer | External cloud access | Production |

Important concept:

LoadBalancer includes:

ClusterIP + NodePort

Verify:

`kubectl describe service web-app-loadbalancer`

---

## Endpoints

Endpoints show which pods receive traffic.

Command:

kubectl get endpoints web-app-clusterip

Result:
```
Warning: v1 Endpoints is deprecated in v1.33+; use discovery.k8s.io/v1 EndpointSlice
NAME                ENDPOINTS                                      AGE
web-app-clusterip   10.244.1.14:80,10.244.2.14:80,10.244.2.15:80   6m33s
```

Shows pod IP addresses.

Learning:

Service routes traffic to these endpoints.

---

## Important Commands Practiced

kubectl get services

kubectl get endpoints

kubectl describe service web-app-nodeport

kubectl get pods -o wide

kubectl get services -o wide

kubectl run test-client

---

## Key Learnings

Today I learned:

- Services provide stable networking
- ClusterIP used for internal traffic
- NodePort used for testing external access
- LoadBalancer used in production cloud
- DNS enables service discovery
- Endpoints map service to pods

Important learning:

Pods should never be accessed directly. Always use Services.

---

## Cleanup

kubectl delete -f app-deployment.yaml

kubectl delete -f clusterip-service.yaml

kubectl delete -f nodeport-service.yaml

kubectl delete -f loadbalancer-service.yaml

Verification:

kubectl get services


Result:

Only default kubernetes service remains.

---

## Learning Outcome

Today I learned how Kubernetes Services provide networking and load balancing. I understood how ClusterIP, NodePort, and LoadBalancer services expose applications differently. I also learned how DNS and endpoints help services communicate with pods.

