# Day 54 – Kubernetes ConfigMaps and Secrets

## What are ConfigMaps?

ConfigMaps are used to store non-sensitive configuration data in key-value format. They allow applications to read configuration without rebuilding container images.

Use cases:

- Environment variables
- Application configs
- Feature flags
- Application ports
- Logging configs

Key benefit:

Configuration can change without rebuilding Docker images.

---

## What are Secrets?

Secrets are used to store sensitive information such as:

- Database passwords
- API keys
- Tokens
- Certificates

Secrets store values in base64 encoded format and can be mounted securely inside pods.

Important:

Base64 is encoding, not encryption.

---

## ConfigMap created from literals

Command used:
```bash
kubectl create configmap app-config \
--from-literal=APP_ENV=production \
--from-literal=APP_DEBUG=false \
--from-literal=APP_PORT=8080
```

Verification:

`kubectl describe configmap app-config`

`kubectl get configmap app-config -o yaml`

Result:

APP_ENV=production  
APP_DEBUG=false  
APP_PORT=8080  

Learning:

ConfigMap stores values as plain text.

---

## ConfigMap created from file

Created nginx config file:
```bash
vim default.conf

server {
    listen 80;
    location /health {
        return 200 "healthy";
    }
}
```
Command:
```bash
kubectl create configmap nginx-config \
--from-file=default.conf=default.conf
```
Verification:

`kubectl get configmap nginx-config -o yaml`

Result:

```bash 
kubectl get configmap nginx-config -o yaml
apiVersion: v1
data:
  default.conf: |
    server {
        listen 80;
        location /health {
            return 200 "healthy";
        }
    }
kind: ConfigMap
metadata:
  creationTimestamp: "2026-03-23T16:43:14Z"
  name: nginx-config
  namespace: default
  resourceVersion: "335293"
  uid: 27ea7667-8886-48eb-9668-6bf2617e2389
```


File contents visible in ConfigMap.

Learning:

File name becomes key name.

---

## Using ConfigMap as environment variables

busybox-config-pod.yaml
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: busybox-config
spec:
  containers:
  - name: busybox
    image: busybox
    command: ["sh","-c","env && sleep 3600"]
    envFrom:
    - configMapRef:
        name: app-config
```

Command:

`kubectl apply -f busybox-config-pod.yaml`

Verification:

`kubectl logs busybox-config`

Result:

Environment variables printed.

Learning:

envFrom loads all configmap keys.

---

## Using ConfigMap as Volume

nginx-config-pod.yaml
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx-config-pod
spec:
  containers:
  - name: nginx
    image: nginx
    volumeMounts:
    - name: nginx-config-volume
      mountPath: /etc/nginx/conf.d
  volumes:
  - name: nginx-config-volume
    configMap:
      name: nginx-config
```

Verification:
```bash 
$ kubectl exec nginx-config-pod -- curl localhost/health
 % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
10healthy0     7  100     7    0     0  10920      0 --:--:-- --:--:-- --:--:--  7000
```

Result:

healthy

Learning:

ConfigMap mounted as config file.

---

## Secret creation

Command:
```bash
kubectl create secret generic db-credentials \
--from-literal=DB_USER=admin \
--from-literal=DB_PASSWORD=s3cureP@ssw0rd
```
Verification:

`kubectl get secret db-credentials -o yaml`

Observation:

Values are base64 encoded.

Example:

data:
  DB_PASSWORD: czNjdXJlUEBzc3cwcmQ=
  DB_USER: YWRtaW4=

Decode:

`echo 'czNjdXJlUEBzc3cwcmQ=' | base64 --decode`

Result:
s3cureP@ssw0rd

Learning:

Secrets are encoded not encrypted.

---

## Using Secret in Pod

secret-pod.yaml
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: secret-pod
spec:
  containers:
  - name: busybox
    image: busybox
    command: ["sh","-c","sleep 3600"]
    env:
    - name: DB_USER
      valueFrom:
        secretKeyRef:
          name: db-credentials
          key: DB_USER
    volumeMounts:
    - name: secret-volume
      mountPath: /etc/db-credentials
      readOnly: true
  volumes:
  - name: secret-volume
    secret:
      secretName: db-credentials
```

Verification:

`kubectl exec secret-pod -- ls /etc/db-credentials`

`kubectl exec secret-pod -- cat /etc/db-credentials/DB_PASSWORD`

Result:

Plain text password visible.

Learning:

Mounted secret values are decoded automatically.

---

## Environment variables vs Volume mounts

| Method | Use case |
|--------|----------|
| Environment Variables | Simple config |
| Volume Mount | Full config files |

**Important difference:**

- Environment variables: Loaded at pod startup.
- Volume mount: Updates automatically.

---

## ConfigMap update propagation

Create config:

```bash
kubectl create configmap live-config \
--from-literal=message=hello
```
Update:

```bash
kubectl patch configmap live-config \
--type merge \
-p '{"data":{"message":"world"}}'
```

Observation:

- Mounted volume updated automatically.
- Environment variables did not update.

Learning:

- Volume updates propagate automatically.
- Env vars require restart.

---

## Key Learnings

Today I learned:

- ConfigMaps store non sensitive config
- Secrets store sensitive data
- Base64 is encoding not encryption
- ConfigMaps can be injected as env or volume
- Secrets automatically decoded when mounted
- ConfigMap volume updates automatically
- Environment variables require restart

Important production learning:

Never hardcode secrets in images.

Always use Secrets.

---

## Commands Practiced

kubectl create configmap
kubectl get configmap
kubectl create secret
kubectl get secret
kubectl describe configmap
kubectl patch configmap
kubectl exec
kubectl logs

---

## Learning Outcome

Today I learned how Kubernetes separates configuration from container images using ConfigMaps and Secrets. I practiced injecting configuration as environment variables and volumes. I also learned how Kubernetes manages sensitive data securely.
