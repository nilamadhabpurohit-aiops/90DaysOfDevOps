# Day 30 – Docker Images & Container Lifecycle

## Task 1: Docker Images

Today I explored Docker images and understood how they are related to containers.

---

### Pull the required images

I pulled the following images from Docker Hub:

```bash
docker pull nginx
docker pull ubuntu
docker pull alpine
```
Screenshot:

List all images - > `docker images`

Observation:
- nginx, ubuntu, and alpine images are available.
- Each image has different sizes.

### Compare ubuntu vs alpine

**I noticed that:**
- Ubuntu image is much larger.
- Alpine image is very small.
**Reason:**
- Ubuntu is a full Linux distribution.
- Alpine is a minimal Linux OS designed for containers.
- Alpine removes unnecessary packages, so it is lightweight.
- This makes Alpine faster and good for production environment

### Inspect an image
```
docker inspect nginx
```
From this, I saw:
1. Image ID
2. Creation date
3. Environment variables
4. Layers
5. Configuration details

### Remove an unused image
`docker rmi alpine` -> This removed the image from my system.


## Task 2: Image Layers

### 1. Run: docker image history nginx
Shows stacked layers from bottom (base) to top:
```bash
IMAGE          CREATED        CREATED BY                                      SIZE
abc123...     2 weeks ago    /bin/sh -c #(nop)  CMD ["nginx" "-g" ...]      0B
def456...     2 weeks ago    /bin/sh -c #(nop)  EXPOSE 80                    0B  
ghi789...     2 weeks ago    /bin/sh -c #(nop)  COPY ...                     30MB
...many more
jkl012...     3 months ago   /bin/sh -c #(nop)  CMD ["/bin/sh"]              0B [web:36]
```
### 2. Layers with sizes vs 0B:
Sizes show actual files added/changed (like nginx binaries: 30-150MB). 0B layers are metadata-only instructions (CMD, EXPOSE, LABEL) that don't add files.
​

### 3. What are layers? Why use them?
Layers are filesystem "diffs" - each Dockerfile instruction (RUN, COPY) creates one. Docker stacks them like onion layers into a union filesystem.
#### Why:
- Cache/Reuse: Unchanged lower layers reuse across images → faster builds.
- Share: Multiple containers share common layers (saves disk space).
- Efficiency: Only rebuild changed top layers, not whole image.

**Example:** Nginx base (Debian) + nginx install layer + config layer = slim final image vs fat VM.

---

## Task 3: Container Lifecycle
Use Nginx example. Run docker ps -a after each to see STATUS: created → running → paused → running → exited → running → dead/exited → gone.

1. Create (no start):
`docker create --name my-nginx nginx`
Status: Created

2. Start:
`docker start my-nginx`
Status: Up (running)
​

3. Pause & check:
`docker pause my-nginx`
Status: Paused (processes frozen, memory held)
​

4. Unpause:
`docker unpause my-nginx`
Status: Up (resumes exactly where paused)
​

5. Stop:
`docker stop my-nginx`
Status: Exited (graceful SIGTERM shutdown)
​

6. Restart:
`docker restart my-nginx (stops + starts)`
Status: Up
​

7. Kill:
`docker kill my-nginx`
Status: Dead or Exited (immediate SIGKILL, no cleanup)
​

8. Remove:
`docker rm my-nginx`
Gone from docker ps -a (frees all)
​

**Key: Pause freezes (SIGSTOP), stop graceful (SIGTERM), kill harsh (SIGKILL). Restart = stop+start.**

---

## Task 4: Working with Running Containers

### 1. Run Nginx detached:

```bash
docker run -d --name webserver -p 8080:80 nginx
```
Background, access http://localhost:8080
​

### 2. View logs:

```bash
docker logs webserver
```
Shows startup: "/docker-entrypoint.sh: nginx starting"
​

### 3. Real-time logs (follow):
```bash
docker logs -f webserver
```
Live tail (-f like tail -f), Ctrl+C to stop
​

### 4. Exec inside (interactive shell):

```bash
docker exec -it webserver bash
ls /usr/share/nginx/html  # index.html
cat /etc/nginx/nginx.conf
exit
```
Explore like SSH
​

### 5. Single command (no shell):
```bash
docker exec webserver ls -la
```
Quick checks
​

### 6. Inspect details:
```bash
docker inspect webserver | grep -i ip  # "IPAddress": "172.17.0.5"
docker inspect webserver | grep -i port  # "HostPort": "8080"
docker inspect webserver | grep -i mount  # Volumes/bind mounts
```
JSON with IP (172.x), ports {"80/tcp": [{"HostIp": "0.0.0.0", "HostPort": "8080"}]}, mounts if any

---

## Task 5: Cleanup
### 1. Stop all running containers in one command
```bash 
docker stop $(docker ps -q)
```
**This command:**
- `docker ps -q` -> gives IDs of all running containers
- docker stop stops all of them at once

### 2. Remove all stopped containers in one command
```bash
docker rm $(docker ps -a -q)
```
**This command:**
- Lists all containers
- Removes them in one go

**NOTE:** Make sure containers are stopped before running this.

### 3. Remove unused images
```bash
docker image prune
```
**This removes:**
Dangling images (not used by any container)
If you want to remove all unused images:
```bash
docker image prune -a
```
### 4. Check how much disk space Docker is using
```bash
docker system df
```
**This shows:**
- Image size
- Container storage
- Volumes
- Cache
