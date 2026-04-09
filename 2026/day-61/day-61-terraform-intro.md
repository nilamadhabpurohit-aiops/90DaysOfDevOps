# Day 61 -- Introduction to Terraform

# Task 1: Understand Infrastructure as Code

## Q1: What is Infrastructure as Code (IaC)? Why does it matter in DevOps?

Infrastructure as Code (IaC) is the process of managing and provisioning
infrastructure using code instead of manually creating resources from
the cloud console. Using Terraform, we can define infrastructure like
servers, storage, and networks in configuration files.

IaC is important in DevOps because it enables automation, consistency,
and repeatability. It also reduces human errors and helps teams manage
infrastructure efficiently.

------------------------------------------------------------------------

## Q2: What problems does IaC solve compared to manually creating resources in AWS console?

Problems with manual creation:

-   Time consuming process
-   Human errors possible
-   No version control
-   Difficult to recreate same environment
-   No automation

Solutions using IaC:

-   Automated infrastructure creation
-   Version control using Git
-   Easy to recreate environments
-   Faster deployment
-   Better consistency

------------------------------------------------------------------------

## Q3: How is Terraform different from AWS CloudFormation, Ansible, and Pulumi?

**Terraform** - Infrastructure provisioning tool - Multi-cloud support -
Uses HCL language - Declarative approach

**AWS CloudFormation** - Only works with AWS - Uses YAML/JSON - Native
AWS service

**Ansible** - Configuration management tool - Procedural approach -
Mostly used for software configuration

**Pulumi** - Infrastructure using programming languages - Supports
Python, Go, Typescript

------------------------------------------------------------------------

## Q4: What does Terraform being declarative and cloud agnostic mean?

**Declarative:** Means we define what infrastructure we want instead of
writing steps to create it.

Example: We just define EC2 instance configuration and Terraform handles
the creation process.

**Cloud agnostic:** Means Terraform works with multiple cloud providers
like AWS, Azure and GCP. So we can use the same tool across different
platforms.

------------------------------------------------------------------------

# Task 2: Install Terraform and Configure AWS

## Q1: Verify Terraform installation

Command used:

``` bash
terraform -version
Terraform v1.12.2
```

This command verifies Terraform is installed properly.

## Q2: Verify AWS CLI access

Command used:

``` bash
aws sts get-caller-identity
```

This command confirms AWS CLI is configured correctly and shows account
details.

------------------------------------------------------------------------

# Task 3: Create S3 Bucket using Terraform

## Q1: What did terraform init download?

terraform init downloaded:

-   AWS provider plugin
-   Required dependencies
-   Created .terraform directory
-   Lock file

The .terraform directory contains provider binaries and Terraform
metadata.

------------------------------------------------------------------------

# Task 4: Add EC2 Instance

## Q1: How does Terraform know S3 bucket already exists and only EC2 needs creation?

Terraform tracks infrastructure using the **terraform.tfstate** file.
When terraform plan runs, Terraform compares:

Desired configuration\
vs\
Current state

Since S3 already exists in state file, Terraform only creates EC2.

------------------------------------------------------------------------

# Task 5: Understand State File

## Q1: What information does the state file store?

State file stores:

-   Resource IDs
-   ARN details
-   Tags
-   Metadata
-   Dependencies
-   Resource configuration

Terraform uses this file to track infrastructure.

------------------------------------------------------------------------

## Q2: Why should you never manually edit state file?

Because: - Can corrupt Terraform tracking - Can cause wrong updates -
May recreate resources unexpectedly - Can break dependencies

Terraform provides terraform state commands instead.

------------------------------------------------------------------------

## Q3: Why should state file not be committed to Git?

Because it may contain:

-   Infrastructure details
-   Resource IDs
-   Sensitive metadata
-   IP addresses

Best practice is using remote state storage like S3.

------------------------------------------------------------------------

# Task 6: Modify, Plan and Destroy

## Q1: What do +, - and \~ symbols mean?

Terraform plan symbols:

-   → Resource creation\

-   

    → Resource deletion
    :   → Resource modification

When EC2 tag was changed Terraform showed **\~** which means in-place
update.

------------------------------------------------------------------------

## Q2: Is this in-place update or destroy and recreate?

This was an **in-place update** because only tag value changed and
Terraform did not need to recreate the instance.

------------------------------------------------------------------------

# Terraform Commands Summary

## terraform init

Initializes working directory and downloads providers.

## terraform plan

Shows execution plan before applying changes.

## terraform apply

Creates infrastructure defined in configuration.

## terraform destroy

Deletes all Terraform managed infrastructure.

## terraform show

Displays current Terraform state in readable format.

## terraform state list

Lists all Terraform managed resources.

------------------------------------------------------------------------

# What I Learned Today

Today I learned:

-   Basics of Infrastructure as Code
-   Terraform lifecycle commands
-   How Terraform manages infrastructure
-   Importance of state file
-   How to create AWS resources using Terraform

This was my first practical step in learning Terraform as part of my
DevOps preparation journey.

------------------------------------------------------------------------

# Personal Learning Reflection

As someone preparing for DevOps roles, this task helped me understand
how infrastructure automation works in real projects. It also showed how
important Infrastructure as Code is for scalability and reliability.

------------------------------------------------------------------------

## Repository Link

GitHub Repository:
https://github.com/nilamadhabpurohit-aiops/terraform-aws-infrastructure-labs