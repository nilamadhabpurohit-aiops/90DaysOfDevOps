# Day 35 – Multi-Stage Builds & Docker Hub

## Task 1: Single-Stage Go App (Large Image) 
Single-stage Dockerfile.single

```bash
FROM golang:1.22-alpine
WORKDIR /app
COPY . .
RUN go mod init hello
RUN go build -o hello app.go
CMD ["./hello"]
```
Build & Size:

```bash
docker build -f Dockerfile.single -t go-single . 
docker images go-single  # ~350MB
```
Problem: Full Go compiler + tools copied to final image.


## Task 2: Multi-Stage Build (Tiny Image)

Results:
```bash
docker build -f Dockerfile.multi -t go-multi .
docker images go-multi  # ~6MB!
```
Why Smaller?
- Builder stage discarded (compiler/tools = 300MB+)
- Only binary (11MB) + alpine base (5MB)
- No dev dependencies in final image

## Task 3: Docker Hub Push ✅
```bash
# Login
docker login

# Tag properly
docker tag go-multi nilamadhab1996/day35-multistage:latest
docker tag go-multi nilamadhab1996/day35-multistage:v1.0

# Push
docker push nilamadhab1996/day35-multistage:latest
docker push nilamadhab1996/day35-multistage:v1.0
```
Verify:
```bash
docker rmi go-multi
docker pull nilamadhab1996/day35-multistage:latest  # Works!
```

## Task 4: Repository Management ✅
Docker Hub Repo Settings:

```
Description: "Day 35/90DaysOfDevOps: Multi-stage Go app (6MB vs 350MB)"
Tags: latest, v1.0
Layers: alpine:3.19 + hello binary
```
Tag Testing:

```bash
docker pull nilamadhab1996/day35-multistage:latest  # v1.0
docker pull nilamadhab1996/day35-multistage:v1.0    # Same
```

## Task 5: Image Best Practices
Optimized `Dockerfile.best`

```bash
FROM golang:1.22-alpine AS builder
WORKDIR /app
# Combine RUNs = fewer layers
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-s -w" -o hello app.go

FROM alpine:3.19
RUN addgroup -g 1001 appgroup && adduser -D -G appgroup -u 1001 appuser
WORKDIR /app
COPY --from=builder /app/hello .
# Smaller binary (-ldflags="-s -w")
RUN chown appuser:appgroup hello
USER appuser
EXPOSE 8080
HEALTHCHECK CMD wget --no-verbose --tries=1 --spider http://localhost:8080 || exit 1
CMD ["./hello"]
```



### **Key Learnings**

| Practice         | Why                 | Impact            |
| ---------------- | ------------------- | ----------------- |
| Multi-stage      | Discard build tools | 58x smaller       |
| Alpine base      | Minimal OS          | -300MB            |
| Non-root user    | Security            | Prevents priv esc |
| Combine RUNs     | Fewer layers        | Faster pulls      |
| Specific tags    | Reproducibility     | No surprises      |
| -ldflags="-s -w" | Strip debug         | -1MB binary       |