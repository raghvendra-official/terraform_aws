terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  backend "s3" {
       bucket = "demo-bucket-93d928f5dad02532" 
       key = "backend.tfstate"
       region = "eu-north-1"
    }
}

# Configure the AWS Provider
provider "aws" {
  region = "eu-north-1"
}

# Create a VPC
resource "aws_instance" "myserver" {
  ami = "ami-0189c3f216088b7db"
  instance_type = "t3.micro"

  tags = {
    Name = "SampleServer"
  }
}

