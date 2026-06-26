# Complete VPC Example

This example shows how to use the local VPC Terraform module to create:

- One VPC
- Two public subnets
- One private subnet
- An Internet Gateway
- A public route table for the public subnets

## Example Configuration

The example creates a VPC in the `eu-north-1` AWS region.

```hcl
provider "aws" {
  region = "eu-north-1"
}

module "vpc" {
  source = "../../module/vpc"

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

## Important Path Note

When running Terraform from the `examples/complete` directory, the module source should point back to the project module directory:

```hcl
source = "../../module/vpc"
```

If you move this example to the project root, use:

```hcl
source = "./module/vpc"
```

## Outputs

This example returns:

| Output | Description |
| --- | --- |
| `vpc` | ID of the created VPC. |
| `public_subnet` | Map of public subnet IDs and Availability Zones. |
| `private_subnet` | Map of private subnet IDs and Availability Zones. |

## How to Run

From this directory:

```bash
cd examples/complete
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
```

To remove the resources:

```bash
terraform destroy
```

## AWS Authentication

Before running this example, make sure your AWS credentials are configured. You can use any standard Terraform-supported AWS authentication method, such as:

- AWS CLI profile
- Environment variables
- IAM role credentials

## Notes

- Public subnets are identified by `public = true`.
- The private subnet does not create a NAT Gateway.
- All resources are created in `eu-north-1`.
- Make sure the selected Availability Zones are available in your AWS account.
