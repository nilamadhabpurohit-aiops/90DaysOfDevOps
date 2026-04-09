# Day 64 -- Terraform State Management and Remote Backends

# Task 1: Inspect Current State

## Q1: How many resources does Terraform track?

Terraform tracks all resources defined in configuration files and stored
in the state file.

Example resources tracked in my setup:

-   VPC
-   Subnet
-   Internet Gateway
-   Route Table
-   Security Group
-   EC2 instance
-   S3 bucket

Terraform tracks these resources using:

``` bash
terraform state list
```

------------------------------------------------------------------------

## Q2: What attributes does state store for EC2?

Terraform state stores much more than what we define.

Example attributes:

-   Instance ID
-   AMI ID
-   Instance type
-   Public IP
-   Private IP
-   Security group ID
-   Subnet ID
-   ARN
-   Tags
-   Availability zone
-   Root block device

Terraform uses these attributes to track real infrastructure.

------------------------------------------------------------------------

## Q3: What does serial number represent in terraform.tfstate?

Serial number represents the version of the state file.

Every time Terraform updates infrastructure, serial number increases.

Purpose:

-   Track state changes
-   Prevent conflicts
-   Maintain consistency

------------------------------------------------------------------------

# Task 2: S3 Remote Backend

## Q1: Why remote backend is needed?

Problems with local state:

-   Can be deleted accidentally
-   Not safe for team use
-   No locking
-   No version history

Benefits of remote backend:

-   Centralized storage
-   State locking
-   Version control
-   Team collaboration
-   Backup support

------------------------------------------------------------------------

## Q2: What happened after terraform init?

Terraform asked to migrate state to remote backend.

After migration:

-   State moved to S3
-   Local state removed
-   terraform plan showed no changes

This confirms successful migration.

------------------------------------------------------------------------

# Task 3: State Locking

## Q1: What error occurred?

When running terraform plan during another operation:

Terraform shows lock error.

Example error:

Error acquiring the state lock

This happens because another Terraform operation is running.

------------------------------------------------------------------------

## Q2: Why locking is important?

Locking prevents:

-   Multiple terraform apply runs
-   State corruption
-   Resource conflicts
-   Race conditions

Important in team environments.

------------------------------------------------------------------------

# Task 4: Import Existing Resource

## Q1: Difference between import and creating resource

terraform import:

Brings existing resource into Terraform state.

terraform apply:

Creates new resource.

Difference:

Import → Existing resource\
Apply → New resource

Import does not create infrastructure.

------------------------------------------------------------------------

# Task 5: State Surgery

## Q1: When to use terraform state mv?

Used when:

-   Renaming resource
-   Moving resource to module
-   Refactoring code

Example:

``` bash
terraform state mv aws_instance.old aws_instance.new
```

------------------------------------------------------------------------

## Q2: When to use terraform state rm?

Used when:

-   Remove resource from Terraform control
-   Resource still exists in AWS
-   Stop managing resource via Terraform

Example:

``` bash
terraform state rm aws_s3_bucket.logs
```

------------------------------------------------------------------------

# Task 6: State Drift

## Q1: What is state drift?

State drift happens when infrastructure is modified outside Terraform.

Example:

-   Manual AWS console change
-   CLI modification
-   Another automation tool

Terraform detects this using:

``` bash
terraform plan
```

------------------------------------------------------------------------

## Q2: How to fix drift?

Two approaches:

Option A: Run terraform apply to restore desired state.

Option B: Update Terraform config to match manual changes.

I used Option A to restore Terraform configuration.

------------------------------------------------------------------------

## Q3: How teams prevent drift?

Best practices:

-   Restrict console access
-   Use IAM policies
-   Use CI/CD pipelines
-   All changes via Terraform
-   Enable change approvals

------------------------------------------------------------------------

# When to use these commands

## terraform state mv

Used for:

-   Resource rename
-   Module migration
-   Refactoring infrastructure

------------------------------------------------------------------------

## terraform state rm

Used for:

-   Stop Terraform management
-   Manual resource management
-   Migration scenarios

------------------------------------------------------------------------

## terraform import

Used for:

-   Existing infrastructure adoption
-   Migration to Terraform
-   Brownfield projects

------------------------------------------------------------------------

## terraform force-unlock

Used when:

-   Lock stuck
-   Terraform crashed
-   Manual recovery needed

Use carefully.

------------------------------------------------------------------------

## terraform refresh

Used to:

-   Sync state with real infrastructure
-   Detect external changes
-   Update state file

------------------------------------------------------------------------

# What I Learned Today

Today I learned:

-   Terraform state importance
-   Remote backend setup
-   State locking concept
-   Import existing resources
-   State drift handling
-   State commands

This task helped me understand how Terraform manages infrastructure
safely in team environments.

------------------------------------------------------------------------

# Personal Learning Reflection

As someone preparing for DevOps roles, this task helped me understand
why Terraform state is considered the most critical component. Learning
remote backend and locking showed how real production teams safely
manage infrastructure changes.

------------------------------------------------------------------------

## Repository Link

GitHub Repository:
https://github.com/nilamadhabpurohit-aiops/terraform-aws-infrastructure-labs