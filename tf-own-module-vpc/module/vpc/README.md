# AWS VPC Terraform Module

This Terraform module creates an AWS VPC with public and private subnets. If at least one subnet is marked as public, the module also creates an Internet Gateway, a public route table, and route table associations for the public subnets.

## Resources Created

- AWS VPC
- AWS subnets
- Internet Gateway, only when public subnets exist
- Public route table with `0.0.0.0/0` route through the Internet Gateway
- Route table associations for public subnets

## Requirements

| Name | Version |
| --- | --- |
| Terraform | `>= 1.0` |
| AWS Provider | `>= 5.30` |

## Usage

```hcl
provider "aws" {
  region = "eu-north-1"
}

module "vpc" {
  source = "./module/vpc"

  vpc_config = {
    cidr_block = "10.0.0.0/16"
    name       = "my-test-vpc"
  }

  subnet_config = {
    public_subnet-1 = {
      cidr_block = "10.0.0.0/24"
      az         = "eu-north-1a"
      public     = true
    }

    public_subnet-2 = {
      cidr_block = "10.0.2.0/24"
      az         = "eu-north-1a"
      public     = true
    }

    private_subnet = {
      cidr_block = "10.0.1.0/24"
      az         = "eu-north-1b"
    }
  }
}
```

## Inputs

| Name | Description | Type | Required |
| --- | --- | --- | --- |
| `vpc_config` | VPC configuration, including CIDR block and name tag. | `object({ cidr_block = string, name = string })` | Yes |
| `subnet_config` | Map of subnet definitions. The map key is used as the subnet `Name` tag. | `map(object({ cidr_block = string, az = string, public = optional(bool, false) }))` | Yes |

### `vpc_config`

```hcl
vpc_config = {
  cidr_block = "10.0.0.0/16"
  name       = "my-vpc"
}
```

### `subnet_config`

```hcl
subnet_config = {
  public_subnet = {
    cidr_block = "10.0.1.0/24"
    az         = "eu-north-1a"
    public     = true
  }

  private_subnet = {
    cidr_block = "10.0.2.0/24"
    az         = "eu-north-1b"
  }
}
```

Set `public = true` for public subnets. When `public` is omitted, the subnet is treated as private.

## Outputs

| Name | Description |
| --- | --- |
| `vpc_id` | ID of the created VPC. |
| `public_subnets` | Map of public subnet details, including subnet ID and Availability Zone. |
| `private_subnets` | Map of private subnet details, including subnet ID and Availability Zone. |

Example output shape:

```hcl
public_subnets = {
  public_subnet = {
    subnet_id = "subnet-xxxxxxxx"
    az        = "eu-north-1a"
  }
}
```

## Validation

The module validates CIDR block formatting for both the VPC and subnets using Terraform's `cidrnetmask` function.

## Running Terraform

From the root of this project:

```bash
terraform init
terraform fmt -recursive
terraform validate
terraform plan
terraform apply
```

To destroy the created AWS resources:

```bash
terraform destroy
```

## Notes

- Public subnet routing is created only when one or more subnets have `public = true`.
- Private subnets are created without NAT Gateway or private route table resources.
- The module does not enable DNS settings explicitly, so AWS provider defaults apply.
