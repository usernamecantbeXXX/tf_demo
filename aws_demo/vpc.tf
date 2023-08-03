resource "aws_vpc" "my-vpc" {
  tags = {
    Name = "tf-demo"
  }
  cidr_block = var.vpc-cidr
  assign_generated_ipv6_cidr_block = false
  instance_tenancy = "default"

  enable_dns_hostnames = true
  enable_dns_support = true

}