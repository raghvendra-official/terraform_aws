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

data "aws_ami" "name" {
  most_recent = true
  owners = [ "amazon" ]
}

output "aws_ami" {
    value = data.aws_ami.name.id
}

#Security groups
data "aws_security_group" "name" {
  tags = {
    mywebserver = "http"
  }
}

output "security_group" {
    value = data.aws_security_group.name.id
}

#VPC ID
data "aws_vpc" "name" {
  tags = {
    ENV = "PROD"
    Name = "my-vpc"
  }
}

output "vpc_id" {
    value = data.aws_vpc.name.id
}


#Ava. zones
data "aws_availability_zones" "names" {
  state = "available"
}

output "aws_zones" {
    value = data.aws_availability_zones.names
}


#To get the current account details
data "aws_caller_identity" "name" {
  
}

output "caller_info" {
    value = data.aws_caller_identity.name
}


#EC2 - eas
resource "aws_instance" "myserver" {
  ami           = data.aws_ami.name.id
  instance_type = "t3.micro"

  tags = {
    Name = "SampleServer"
  }
}
