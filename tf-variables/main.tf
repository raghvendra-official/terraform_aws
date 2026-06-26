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

# Local values or variable
locals {
  owner = "ABC"
  name = "MyServer"

}

resource "aws_instance" "myserver" {
  ami           = "ami-0189c3f216088b7db"
  instance_type = var.aws_instance_type

  root_block_device {
    delete_on_termination = true
    volume_size = var.root_volume_size
    volume_type = var.ec2_config.v_type
  }

  tags = merge(var.additional_tags,{
    Name = local.name
  })
}