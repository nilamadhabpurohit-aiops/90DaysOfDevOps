# Day 63 -- Variables, Outputs, Data Sources and Expressions

# Task 1: Extract Variables

## Q1: What are the five variable types in Terraform?

Terraform supports these variable types:

**string**\
Used for text values.\
Example:

``` hcl
region = "ap-south-1"
```

**number**\
Used for numeric values.

Example:

``` hcl
port = 22
```

**bool** Used for true/false values.

Example:

``` hcl
create_instance = true
```

**list** Used for multiple values.

Example:

``` hcl
allowed_ports = [22,80,443]
```

**map** Used for key value pairs.

Example:

``` hcl
tags = {
Environment = "dev"
Project = "terraweek"
}
```

------------------------------------------------------------------------

# Task 2: Variable Files and Precedence

## Q1: Variable precedence order (lowest to highest priority)

Terraform variable priority order:

Default values in variables.tf

terraform.tfvars

\*.auto.tfvars

-var-file

-var CLI flag

TF_VAR environment variables

Highest priority overrides lower ones.

Example:

Default:

``` hcl
instance_type = "t2.micro"
```

terraform.tfvars:

``` hcl
instance_type = "t3.micro"
```

CLI:

``` bash
terraform plan -var="instance_type=t2.nano"
```

Final value: t2.nano

------------------------------------------------------------------------

# Task 3: Outputs

## Q1: What are outputs?

Outputs display important resource information after terraform apply.

Example outputs:

-   VPC ID
-   Subnet ID
-   Instance ID
-   Public IP
-   Public DNS
-   Security group ID

------------------------------------------------------------------------

## Q2: Commands used

Show all outputs:

``` bash
terraform output
```

Show specific output:

``` bash
terraform output instance_public_ip
```

JSON format:

``` bash
terraform output -json
```

------------------------------------------------------------------------

# Task 4: Data Sources

## Q1: Difference between resource and data source

Resource: Creates infrastructure.

Example:

``` hcl
resource "aws_instance" "example"
```

Data source: Fetches existing infrastructure information.

Example:

``` hcl
data "aws_ami" "amazon_linux"
```

Difference:

Resource → Create\
Data → Read

Data sources are read only.

------------------------------------------------------------------------

# Task 5: Locals

## Q1: What are locals?

Locals are reusable values inside Terraform configuration.

Example:

``` hcl
locals {
name_prefix = "${var.project_name}-${var.environment}"
}
```

This avoids repeating same values.

------------------------------------------------------------------------

## Q2: Why use locals?

Benefits:

-   Avoid duplication
-   Improve readability
-   Centralized values
-   Cleaner code

------------------------------------------------------------------------

# Task 6: Built-in Functions and Conditional Expressions

## Q1: Five useful Terraform functions

**upper()**

Converts string to uppercase.

Example:

``` hcl
upper("terraweek")
```

Output: TERRAWEEK

------------------------------------------------------------------------

**join()**

Combines list values.

Example:

``` hcl
join("-",["terra","week","2026"])
```

Output: terra-week-2026

------------------------------------------------------------------------

**length()**

Counts list items.

Example:

``` hcl
length(["a","b","c"])
```

Output: 3

------------------------------------------------------------------------

**lookup()**

Finds value in map.

Example:

``` hcl
lookup({dev="t2.micro",prod="t3.small"},"dev")
```

Output: t2.micro

------------------------------------------------------------------------

**cidrsubnet()**

Creates subnet from CIDR.

Example:

``` hcl
cidrsubnet("10.0.0.0/16",8,1)
```

Output: 10.0.1.0/24

------------------------------------------------------------------------

## Q2: Conditional expression

Example:

``` hcl
instance_type = var.environment == "prod" ? "t3.small" : "t2.micro"
```

Meaning:

If environment = prod\
Use t3.small

Else\
Use t2.micro

------------------------------------------------------------------------

# Difference between variable, local, output and data

**Variable**

Input values given by user.

Example: Region

------------------------------------------------------------------------

**Local**

Internal reusable values.

Example: Name prefix

------------------------------------------------------------------------

**Output**

Displays result values.

Example: Public IP

------------------------------------------------------------------------

**Data**

Fetch existing resource info.

Example: AMI lookup

------------------------------------------------------------------------

# What I Learned Today

Today I learned:

-   Terraform variables
-   Variable precedence
-   Outputs usage
-   Data sources
-   Locals concept
-   Built-in functions
-   Conditional expressions

This task helped me understand how to make Terraform configurations
reusable and dynamic instead of hardcoding values.

------------------------------------------------------------------------

# Personal Learning Reflection

As someone preparing for DevOps roles, this task helped me understand
how real Terraform projects are written using variables and reusable
components. It also showed how important dynamic configuration is when
managing multiple environments like dev, staging and production.

------------------------------------------------------------------------

## Repository Link

GitHub Repository:
https://github.com/nilamadhabpurohit-aiops/terraform-aws-infrastructure-labs