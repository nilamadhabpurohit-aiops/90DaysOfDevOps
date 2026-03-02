# Day 34 – Docker Compose: Advanced Multi-Container Apps

## Task 1: Build App Stack 
- Stack Built: Python Flask + Postgres + Redis
- Access: http://localhost:5000 shows live DB/Redis status!

```
Web App (Flask) ←→ Postgres (appdb) ←→ Redis (visits counter)
     ↓                    ↓                    ↓
localhost:5000    postgres_data volume    redis:7-alpine
```

## Task 2: depends_on & Healthchecks
Smart Startup Order:

```yml
web:
  depends_on:
    db:
      condition: service_healthy  # Waits for pg_isready PASS
    redis:
      condition: service_started
DB Healthcheck:
```

```yml
healthcheck:
  test: ["CMD-SHELL", "pg_isready -U postgres -d appdb"]
  interval: 10s
  timeout: 5s
  retries: 5
  start_period: 30s
```
- Test Result: `docker compose down && docker compose up`
- Web waits ~40s until DB reports healthy 

## Task 3: Restart Policies
- Test Commands Run:

```bash
# Test 1: Normal restart
docker compose restart db

# Test 2: Kill container (restart: always)
docker kill <db-container-id>  # Comes back automatically!

# Test 3: Exit code failure (restart: on-failure)
docker compose up --build -d  # Simulate app crash
```
Restart Policy Guide:

| Policy         | Behavior                       | Use Case          | Example                   |
| -------------- | ------------------------------ | ----------------- | ------------------------- |
| always         | Restarts on any stop/kill      | Critical services | Database, monitoring      |
| on-failure     | Restarts only on non-zero exit | App services      | Web apps (healthy exit=0) |
| unless-stopped | Restarts unless docker stop    | Long-running jobs | Workers, queues           |
| no (default)   | Never restarts                 | One-off tasks     | Migrations                |



## Task 4: Custom Dockerfile 
Compose uses: `build: ./app` (local Dockerfile)
Workflow:
1. Edit app.py (add new route)
2. `docker compose up --build -d` One command rebuild!
3. Zero-downtime: Other services stay up

Pro Tip: `docker compose up --build --no-deps` web (rebuild only web)

## Task 5: Networks & Volumes
Explicit Network: `app-network` (isolated from other projects)
Persistent Volume: `postgres_data:` survives `docker compose down`

Labels Added:

```yml
labels:
  - "com.example.app=flask-stack"
  - "version=1.0.0"
  - "environment=development"
```
Verify: `docker compose ps` shows labels + health status




## Task 6: Scaling (Bonus)
Scale Command:

```bash
docker compose up --scale web=3 -d
```
What Broke: Port conflict! All 3 web containers want `host:5000`
```bash
Error: Bind for 0.0.0.0:5000 failed: port already allocated
Production Fix:

```bash
web:
  ports: []  # Remove host binding
  # Use Traefik/Nginx ingress or service mesh
```
Scaling Reality: Internal services scale fine, external ports need load balancer.

Key Commands Mastered : 

```bash 
# Full lifecycle
docker compose up --build -d           # Build + start background
docker compose logs -f web             # Live logs
docker compose down -v                 # Stop + clean volumes

# Health + Status
docker compose ps                      # Health + labels
docker compose exec web flask --version

# Tests
docker compose restart db              # Policy test
docker compose up --scale web=3        # Scaling demo
```