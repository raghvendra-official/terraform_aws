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

#fetching data from yml file
locals {
  users_data = yamldecode(file("./user.yml")).users

  user_role_pair = flatten([for user in local.users_data : [for role in user.roles : {
    username = user.username
    role     = role
  }]])
}

output "output" {
  value = local.users_data[*].username
}

#Creating users
resource "aws_iam_user" "users" {
  for_each = toset(local.users_data[*].username)
  name     = each.value
}

#Password creation
resource "aws_iam_user_login_profile" "profile" {
  for_each        = aws_iam_user.users
  user            = each.value.name
  password_length = 12

  # password is saved in terraform.tfstate

  lifecycle {
    ignore_changes = [
      password_length,
      password_reset_required,
      pgp_key,
    ]
  }

}

#Adding policy to users
resource "aws_iam_user_policy_attachment" "name" {
    for_each = {
      for pair in local.user_role_pair :
      "${pair.username}-${pair.role}" => pair
    }
    #baburao-EC2Access = {username = baburao, role = ec2access}
    #baburao-s3readonly = {}
    user = aws_iam_user.users[each.value.username].name
    policy_arn = "arn:aws:iam::aws:policy/${each.value.role}"
}
