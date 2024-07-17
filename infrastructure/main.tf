terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "eu-west-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

# resource "aws_instance" "first-server" {
#   ami           = "ami-0c38b837cd80f13bb"
#   instance_type = "t2.micro"
#
#   tags = {
#     Name = "server"
#   }
# }

# resource "aws_vpc" "first-vpc" {
#   cidr_block = "10.0.0.0/16"
#
#   tags = {
#     Name = "production"
#   }
# }

# resource "aws_subnet" "subnet-1" {
#   vpc_id     = aws_vpc.first-vpc.id
#   cidr_block = "10.0.1.0/24"
#
#   tags = {
#     Name = "prod-subnet"
#   }
# }
