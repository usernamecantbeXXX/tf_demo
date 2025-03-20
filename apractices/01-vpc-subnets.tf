#	1. 创建VPC和子网
#     编写Terraform代码来创建一个VPC，包含两个公共子网和一个私有子网。
#     确保为每个子网配置适当的CIDR块。

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~>5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# 创建VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "my-vpc"
  }
}

# 创建公共子网1
resource "aws_subnet" "public_subnet_1" {
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet-1"
  }
}

# 创建公共子网2
resource "aws_subnet" "public_subnet_2" {
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet-2"
  }
}

# 创建私有子网
resource "aws_subnet" "private_subnet" {
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-east-1c"
  tags = {
    Name = "private_subnet"
  }
}

# 创建互联网网关
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "igw"
  }
}

# 创建公共路由表
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "public-route-table"
  }
}

# 将公共子网关联到公共路由表
resource "aws_route_table_association" "public_subnet_1_association" {
  route_table_id = aws_route_table.public_route_table.id
  subnet_id = aws_subnet.public_subnet_1.id
}

resource "aws_route_table_association" "public_subnet_2_association" {
  route_table_id = aws_route_table.public_route_table.id
  subnet_id = aws_subnet.public_subnet_2.id
}

/**
VPC：创建了一个CIDR块为 10.0.0.0/16 的VPC。
公共子网：创建了两个公共子网，CIDR块分别为 10.0.1.0/24 和 10.0.2.0/24，并启用了自动分配公网IP。
私有子网：创建了一个私有子网，CIDR块为 10.0.3.0/24。
互联网网关：为VPC创建了一个互联网网关，用于公共子网的互联网访问。
路由表：创建了一个公共路由表，并将两个公共子网关联到该路由表，确保它们可以通过互联网网关访问外部网络
*/
