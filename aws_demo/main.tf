terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# 使用AWS CLI配置文件
provider "aws" {
  region                = var.aws_region
  shared_credentials_files = ["/home/ubuntu/.aws/credentials"]
  shared_config_files = ["/home/ubuntu/.aws/config"]
}
