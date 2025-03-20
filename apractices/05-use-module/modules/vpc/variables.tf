variable "vpc_cidr" {
  description = "VPC的CIDR块"
  type = string
}

variable "vpc_name" {
  description = "VPC的名称"
  type = string
}

variable "public_subnet_cidrs" {
  description = "公有子网的CIDR块"
  type = list(string)
}

variable "private_subnet_cidrs" {
  description = "私有子网的CIDR块"
  type = list(string)
}

variable "availability_zones" {
  description = "可用区列表"
  type = list(string)
}