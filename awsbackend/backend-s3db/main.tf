terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region     = "cn-north-1"
  shared_credentials_files = ["/home/ubuntu/.aws/credentials"]
  shared_config_files = ["/home/ubuntu/.aws/config"]
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "xxxbm0409tfstate2"

  tags = {
    Name        = "tf backend bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "terraform_state_lock" {
  name           = "tflockid"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}