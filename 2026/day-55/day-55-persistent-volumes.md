# Day 55 – Kubernetes Persistent Volumes (PV) and Persistent Volume Claims (PVC)

## Why containers need persistent storage

Containers are ephemeral by design. When a Pod is deleted or recreated, all data inside the container filesystem is lost. This creates a problem for applications like databases, logging systems, and stateful services that require data persistence.

Kubernetes solves this problem using:

Persistent Volumes (PV)
Persistent Volume Claims (PVC)

These provide storage that exists independently of Pods.

---

## Demonstrating Ephemeral Storage Problem

Pod using emptyDir:

emptydir-pod.yaml
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: emptydir-pod
spec:
  containers:
  - name: busybox
    image: busybox
    command: ["sh","-c","date >> /data/message.txt && sleep 3600"]
    volumeMounts:
    - name: temp-storage
      mountPath: /data
  volumes:
  - name: temp-storage
    emptyDir: {}
```

Apply:

`kubectl apply -f emptydir-pod.yaml`

Verify:

`kubectl exec emptydir-pod -- cat /data/message.txt`

Delete:

`kubectl delete pod emptydir-pod`

Recreate:

`kubectl apply -f emptydir-pod.yaml`

Check again:

`kubectl exec emptydir-pod -- cat /data/message.txt`

Observation:

Timestamp changed.

Learning:

emptyDir storage is temporary and deleted with Pod.

---

## Persistent Volume (Static Provisioning)

pv.yaml
```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: manual-pv
spec:
  capacity:
    storage: 1Gi
  accessModes:
  - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  hostPath:
    path: /tmp/k8s-pv-data
```

Apply:

`kubectl apply -f pv.yaml`

Verify:

`kubectl get pv`

Result:
- STATUS → Available

Learning:
- PV created but not yet claimed.

---

## Persistent Volume Claim

pvc.yaml
```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: manual-pvc
spec:
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
      storage: 500Mi
```

Apply:

`kubectl apply -f pvc.yaml`

Verify:

`kubectl get pvc`

`kubectl get pv`

Observation:

PVC → Bound

PV → Bound

Learning:

Kubernetes matched PV and PVC.

---

## Using PVC in Pod

pv-pod.yaml
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: pv-pod
spec:
  containers:
  - name: busybox
    image: busybox
    command: ["sh","-c","date >> /data/message.txt && sleep 3600"]
    volumeMounts:
    - name: pv-storage
      mountPath: /data
  volumes:
  - name: pv-storage
    persistentVolumeClaim:
      claimName: manual-pvc
```

Apply:

`kubectl apply -f pv-pod.yaml`

Write data:

`kubectl exec pv-pod -- cat /data/message.txt`

Delete pod:

`kubectl delete pod pv-pod`

Recreate:

`kubectl apply -f pv-pod.yaml`

Verify:

`kubectl exec pv-pod -- cat /data/message.txt`

Observation:

Old data still exists.

Learning:

PVC storage survives pod deletion.

---

## PV and PVC Relationship

Architecture:

Pod → PVC → PV → Storage

PVC acts as request.
PV acts as resource.

Analogy:

PVC = storage request  
PV = actual storage

---

## StorageClasses

Command:

kubectl get storageclass

kubectl describe storageclass

Observation:

Default storage class exists.

StorageClass defines:

Provisioner  
Reclaim policy  
Volume binding mode  

Learning:

StorageClass enables dynamic provisioning.

---

## Dynamic Provisioning

dynamic-pvc.yaml
```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: dynamic-pvc
spec:
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
  storageClassName: standard
```

Apply:

`kubectl apply -f dynamic-pvc.yaml`

Verify:

`kubectl get pv`

Observation:

New PV created automatically.

Learning:

PVC triggered PV creation.

---

## Static vs Dynamic Provisioning

| Type | How created |
|------|-------------|
| Static | Admin creates PV |
| Dynamic | StorageClass creates PV |

Static:

PV → PVC → Pod

Dynamic:

PVC → StorageClass → PV → Pod

---

## Access Modes

| Mode | Meaning |
|------|---------|
| ReadWriteOnce | Single node read/write |
| ReadOnlyMany | Multiple nodes read |
| ReadWriteMany | Multiple nodes read/write |

Most common:

ReadWriteOnce.

---

## Reclaim Policies

| Policy | Behavior |
|--------|----------|
| Retain | Keep data |
| Delete | Remove storage |
| Recycle | Deprecated |

- Manual PV: Retain policy.
- Dynamic PV: Delete policy.

---

## Cleanup Observations

Delete pods first:

`kubectl delete pod pv-pod`

Delete PVC:

`kubectl delete pvc manual-pvc`

Check PV:

`kubectl get pv`

Observation:

Manual PV → Released  
Dynamic PV → Deleted  

Reason:

Manual PV uses Retain.
Dynamic PV uses Delete.

---

## Key Learnings

Today I learned:

- Containers are ephemeral
- emptyDir loses data
- PV provides storage
- PVC requests storage
- Static provisioning requires manual PV
- Dynamic provisioning uses StorageClass
- PVC survives pod deletion
- Reclaim policies control storage lifecycle

Important production learning:

Stateful apps must use PVC.

---

## Important Commands Practiced

kubectl get pv
kubectl get pvc
kubectl describe pv
kubectl describe pvc
kubectl get storageclass
kubectl exec
kubectl delete pvc

---

## Learning Outcome

Today I learned how Kubernetes manages persistent storage using Persistent Volumes and Persistent Volume Claims. I demonstrated how container storage is temporary and how PV/PVC provides persistent storage. I also learned the difference between static and dynamic provisioning.
