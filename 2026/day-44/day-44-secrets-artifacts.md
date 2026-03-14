# Day 44 – Secrets, Artifacts & Real Tests in CI

## Overview

Today I explored how CI pipelines handle sensitive data, store build outputs, and execute real tests automatically.

---

# Secrets

I created a GitHub secret and accessed it securely in a workflow.

GitHub automatically masks secret values in logs to prevent accidental exposure.

### Why secrets should never be printed

Secrets should never be printed because:
- Logs are visible to collaborators
- Secrets may leak credentials
- Can cause security incidents

---

# Artifacts

Artifacts allow saving files generated during pipeline execution.

Example uses:
- Test reports
- Build logs
- Deployment packages

I uploaded a report file and downloaded it from the Actions tab.

---

# Artifacts Between Jobs

Artifacts can transfer data between jobs.

Example:
Job1 generates file  
Job2 downloads and uses it.

Real use cases:
- Passing build binaries
- Sharing test results
- Deployment packages

---

# Running Real Tests

I executed a shell script in CI.

When script failed → pipeline turned red.
After fixing → pipeline turned green.

This demonstrates CI validation.

---

# Caching

Caching stores dependencies between runs.

Benefits:
- Faster builds
- Less downloads
- Reduced CI time

Cache stores:
Dependency directories like pip/npm.

---

# Key Learnings

1. Secrets must always be stored securely.
2. Artifacts help share files between jobs.
3. CI pipelines should run real tests.
4. Caching improves pipeline performance.

---

# Conclusion

This exercise helped me understand how CI pipelines securely manage secrets, share build outputs, and automate testing to ensure software reliability.
