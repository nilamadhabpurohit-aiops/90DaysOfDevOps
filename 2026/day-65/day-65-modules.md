# Day 65 -- Terraform Modules: Build Reusable Infrastructure

## Task 1 -- Module Structure Understanding

### Q1 What is a Terraform module?

A Terraform module is a collection of Terraform configuration files
grouped together to create reusable infrastructure. Modules help
organize infrastructure like reusable functions in programming.

### Q2 Difference between Root and Child module

Root Module: The main Terraform configuration directory where we run
terraform commands.

Child Module: Reusable Terraform components stored inside the modules
directory and called by the root module.

### Q3 Benefits of using modules

Code reuse\
Better structure\
Easy maintenance\
Environment consistency\
Scalability

------------------------------------------------------------------------

## Task 2 -- EC2 Module Creation

### Q1 What inputs did you define?

Inputs defined:

ami_id\
instance_type\
subnet_id\
security_group_ids\
instance_name\
tags

### Q2 What outputs were created?

Outputs:

instance_id\
public_ip\
private_ip

### Q3 How is module reuse demonstrated?

Module reuse shown by creating two EC2 instances:

terraweek-web\
terraweek-api

------------------------------------------------------------------------

## Task 3 -- Security Group Module

### Q1 How did you implement dynamic ingress?

Used dynamic block with for_each on ingress_ports.

### Q2 Variables used

vpc_id\
sg_name\
ingress_ports\
tags

### Q3 Output

Security group ID returned as sg_id.

------------------------------------------------------------------------

## Task 4 -- Root Module Integration

### Q1 How modules were connected?

Security group output used in EC2 module.

### Q2 How many EC2 instances created?

Two instances using same module.

### Q3 Concepts used

Module calls\
Outputs\
Dependencies\
Reusable design

------------------------------------------------------------------------

## Task 5 -- Terraform Registry Module

### Q1 What is Terraform Registry?

Public collection of reusable Terraform modules.

### Q2 Why use registry modules?

Production tested\
Time saving\
Community maintained

### Q3 Best practice

Always pin version.

------------------------------------------------------------------------

## Task 6 -- Module Best Practices

Small focused modules\
Clear variables\
Outputs defined\
Reusable design\
Documentation added

------------------------------------------------------------------------

## Commands Used

terraform init

terraform validate

terraform plan

terraform apply

terraform destroy

------------------------------------------------------------------------

## What I Learned

How modules improve Terraform structure\
How reusable infrastructure is designed\
How real Terraform projects are structured

------------------------------------------------------------------------

## Repository Link

GitHub Repository:
https://github.com/nilamadhabpurohit-aiops/terraform-aws-infrastructure-labs
