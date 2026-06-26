# Terraform AWS Examples

This repository contains Terraform examples and practice projects for provisioning AWS resources. It includes basic AWS resources, VPC and EC2 examples, S3 hosting, backend configuration, variables, data sources, import examples, and a reusable VPC module.

## Repository Structure

| Path | Description |
| --- | --- |
| `aws-ec2/` | Creates an AWS EC2 instance with variables and outputs. |
| `aws-s3/` | Creates and configures an AWS S3 bucket. |
| `aws-vpc/` | Creates a basic AWS VPC. |
| `aws-vpc-ec2-nginx/` | Provisions a VPC, security groups, EC2 instance, and Nginx setup. |
| `aws_IAM_Management/` | Manages AWS IAM users and related configuration. |
| `proj-static-website/` | Static website hosting example using Terraform and S3. |
| `tf-backend/` | Terraform backend configuration example. |
| `tf-data-source/` | Demonstrates Terraform data sources. |
| `tf-import-s3/` | Example for importing existing AWS S3 resources into Terraform state. |
| `tf-module-vpc/` | Uses public Terraform modules for VPC and EC2 resources. |
| `tf-own-module-vpc/` | Custom reusable VPC module with an example configuration. |
| `tf-operators-exps/` | Terraform operators and expression examples. |
| `tf-variables/` | Terraform variable examples. |
| `tf_functions/` | Terraform function examples. |
| `tf_multi_resource/` | Demonstrates multiple Terraform resources. |

## Prerequisites

- Terraform installed locally
- AWS CLI installed and configured
- An AWS account with permissions to create the resources used in each example

Configure AWS credentials before running Terraform:

```bash
aws configure
```

Or use environment variables:

```bash
export AWS_ACCESS_KEY_ID="your-access-key"
export AWS_SECRET_ACCESS_KEY="your-secret-key"
export AWS_DEFAULT_REGION="ap-south-1"
```

## How to Use

Open the folder for the example you want to run:

```bash
cd aws-ec2
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
```

To remove created AWS resources:

```bash
terraform destroy
```

## Important Notes

- Do not commit `.env`, `*.tfvars`, Terraform state files, or plan files to GitHub.
- Terraform state can contain sensitive values. Store it securely using a remote backend for real projects.
- Review the generated plan before applying any changes.
- AWS resources may create charges. Destroy resources when they are no longer needed.

## Suggested GitHub Setup

If this folder is not already a Git repository, initialize it before pushing:

```bash
git init
git add .
git commit -m "Add Terraform AWS examples"
git branch -M main
git remote add origin https://github.com/raghvendra-official/terraform_aws.git
git push -u origin main
```
