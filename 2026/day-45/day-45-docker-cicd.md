# Day 45 – Docker Build & Push using GitHub Actions

## Overview

Today I implemented a complete CI/CD workflow where pushing code automatically builds a Docker image and pushes it to Docker Hub.

This demonstrates a real production pipeline pattern used in DevOps environments.

Docker Hub Image:
https://hub.docker.com/repository/docker/nilamadhab1996/ci-cd-automation-github-actions/tags/76e9890f39eec50272d78d64a688762ba20428a1/sha256-d3ffb7cfa25fc1ecf1dbb48bef0f8d68eb5a740d98c919168dca17a3837bfa2a

---

# Workflow YAML

```yaml
name: Docker Publish

on:
  push:
    branches:
      - main

env:
  FORCE_JAVASCRIPT_ACTIONS_TO_NODE24: true

jobs:

  build:

    runs-on: ubuntu-latest

    steps:

      - name: Checkout
        uses: actions/checkout@v5  

      - name: Login Docker
        uses: docker/login-action@v4    
        with:
          username: ${{ secrets.DOCKER_USERNAME }}
          password: ${{ secrets.DOCKER_TOKEN }}

      - name: Build and Push
        uses: docker/build-push-action@v6
        with:
          push: true
          tags: |
            ${{ secrets.DOCKER_USERNAME }}/ci-cd-automation-github-actions:latest
            ${{ secrets.DOCKER_USERNAME }}/ci-cd-automation-github-actions:${{ github.sha }}
```

---

# Pipeline Flow

The workflow performs:

1 Checkout repository  
2 Build Docker image  
3 Tag image with latest  
4 Tag image with commit SHA  
5 Login to Docker Hub  
6 Push image  

---

# Image Tags

Two tags are created:

latest  
sha-<commit>

Example:

```
docker pull nilamadhab1996/ci-cd-automation-github-actions:latest
nilamadhab1996/ci-cd-automation-github-actions:76e9890f39eec50272d78d64a688762ba20428a1
```

---

# Git Push → Running Container Journey

Full CI/CD flow:

Developer pushes code  
↓  
GitHub triggers workflow  
↓  
Runner builds Docker image  
↓  
Image tagged with commit version  
↓  
Image pushed to Docker Hub  
↓  
Server pulls image  
↓  
Container starts

This demonstrates automated build and delivery pipeline.

---

# Key Learnings

1 CI pipelines can automatically build Docker images.
2 Secrets securely store credentials.
3 Image tagging enables version tracking.
4 CI/CD removes manual deployment steps.

---

# Conclusion

This exercise helped me understand how real-world CI/CD pipelines automate container builds and push artifacts to registries, enabling faster and reliable deployments. 