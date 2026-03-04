# Day 39 – CI/CD Concepts

## Overview
Today’s focus was understanding the fundamentals of CI/CD before implementing pipelines. CI/CD helps development teams automate integration, testing, and deployment processes, enabling faster and more reliable software delivery.

---

# Task 1 – The Problem Without CI/CD

When multiple developers push code manually and deploy directly to production, several issues can occur.

### 1. What can go wrong?
- Code conflicts between developers
- Manual deployment mistakes
- Lack of testing before deployment
- Production outages due to untested code
- Difficult rollback when something breaks

### 2. What does “It works on my machine” mean?

This phrase refers to situations where code runs successfully in a developer’s local environment but fails in other environments such as staging or production.  
This usually happens due to differences in:
- OS
- dependencies
- environment variables
- configuration

CI helps detect these issues early.

### 3. How many times a day can a team safely deploy manually?

Manual deployments are risky and slow. Most teams can only deploy **1–2 times per day safely**.  
With CI/CD automation, teams can deploy **multiple times per day reliably**.

---

# Task 2 – CI vs CD

## Continuous Integration (CI)

Continuous Integration is the practice of automatically integrating code changes from multiple developers into a shared repository.  
Every code push triggers automated builds and tests to detect issues early.

**Example:**  
A developer pushes code to GitHub, and the CI pipeline automatically runs unit tests and lint checks.

---

## Continuous Delivery (CD)

Continuous Delivery ensures that the application is always in a **deployable state**.  
The pipeline automatically builds, tests, and prepares the application for deployment, but deployment requires manual approval.

**Example:**  
A pipeline builds a Docker image and pushes it to a registry, waiting for approval before deploying to production.

---

## Continuous Deployment

Continuous Deployment goes one step further by **automatically deploying every successful build to production without manual approval**.

**Example:**  
A SaaS platform automatically deploys new code to production after passing all tests.

---

# Task 3 – Pipeline Anatomy

### Trigger
An event that starts the pipeline, such as:
- code push
- pull request
- scheduled run

---

### Stage
A logical phase in the pipeline.

Example stages:
- build
- test
- deploy

---

### Job
A job is a set of tasks executed within a stage.

Example:
- run unit tests
- build docker image

---

### Step
A step is a single command or action inside a job.

Example:
```
docker build -t app .
```

---

### Runner
A runner is the machine or environment that executes the pipeline jobs.

Examples:
- GitHub hosted runner
- self-hosted runner
- Jenkins agent

---

### Artifact
Artifacts are outputs produced by pipeline jobs.

Examples:
- compiled binaries
- docker images
- build logs

---

# Task 4 – CI/CD Pipeline Diagram

Example pipeline for a developer pushing code to GitHub:

```
Developer Push
      |
      v
   GitHub Repo
      |
      v
+------------------+
|   CI Pipeline    |
+------------------+
      |
      v
Build Stage
- install dependencies
- build application
      |
      v
Test Stage
- run unit tests
- run lint checks
      |
      v
Docker Build
- create docker image
      |
      v
Push Image
- push to container registry
      |
      v
Deploy Stage
- deploy to staging server
```

---

# Task 5 – Exploring an Open Source CI Workflow

Repository explored: **FastAPI (GitHub)**

Workflow location:
`.github/workflows/`

### What triggers the workflow?
- Push events
- Pull requests

### How many jobs does it have?
Multiple jobs such as:
- linting
- testing
- documentation checks

### What does the workflow do?
The workflow ensures that:
- the code follows style guidelines
- tests pass successfully
- documentation builds correctly

This ensures high-quality code before merging changes.

---

### Key Learnings

1. CI/CD automates software integration, testing, and deployment.
2. CI helps detect issues early when developers push code.
3. CD enables reliable and repeatable deployments.
4. CI/CD pipelines improve development speed and system reliability.


### Conclusion

Understanding CI/CD concepts is critical before building pipelines. These practices help teams deliver software faster, reduce human errors, and maintain stable production environments.

