# Day 46 – Reusable Workflows & Composite Actions

## Overview

Today I learned how to avoid repeating CI/CD logic by using reusable workflows and composite actions in GitHub Actions.

Instead of writing workflows repeatedly in every repository, reusable workflows allow pipelines to share common logic.

Example workflow run:  https://github.com/nilamadhabpurohit-aiops/github-actions-practice

---

# What is a Reusable Workflow?

A reusable workflow is a GitHub Actions workflow that can be called from another workflow using the `workflow_call` trigger.

This allows teams to standardize CI/CD pipelines across repositories.

Reusable workflows must be stored in:

```
.github/workflows/
```

---

# What is workflow_call?

`workflow_call` allows one workflow to call another workflow like a function.

Example:

```
uses: ./.github/workflows/reusable-build.yml
```

---

# Reusable Workflow Example

```yaml
on:
  workflow_call:
    inputs:
      app_name:
        required: true
        type: string
```

The workflow accepts inputs and secrets from the caller.

---

# Job Outputs

Reusable workflows can generate outputs and pass them back to the caller.

Example:

```
echo "version=$VERSION" >> $GITHUB_OUTPUT
```

This allows later jobs to use values produced earlier in the pipeline.

---

# Composite Actions

Composite actions allow grouping multiple steps into a reusable action.

They live in:

```
.github/actions/<action-name>/
```

Example:

```
runs:
  using: "composite"
```

Composite actions are used with:

```
uses: ./.github/actions/setup-and-greet
```

---

# Reusable Workflow vs Composite Action

| Feature | Reusable Workflow | Composite Action |
|--------|------------------|------------------|
| Triggered by | workflow_call | uses in step |
| Can contain jobs | Yes | No |
| Can contain multiple steps | Yes | Yes |
| Lives where | `.github/workflows` | `.github/actions` |
| Accept secrets directly | Yes | No |
| Best for | Full pipelines | Reusable step logic |

---

# Key Learnings

1. Reusable workflows reduce duplication across repositories.
2. `workflow_call` enables workflows to behave like functions.
3. Outputs allow data sharing between jobs.
4. Composite actions help bundle multiple steps into reusable logic.

---

# Conclusion

Reusable workflows and composite actions are powerful GitHub Actions features that enable scalable CI/CD architectures and reduce repetition in pipelines.
