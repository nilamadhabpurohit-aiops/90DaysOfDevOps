# Day 56 – Kubernetes StatefulSets

## What are StatefulSets?

StatefulSets are Kubernetes workload resources used for managing stateful applications such as databases, Kafka, Zookeeper, and distributed systems that require stable identity and persistent storage.

Unlike Deployments, StatefulSets provide:

- Stable pod names
- Ordered deployment and scaling
- Stable network identity
- Persistent storage per pod

StatefulSets are mainly used when applications require identity and storage consistency.

---

## Deployment vs StatefulSet

| Feature | Deployment | StatefulSet |
|---------|------------|-------------|
| Pod names | Random | Stable (web-0, web-1) |
| Pod identity | No identity | Stable identity |
| Storage | Shared PVC | Per pod PVC |
| Scaling | Parallel | Ordered |
| Use case | Stateless apps | Databases |

---

## Why random pod names are a problem

Deployment example:

web-app-68f7c9d9f4-abc12  
web-app-68f7c9d9f4-xzy89  

If a pod is deleted:
- New pod gets a different name.

Problem for databases:

- Cluster nodes expect fixed names
- Replication configs depend on hostnames
- Leader election may break

StatefulSets solve this with stable identity.

---

## Headless Service

StatefulSets require a headless service.

headless-service.yaml
```yaml
apiVersion: v1
kind: Service
metadata:
  name: web
spec:
  clusterIP: None
  selector:
    app: web
  ports:
  - port: 80
```

Apply:
`kubectl apply -f headless-service.yaml`

Verify:
`kubectl get svc`

Result:
CLUSTER-IP → None

Learning:
- Headless service provides DNS for each pod.

---

## StatefulSet Manifest

statefulset.yaml
```yaml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: web
spec:
  serviceName: web
  replicas: 3
  selector:
    matchLabels:
      app: web
  template:
    metadata:
      labels:
        app: web
    spec:
      containers:
      - name: nginx
        image: nginx
        ports:
        - containerPort: 80
        volumeMounts:
        - name: web-data
          mountPath: /usr/share/nginx/html
  volumeClaimTemplates:
  - metadata:
      name: web-data
    spec:
      accessModes:
      - ReadWriteOnce
      resources:
        requests:
          storage: 100Mi
```

Apply:
`kubectl apply -f statefulset.yaml`

Verify:

`kubectl get pods -l app=web`

Result:
```bash
NAME    READY   STATUS    RESTARTS   AGE
web-0   1/1     Running   0          43s
web-1   1/1     Running   0          33s
web-2   1/1     Running   0          23s
```
Learning:

- Pods created sequentially.

---

## StatefulSet PVCs

Command:

`kubectl get pvc`

Result example:

```bash
NAME             STATUS    VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   VOLUMEATTRIBUTESCLASS   AGE
dynamic-pvc      Pending                                                                        standard       <unset>                 17h
web-data-web-0   Bound     pvc-c19896ee-b07d-4a51-87b0-09dfd61ba0ec   100Mi      RWO            standard       <unset>                 72s
web-data-web-1   Bound     pvc-0fbe83f2-2f81-4f16-a26a-05501f980a21   100Mi      RWO            standard       <unset>                 62s
web-data-web-2   Bound     pvc-b26c2a81-9f5f-4743-bef9-b68c5a51982f   100Mi      RWO            standard       <unset>                 52s
```

Learning:

Each pod gets its own PVC.

PVC naming:

<volume-template>-<pod-name>

---

## Stable Network Identity

Pod DNS format:

web-0.web.default.svc.cluster.local

Test:

kubectl run test --image=busybox -it --rm -- sh

Inside pod:

nslookup web-0.web.default.svc.cluster.local

Verification:

kubectl get pods -o wide

Learning:

DNS resolves to pod IP.

---

## Persistent Storage Verification

Write data: `kubectl exec web-0 -- sh -c "echo 'Data from web-0' > /usr/share/nginx/html/index.html"`

Verify: `kubectl exec web-0 -- cat /usr/share/nginx/html/index.html`

Delete pod: `kubectl delete pod web-0`

Wait recreation: `kubectl get pods`

Verify again: `kubectl exec web-0 -- cat /usr/share/nginx/html/index.html`

Result:

Data still present.

Learning:

StatefulSet reconnects same PVC.

---

## Ordered Scaling

Scale up:

`kubectl scale statefulset web --replicas=5`

Observe:

web-3 created  
web-4 created  

Scale down:

`kubectl scale statefulset web --replicas=3`

Observe:

web-4 deleted  
web-3 deleted  

Learning:

Pods terminate in reverse order.

---

## PVC behavior after scaling down

Command:

`kubectl get pvc`

Observation:

PVCs still exist.
```bash 
NAME             STATUS    VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   VOLUMEATTRIBUTESCLASS   AGE
dynamic-pvc      Pending                                                                        standard       <unset>                 17h
web-data-web-0   Bound     pvc-c19896ee-b07d-4a51-87b0-09dfd61ba0ec   100Mi      RWO            standard       <unset>                 9m39s
web-data-web-1   Bound     pvc-0fbe83f2-2f81-4f16-a26a-05501f980a21   100Mi      RWO            standard       <unset>                 9m29s
web-data-web-2   Bound     pvc-b26c2a81-9f5f-4743-bef9-b68c5a51982f   100Mi      RWO            standard       <unset>                 9m19s
web-data-web-3   Bound     pvc-17fad603-79cf-49eb-b449-16b2f4cbfa12   100Mi      RWO            standard       <unset>                 2m33s
web-data-web-4   Bound     pvc-fb5e2a49-ae72-4bd0-8c6a-eda4c4150bd8   100Mi      RWO            standard       <unset>                 2m23s
```

Reason:

Kubernetes preserves storage for safety.

Learning:

Scaling down does not delete PVCs.

---

## Cleanup behavior

Delete StatefulSet: `kubectl delete statefulset web`

Check PVC: `kubectl get pvc`

Result:

PVCs still exist.

Reason:

StatefulSet does not delete PVC automatically.

Delete PVC manually:
```bash
kubectl delete pvc web-data-web-0
kubectl delete pvc web-data-web-1
kubectl delete pvc web-data-web-2
```
Learning:
- Manual cleanup required.

---

## Key Learnings

Today I learned:

- StatefulSets manage stateful applications
- Pods have stable identity
- Headless services provide DNS
- Each pod gets its own PVC
- Storage survives pod deletion
- Scaling happens in order
- PVCs are preserved on scale down

Important production learning:

Use StatefulSets for:

Databases  
Kafka  
Redis clusters  
Zookeeper  
Elasticsearch  

---

## Important Commands Practiced

kubectl get sts
kubectl get pos
kubectl get pvc
kubectl scale statefulset
kubectl delete statefulset
kubectl exec
kubectl describe statefulset

---

## Learning Outcome

Today I learned how Kubernetes manages stateful workloads using StatefulSets. I practiced stable pod identity, persistent storage, and ordered scaling behavior. I now understand why databases require StatefulSets instead of Deployments.
