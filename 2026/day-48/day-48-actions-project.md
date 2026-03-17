# Day 48 – End to End GitHub Actions CI/CD

## Pipeline Architecture

PR opened  
→ Build & test  
→ PR validation

Merge to main  
→ Build & test  
→ Docker build  
→ Docker push  
→ Deploy

Scheduled  
→ Health check

---

## Workflows

Reusable build-test workflow  
Reusable docker workflow  
PR pipeline  
Main pipeline  
Health check workflow  

---

## Docker Image

https://hub.docker.com/repository/docker/nilamadhab1996/github-actions-capstone/general

---

## Key Learnings

Reusable workflows reduce duplication.

CI should validate PRs before merge.

Docker pipelines automate deployment.

Scheduled workflows help monitor applications.

---

## Improvements

Add:
Slack notifications  
Security scans  
Rollback strategy  
Multi environment deployment  
