# Day 37 – Docker Revision & Cheat Sheet

## Self-Assessment Checklist
Mark yourself honestly — **can do**, **shaky**, or **haven't done**:

- [Can do] Run a container from Docker Hub (interactive + detached)
- [Can do] List, stop, remove containers and images
- [Can do] Explain image layers and how caching works
- [Can do] Write a Dockerfile from scratch with FROM, RUN, COPY, WORKDIR, CMD
- [shaky] Explain CMD vs ENTRYPOINT
- [Can do] Build and tag a custom image
- [Can do] Create and use named volumes
- [haven't done] Use bind mounts
- [Can do] Create custom networks and connect containers
- [Can do] Write a docker-compose.yml for a multi-container app
- [shaky] Use environment variables and .env files in Compose
- [shaky] Write a multi-stage Dockerfile
- [Can do] Push an image to Docker Hub
- [haven't done] Use healthchecks and depends_on


---

## Quick-Fire Questions
Answer from memory, then verify:
1. What is the difference between an image and a container?
    - Image vs Container: Blueprint vs running instance
2. What happens to data inside a container when you remove it?
    - Data on rm: Lost (no volumes)
3. How do two containers on the same custom network communicate?
    - Network: curl mongo:27017 (service=hostname)
4. What does `docker compose down -v` do differently from `docker compose down`?
    - down -v: Deletes volumes/data
5. Why are multi-stage builds useful?
    - Multi-stage: Build tools → tiny runtime
6. What is the difference between `COPY` and `ADD`?
    - COPY/ADD: COPY=files, ADD=tar/URL too
7. What does `-p 8080:80` mean?
    - -p 8080:80: Host 8080 → Container 80
8. How do you check how much disk space Docker is using?
    - Disk: docker system df


---
