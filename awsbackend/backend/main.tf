terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket = "xxxbm0409tfstate2"
    key    = "backend/terraform.tfstate"
    region = "cn-north-1"
    encrypt        = true
    dynamodb_table = "tflockid"
  }
}

provider "aws" {
  region     = "cn-north-1"
  shared_credentials_files = ["/home/ubuntu/.aws/credentials"]
  shared_config_files = ["/home/ubuntu/.aws/config"]
}


resource "aws_vpc" "my-vpc" {
  tags = {
    Name = "tf-backend-vpc"
  }
  cidr_block = "31.1.0.0/24"
  assign_generated_ipv6_cidr_block = false
  instance_tenancy = "default"

  enable_dns_hostnames = true
  enable_dns_support = true
}