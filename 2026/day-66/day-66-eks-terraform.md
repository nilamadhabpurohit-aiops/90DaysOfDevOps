# Day 66 -- Provision an EKS Cluster with Terraform Modules

## Objective

Today's task was to provision a production‑style Kubernetes cluster
using Terraform instead of creating it manually. The goal was to
understand how real DevOps teams provision cloud infrastructure in a
repeatable and automated way.

This included:

-   Creating VPC using Terraform registry module
-   Creating AWS EKS cluster
-   Creating managed node group
-   Connecting kubectl
-   Deploying nginx workload
-   Destroying everything safely

------------------------------------------------------------------------

## Project Structure

    day-66-eks-terraform/

    providers.tf
    variables.tf
    terraform.tfvars
    vpc.tf
    eks.tf
    outputs.tf

    k8s/
    nginx-deployment.yaml

------------------------------------------------------------------------

## Key Terraform Configurations

### Provider Configuration

AWS provider pinned to version:

\~\> 5.0

Region used:

us-east-2

------------------------------------------------------------------------

### VPC Module

Used official registry module:

terraform-aws-modules/vpc/aws

Infrastructure created:

VPC\
2 Public Subnets\
2 Private Subnets\
Internet Gateway\
NAT Gateway\
Route Tables

### Why both public and private subnets?

Public subnets: Used for LoadBalancers and internet access.

Private subnets: Used for worker nodes for better security.

### Why subnet tags needed?

Subnet tags help Kubernetes know where to place:

External LoadBalancers → Public subnets

Internal services → Private subnets

------------------------------------------------------------------------

## EKS Cluster Configuration

Used module:

terraform-aws-modules/eks/aws

Cluster created:

EKS Control Plane\
Managed Node Group\
IAM Roles\
Security Groups

Node configuration:

Instance type: t3.medium\
Desired nodes: 2\
Min nodes: 1\
Max nodes: 3

Terraform created around **30+ AWS resources**.

------------------------------------------------------------------------

## Terraform Apply Output

(Screenshot placeholder)

terraform apply completed successfully showing cluster creation.

Example verification:

    Apply complete! Resources: 32 added.

------------------------------------------------------------------------

## Connecting kubectl

Command used:

    aws eks update-kubeconfig --name terraweek-eks --region us-east-2

Verification commands:

    kubectl get nodes

    kubectl get pods -A

    kubectl cluster-info

Result:

2 nodes visible in Ready state.

------------------------------------------------------------------------

## Deploying Nginx Workload

Deployment created using:

k8s/nginx-deployment.yaml

Command:

    kubectl apply -f k8s/nginx-deployment.yaml

Verification:

    kubectl get deployments

    kubectl get pods

    kubectl get svc

Result:

3 nginx pods running.

LoadBalancer service created.

------------------------------------------------------------------------

## Nginx Verification

(Screenshot placeholder)

Verified:

Pods running\
Service created\
External LoadBalancer IP assigned

Accessed nginx welcome page via LoadBalancer URL.

------------------------------------------------------------------------

## Resources Created

Terraform created approximately:

30--35 AWS resources including:

VPC\
Subnets\
NAT Gateway\
Internet Gateway\
IAM roles\
Security groups\
EKS cluster\
Node group

------------------------------------------------------------------------

## Destroy Process

Important cleanup steps followed.

Step 1:

Delete Kubernetes resources:

    kubectl delete -f k8s/nginx-deployment.yaml

Step 2:

Destroy infrastructure:

    terraform destroy

Step 3:

Verified AWS console:

No EKS clusters\
No EC2 nodes\
No VPC\
No NAT Gateway\
No Elastic IP

Environment fully cleaned.

------------------------------------------------------------------------

## Key Learning

From this lab I learned:

How production Kubernetes clusters are created How Terraform registry
modules simplify complex infrastructure How AWS EKS integrates with
Terraform Importance of destroying infrastructure to avoid cost How
Infrastructure as Code improves reproducibility

------------------------------------------------------------------------

## Comparison with Manual Kubernetes Setup

Earlier (Day‑50 Kubernetes week):

Cluster created manually using kind/minikube.

Today:

Cluster created using Terraform.

Advantages of Terraform approach:

Automated\
Repeatable\
Version controlled\
Production ready\
Destroyable

This reflects real DevOps practices.

------------------------------------------------------------------------

## Challenges Faced

EKS creation takes long time (\~15 minutes)

kubectl access required kubeconfig update

Remembering to delete LoadBalancer before destroy

Understanding registry module structure

------------------------------------------------------------------------

## Reflection

This task helped me understand how real infrastructure teams provision
Kubernetes clusters in production. Instead of manual setup, Terraform
allows infrastructure to be version controlled and recreated anytime.

This was one of the most practical tasks in TerraWeek.

------------------------------------------------------------------------

## GitHub Repository:

https://github.com/nilamadhabpurohit-aiops/terraform-aws-infrastructure-labs

------------------------------------------------------------------------
