terraform {
#
#  cloud {
#    workspaces {
#      name = "learn-terraform-eks"
#    }
#  }
  backend "s3" {
    bucket = "xxxbm0409tfstate2"
    key    = "tf_pj_dev/terraform.tfstate"
    region = "cn-north-1"
    encrypt        = true
    dynamodb_table = "tflockid"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.7.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.5.1"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0.4"
    }

    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = "~> 2.3.2"
    }
  }

  required_version = "~> 1.3"
}
