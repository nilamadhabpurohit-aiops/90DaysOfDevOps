# Day 47 – Advanced GitHub Actions Triggers

## Overview

Today I explored advanced GitHub Actions triggers including PR lifecycle events, scheduled workflows, workflow chaining, and external triggers.

Example workflow run:  https://github.com/nilamadhabpurohit-aiops/github-actions-practice

---

# PR Lifecycle Events

PR workflows can trigger on:

opened  
synchronize  
reopened  
closed  

This helps automate validation checks during PR lifecycle.

---

# PR Validation

Implemented checks for:

File size validation  
Branch naming rules  
PR description validation  

These act as quality gates.

---

# Cron Expressions

Every weekday 9 AM IST:

30 3 * * 1-5

First day of month midnight:

0 0 1 * *

---

# workflow_run vs workflow_call

workflow_call:
Reusable workflow invoked manually by another workflow.

workflow_run:
Triggered automatically after another workflow completes.

---

# Key Learnings

1 GitHub supports many event triggers.
2 PR checks help enforce standards.
3 Cron workflows automate maintenance.
4 workflow_run enables pipeline chaining.
5 repository_dispatch enables external triggers.

---

# Conclusion

This exercise helped me understand event-driven CI/CD pipelines and how workflows can respond to different repository activities.
