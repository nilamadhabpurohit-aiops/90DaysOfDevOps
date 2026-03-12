# Day 42 – GitHub Hosted vs Self Hosted Runners

## Overview

Today I learned about GitHub Actions runners and how CI jobs actually execute behind the scenes. Understanding runners helped me see how pipelines are not just YAML files but real jobs running on actual machines.

As part of this exercise, I worked with both GitHub-hosted runners and configured a self-hosted runner to understand the differences.

Proof of workflow execution:
https://github.com/nilamadhab1996/github-actions-practice/actions/workflows/job-output.yml

---

## GitHub Hosted Runners

GitHub hosted runners are virtual machines managed by GitHub that execute workflows automatically. These machines come with many tools pre-installed and are created fresh for every run.

Key learning:
GitHub manages the infrastructure, scaling, and maintenance, which makes it very easy to start CI pipelines.

---

## Self Hosted Runners

Self hosted runners are machines that we configure ourselves where GitHub can send jobs to execute.

This helped me understand:
- How CI jobs run on real infrastructure
- How runners register with GitHub
- How jobs can execute on my own system

This is useful when:
- Custom tools are needed
- Internal network access is required
- Faster builds are required
- Cost optimization is needed

---

## Why Pre-installed Tools Matter

GitHub runners come with tools like:
- Docker
- Python
- Node
- Git

This reduces setup time and makes pipelines faster because dependencies don't need installation every time.

I also observed that not all runners have the same tools. For example, Docker is available on Ubuntu runners but not on macOS runners, which is important when designing cross-platform workflows.

---

## Labels

Labels help target specific runners when multiple runners are available.

Example:

runs-on: [self-hosted, linux, my-linux-runner]

Labels are useful when:
- Multiple runners exist
- Different environments are required
- Hardware-specific jobs are needed

---

## GitHub Hosted vs Self Hosted Comparison

| Feature | GitHub Hosted | Self Hosted |
|---------|---------------|-------------|
| Who manages it | GitHub | User |
| Cost | Free minutes / paid | Infrastructure cost |
| Tools | Pre-installed | Custom setup |
| Good for | Standard CI | Custom workloads |
| Security | GitHub managed | User responsibility |

---

## Key Learnings

1. Runners are the machines that execute CI jobs.
2. GitHub hosted runners are easy to use but limited in customization.
3. Self hosted runners provide more flexibility and control.
4. Labels help route jobs to the correct runner.
5. Understanding runners helps in designing better CI/CD pipelines.

---

## Conclusion

This exercise helped me understand how CI jobs execute in real environments and the importance of selecting the right runner based on workload requirements. This knowledge is essential for building reliable CI/CD pipelines in real-world DevOps environments.

---
