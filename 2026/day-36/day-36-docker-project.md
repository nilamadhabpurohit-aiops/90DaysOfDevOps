# Day 36 – Docker Project: Dockerize a Full Application

## Task 1: Pick Your App: TodoApp (Node.js + MongoDB)
Repo: https://github.com/vermakhushboo/TodoApp
My Fork: https://github.com/nilamadhab1996/TodoApp

Why? Perfect match - no Docker files, has DB, real app with UI.

## Task 2: Write the Dockerfile
### Dockerfile (Multi-stage)
```bash
# 1 BUILDER - install deps only
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json .
RUN npm ci --only=production --no-optional && npm cache clean --force

# 2 RUNTIME - tiny image
FROM node:20-alpine
RUN addgroup -g 1001 appgroup \
    && adduser -S -D -u 1001 -G appgroup appuser
WORKDIR /app
COPY --from=builder --chown=appuser:appgroup /app/node_modules ./node_modules
COPY --chown=appuser:appgroup . .
USER appuser
EXPOSE 3000
HEALTHCHECK CMD curl -f http://localhost:3000 || exit 1
CMD ["node", "index.js"]
```

### Docker Compose
```yml
services:
  web:
    build: .
    command: node index.js
    ports:
      - "3000:3000"
    environment:
      - DB_CONNECT=mongodb://mongo:27017/todoapp   # ← was MONGO_URI, now DB_CONNECT
      - PORT=3000
    depends_on:
      mongo:
        condition: service_healthy
    networks:
      - app-net
    restart: unless-stopped

  mongo:
    image: mongo:7.0
    command: mongod --bind_ip_all
    volumes:
      - mongodata:/data/db
    healthcheck:
      test: ["CMD-SHELL", "echo 'db.runCommand({ping:1}).ok' | mongosh localhost:27017/todoapp --quiet"]
      interval: 10s
      timeout: 10s
      retries: 5
      start_period: 20s
    networks:
      - app-net
    restart: unless-stopped

volumes:
  mongodata:

networks:
  app-net:
    driver: bridge
```
### Problems I Fixed
- Mongo alpine - Doesn't exist → mongo:7.0
- GID 1000 used? → Changed to 1001
- nodemon missing? → node index.js (dev dep)
- DB not connecting? → DB_CONNECT not MONGO_URI

Fresh pull test → Works perfectly!

## Task 4: Ship It
bash
docker compose up -d --build
# http://localhost:3000 ✅
### Docker Hub
```bash
docker build -t nilamadhab1996/node-todo-mongo .
docker push nilamadhab1996/node-todo-mongo:latest
Link: https://hub.docker.com/r/nilamadhab1996/node-todo-mongo
```

## Task 5: Test the Whole Flow
```bash
docker compose down -v --rmi all
docker compose pull && docker compose up -d
```


## Learnings:
- Check app's env var names first
- MongoDB ≠ Alpine (use Ubuntu image)
- Always test fresh pull from Hub
- npm ci --production = no dev tools