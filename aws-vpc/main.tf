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


#Create a VPC
resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name : "my-vpc"
  }
}

#p Subnet
resource "aws_subnet" "private-subnet" {
  cidr_block = "10.0.1.0/24"
  vpc_id     = aws_vpc.my-vpc.id
  tags = {
    Name : "private-subnet"
  }
}

#Public Subnet
resource "aws_subnet" "public-subnet" {
  cidr_block = "10.0.2.0/24"
  vpc_id     = aws_vpc.my-vpc.id
  tags = {
    Name : "public-subnet"
  }
}

#Internet Gateway 
resource "aws_internet_gateway" "my-vpc-gw" {
  vpc_id = aws_vpc.my-vpc.id
  tags = {
    Name : "my-vpc-gw"
  }
}

#Route Table
resource "aws_route_table" "my-vpc-route" {
  vpc_id = aws_vpc.my-vpc.id
  tags = {
    Name : "my-vpc"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-vpc-gw.id
  }
}

resource "aws_route_table_association" "public-sub" {
  route_table_id = aws_route_table.my-vpc-route.id
  subnet_id      = aws_subnet.private-subnet.id
}


#Creating EC2
resource "aws_instance" "myserver" {
  ami           = "ami-0189c3f216088b7db"
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.public-subnet.id

  tags = {
    Name = "SampleServer"
  }
}
