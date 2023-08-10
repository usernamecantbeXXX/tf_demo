# AWS Backend
[deploying-a-terraform-remote-state-backend-with-aws-s3-and-dynamodb](https://hackernoon.com/deploying-a-terraform-remote-state-backend-with-aws-s3-and-dynamodb)


## AWS S3 来存储 terraform 状态文件 ( terraform.tfstate)

```
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

```

## 用 DynamoDB 表来存储 LockId

```
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
```

https://github.com/nozaq/terraform-aws-remote-state-s3-backend

## 