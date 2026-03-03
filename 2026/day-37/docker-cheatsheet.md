# Docker Cheat Sheet 

## Containers
| Command | What it does |
|---------|-------------|
| `docker run nginx` | Run image |
| `docker run -d -p 80:80 nginx` | Detached + port map |
| `docker ps` | Running containers |
| `docker ps -a` | All containers |
| `docker stop web` | Stop container |
| `docker rm web` | Remove container |
| `docker exec -it web bash` | Shell inside |
| `docker logs web -f` | Follow logs |

## Images
| Command | What it does |
|---------|-------------|
| `docker images` | List images |
| `docker build -t myapp .` | Build + tag |
| `docker tag myapp nilamadhab1996/myapp` | Rename/tag |
| `docker push nilamadhab1996/myapp` | Push to Hub |
| `docker rmi myapp` | Remove image |
| `docker history myapp` | See layers |

## Volumes
| Command | What it does |
|---------|-------------|
| `docker volume create myvol` | Named volume |
| `docker volume ls` | List volumes |
| `docker run -v myvol:/app nginx` | Named volume |
| `docker run -v $(pwd):/app nginx` | Bind mount |
| `docker volume rm myvol` | Remove volume |

## Networks
| Command | What it does |
|---------|-------------|
| `docker network create mynet` | Custom network |
| `docker network ls` | List networks |
| `docker run --network mynet nginx` | Connect container |

## Docker Compose
| Command | What it does |
|---------|-------------|
| `docker compose up -d --build` | Start + rebuild |
| `docker compose ps` | Status |
| `docker compose logs web` | Service logs |
| `docker compose down` | Stop (keep volumes) |
| `docker compose down -v` | Stop + delete volumes |

## Cleanup
| Command | What it does |
|---------|-------------|
| `docker system prune -a` | Remove ALL unused |
| `docker system df` | Disk usage |
| `docker volume prune` | Unused volumes |

## Dockerfile Instructions
```bash 
FROM node:20-alpine # Base image
WORKDIR /app # Working directory
COPY package*.json . # Copy files
RUN npm ci --production # Execute command
EXPOSE 3000 # Document port
CMD ["node", "index.js"] # Default command
```
**Multi-stage:** Multiple `FROM` → copy from builder stage only

**CMD vs ENTRYPOINT:**
CMD ["node", "app.js"] # Args (overridable)
ENTRYPOINT ["node"] # Command (fixed)

