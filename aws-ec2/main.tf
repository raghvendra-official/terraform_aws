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
  region = var.region
}

# Create a VPC
resource "aws_instance" "myserver" {
  ami           = "ami-0189c3f216088b7db"
  instance_type = "t3.micro"

  tags = {
    Name = "SampleServer"
  }
}

