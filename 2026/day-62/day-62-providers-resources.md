# Day 62 -- Providers, Resources and Dependencies

# Task 1: Explore AWS Provider

## Q1: What does `~> 5.0` mean?

`~> 5.0` means Terraform can install any version starting from **5.0 up
to but not including 6.0**.

Example: Allowed: 5.0\
5.1\
5.5\
5.20

Not allowed: 6.0

This helps maintain compatibility while allowing minor updates.

------------------------------------------------------------------------

## Q2: Difference between \~\> 5.0 , \>=5.0 and =5.0.0

\~\> 5.0\
Allows minor updates but restricts major upgrades.

> = 5.0\
> Allows any version greater than 5.0 including major upgrades.

= 5.0.0\
Locks exact version only.

Best practice: Use \~\> for stability.

------------------------------------------------------------------------

## Q3: What version was installed?

Command used:

``` bash
terraform init
```

Terraform installed AWS provider version based on the constraint
(\~\>5.0).

------------------------------------------------------------------------

## Q4: What does .terraform.lock.hcl do?

This file locks provider versions so every team member uses the same
version.

Purpose: - Version consistency - Prevent unexpected changes -
Reproducible builds

------------------------------------------------------------------------

# Task 2: Build VPC from Scratch

## Q1: Resources created

I created:

-   VPC
-   Subnet
-   Internet Gateway
-   Route Table
-   Route Table Association

Terraform plan showed 5 resources to be created.

------------------------------------------------------------------------

## Q2: Verification

After running terraform apply I verified in AWS console:

-   VPC created
-   Subnet attached to VPC
-   Internet gateway attached
-   Route table created
-   Route table associated with subnet

All resources were properly connected.

------------------------------------------------------------------------

# Task 3: Understand Implicit Dependencies

## Q1: How does Terraform know to create VPC before subnet?

Terraform understands dependencies when one resource references another.

Example:

``` hcl
vpc_id = aws_vpc.main.id
```

Because subnet depends on VPC ID, Terraform creates VPC first.

------------------------------------------------------------------------

## Q2: What happens if subnet is created before VPC?

Subnet creation would fail because it needs a VPC ID. Terraform prevents
this using dependency graph.

------------------------------------------------------------------------

## Q3: List implicit dependencies

Implicit dependencies in my configuration:

Subnet depends on: aws_vpc.main.id

Internet Gateway depends on: aws_vpc.main.id

Route table depends on: aws_vpc.main.id

Route table association depends on: aws_route_table.main.id\
aws_subnet.main.id

EC2 depends on: Subnet\
Security group

------------------------------------------------------------------------

# Task 4: Security Group and EC2

## Q1: Security group rules added

Ingress: SSH → Port 22\
HTTP → Port 80

Egress: All traffic allowed.

This allows: SSH access Web access

------------------------------------------------------------------------

## Q2: EC2 configuration

EC2 instance created with:

-   Amazon Linux 2 AMI
-   t2.micro
-   Public subnet
-   Security group attached
-   Public IP enabled

After apply I verified instance has public IP.

------------------------------------------------------------------------

# Task 5: Explicit Dependencies

## Q1: When do we use depends_on?

depends_on is used when Terraform cannot automatically detect
dependency.

Example:

Example 1: Application bucket should be created after EC2 instance.

Example 2: Database should be created after network setup.

Example 3: IAM role before EC2 instance.

------------------------------------------------------------------------

## Q2: Dependency graph

Command used:

``` bash
terraform graph
```

Terraform generated dependency relationships between resources.

This helps understand resource creation order.

------------------------------------------------------------------------

# Task 6: Lifecycle Rules

## Q1: create_before_destroy

Terraform creates new resource before destroying old resource.

Use case: Production servers to avoid downtime.

------------------------------------------------------------------------

## Q2: prevent_destroy

Prevents accidental deletion.

Example: Production database.

Example:

``` hcl
lifecycle {
prevent_destroy = true
}
```

------------------------------------------------------------------------

## Q3: ignore_changes

Terraform ignores specific changes.

Example: If tags change manually Terraform ignores.

Example:

``` hcl
lifecycle {
ignore_changes = [tags]
}
```

------------------------------------------------------------------------

# Destroy Behavior

Terraform destroys resources in reverse dependency order.

Example order:

EC2\
Security group\
Route association\
Route table\
Internet gateway\
Subnet\
VPC

This prevents dependency errors.

------------------------------------------------------------------------

# What I Learned Today

Today I learned:

-   AWS provider configuration
-   Terraform resource dependencies
-   Implicit vs explicit dependency
-   How VPC networking works
-   Terraform lifecycle rules
-   Dependency graph concept

This task helped me understand how real infrastructure components are
connected.

------------------------------------------------------------------------

# Personal Learning Reflection

As someone preparing for DevOps, this task helped me understand how
networking infrastructure is built using Terraform. It also helped me
understand how Terraform automatically manages dependencies which is
very important in real production environments.

------------------------------------------------------------------------

## Repository Link

GitHub Repository:
https://github.com/nilamadhabpurohit-aiops/terraform-aws-infrastructure-labs