#6. 输出和变量
#编写Terraform配置，使用变量定义VPC的CIDR块，并输出创建的VPC ID和子网ID。

variable "vpc_cidr" {
  description = "VPC的CIDR块"
  type = string
  default = "10.0.0.0/16"
}

resource "aws_vpc" "io_vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "io-vpc"
  }
}

resource "aws_subnet" "io_subnet" {
  vpc_id = aws_vpc.io_vpc.id
  cidr_block = ["10.0.3.0/24", "10.0.4.0/24"]
  availability_zone = "us-east-1a"
  tags = {
    Name = "io-subnet"
  }
}

output "vpc_id" {
  description = "创建的VPC的ID"
  value = aws_vpc.io_vpc.id
}

output "io_subnet_id" {
  description = "创建的私有子网的ID"
  value = aws_subnet.io_subnet.id
}