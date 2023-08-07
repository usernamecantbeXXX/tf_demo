variable "aws_region" {
  description = "The AWS region to create the VPC in."
  default   = "cn-north-1"
}

variable "vpc-cidr" {
  default = "11.1.0.0/16"
}

variable "pubsubcidr" {
  default = "11.1.0.0/24"
}

variable "prisubcidr" {
  default = "11.1.1.0/24"
}
