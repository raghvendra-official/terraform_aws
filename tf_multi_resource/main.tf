terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "eu-north-1"
}

locals {
  project = "project-01"
}

resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "${local.project}-vpc"
  }
}

resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = "10.0.${count.index}.0/24"
  count      = 2 # 2 baar run hoga

  tags = {
    Name = "${local.project}-subnet-${count.index}"
  }
}

#Creating 4 EC2 instance
# resource "aws_instance" "main" {
#   ami           = "ami-0189c3f216088b7db"
#   instance_type = "t3.micro"
#   count         = 4
#   #subnet_id = element(aws_subnet.main[*].id,count.index %2)
#   # 0%2
#   # 1%2
#   # 2%2
#   # 3%2
#   subnet_id = element(aws_subnet.main[*].id,count.index %length(aws_subnet.main))


#   tags = {
#     Name = "${local.project}-instance-${count.index}"
#   }
# }

#Create 2 ec2 instances, 1 in each subnet
# resource "aws_instance" "main" {
#   count         = length(var.ec2_config)
#   ami           = var.ec2_config[count.index].ami
#   instance_type = var.ec2_config[count.index].instance_type

#   subnet_id = element(aws_subnet.main[*].id, count.index % length(aws_subnet.main))


#   tags = {
#     Name = "${local.project}-instance-${count.index}"
#   }
# }


#For_each
resource "aws_instance" "main" {
  for_each = var.ec2_map
  # we will get each.key and each.value


  ami           = each.value.ami
  instance_type = each.value.instance_type

  
  subnet_id     = element(aws_subnet.main[*].id, index(keys(var.ec2_map), each.key) % length(aws_subnet.main))


  tags = {
    Name = "${local.project}-instance-${each.key}"
  }
}

output "aws_subnet_id" {
  value = aws_subnet.main[0].id
}
