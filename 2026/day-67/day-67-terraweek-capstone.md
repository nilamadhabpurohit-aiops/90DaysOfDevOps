# Day 67 – TerraWeek Capstone Project

Today I completed the TerraWeek capstone project where I built a production-style multi-environment infrastructure using Terraform modules and workspaces.

This project combines everything learned during TerraWeek:

Infrastructure as Code  
Terraform modules  
State management  
EKS provisioning  
Workspace based environments  

## Objective

Build one Terraform codebase that can deploy:

Dev  
Staging  
Production  

Each environment isolated using Terraform workspaces.

## Complete Project Structure

```
terraweek-capstone/

providers.tf
main.tf
variables.tf
outputs.tf
locals.tf

dev.tfvars
staging.tfvars
prod.tfvars

modules/

vpc/
security-group/
ec2-instance/
```

------------------------------------------------------------------------

## Custom Modules

### VPC Module

Creates:

VPC  
Subnet  
Internet gateway  
Route table  

Outputs:

vpc_id  
subnet_id  

------------------------------------------------------------------------

### Security Group Module

Creates:

Dynamic ingress rules  
Environment based security  

Output:

sg_id  

------------------------------------------------------------------------

### EC2 Module

Creates:

EC2 instance per environment.

Outputs:

instance_id  
public_ip  

------------------------------------------------------------------------

## Environment Differences

| Environment | Instance | Ports |
|-------------|----------|-------|
| Dev | t2.micro | 22,80 |
| Staging | t2.small | 22,80,443 |
| Prod | t3.small | 80,443 |

Production removes SSH for security best practice.

------------------------------------------------------------------------

## Workspace Commands Used

Create:

```bash
terraform workspace new dev

terraform workspace new staging

terraform workspace new prod
```

Switch: `terraform workspace select dev`

List: `terraform workspace list`

------------------------------------------------------------------------

## Deployment Process

Dev:

```bash
terraform workspace select dev

terraform apply -var-file="dev.tfvars"
```

Staging:

```bash
terraform workspace select staging

terraform apply -var-file="staging.tfvars"
```

Prod:

```bash
terraform workspace select prod

terraform apply -var-file="prod.tfvars"
```

Verified all environments in AWS console.

## Verification

Verified:

3 VPCs created  
3 EC2 instances created  
3 security groups created  
Different CIDR ranges  
Different instance sizes  

All environments isolated.

------------------------------------------------------------------------

## Terraform Best Practices Learned

File structure separation  
Module reuse  
Workspace usage  
Environment variables  
Tagging strategy  
Naming conventions  
Infrastructure cleanup  


## TerraWeek Learning Summary

| Day | Concepts |
|-----|----------|
| 61 | Terraform basics |
| 62 | Providers and resources |
| 63 | Variables and outputs |
| 64 | State management |
| 65 | Modules |
| 66 | EKS provisioning |
| 67 | Workspaces and multi-environment |

------------------------------------------------------------------------

## Key Learning

This capstone helped me understand how real infrastructure teams manage multiple environments using a single Terraform codebase.

It demonstrated how Infrastructure as Code enables:

Automation  
Reproducibility  
Scalability  
Environment isolation  

------------------------------------------------------------------------

## Practice Repository

I implemented this project inside my Terraform practice repository:

https://github.com/nilamadhabpurohit-aiops/terraform-aws-infrastructure-labs

Day-67 implementation folder:

terraform-aws-infrastructure-labs/day-67-terraweek-capstone/

## Reflection

This was one of the most valuable Terraform exercises because it showed how production infrastructure is actually structured using modules and workspaces.

This completed my TerraWeek journey from Terraform basics to multi-environment infrastructure.


