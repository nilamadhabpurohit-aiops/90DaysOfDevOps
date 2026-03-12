# Day 43 – Jobs, Steps, Environment Variables & Conditionals

## Overview

Today I learned how GitHub Actions workflows can be structured using multiple jobs, environment variables, outputs, and conditional execution. This helped me understand how real CI/CD pipelines control execution flow.

Example workflow execution:
https://github.com/nilamadhab1996/github-actions-practice/actions/workflows/job-output.yml

---

## Multi Job Workflow

I created a workflow with build → test → deploy dependency chain using:

```yaml
needs: build
```

This ensures jobs run in order.

---

## Environment Variables

I tested variables at 3 levels:

Workflow level:
```yaml
env:
  APP_NAME: myapp
```

Job level:
```yaml
env:
  ENVIRONMENT: staging
```

Step level:
```yaml
env:
  VERSION: 1.0.0
```

All variables were accessible within the job.

I also used GitHub context variables:
- github.sha
- github.actor

---

## Job Outputs

I created a job that generated today's date and passed it to another job.

Example:

```yaml
echo "today=$(date)" >> $GITHUB_OUTPUT
```

Used in next job:

```yaml
${{ needs.generate-date.outputs.today }}
```

### Why outputs matter

Outputs help share:
- Build versions
- Deployment info
- Test results
- Artifact paths

between jobs.

---

## Conditionals

I tested:

Run only on main:
```yaml
if: github.ref == 'refs/heads/main'
```

Run on failure:
```yaml
if: failure()
```

Continue pipeline even if error:

```yaml
continue-on-error: true
```

---

## Key Learnings

1. Jobs can depend on each other using needs.
2. Environment variables can be defined at multiple levels.
3. Outputs allow data sharing between jobs.
4. Conditionals help control pipeline execution.
5. continue-on-error allows workflows to continue even if a step fails.

---

## Conclusion

This exercise helped me understand how real CI/CD pipelines manage execution order, share data between jobs, and control workflow logic using conditions.
