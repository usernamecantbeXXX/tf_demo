#5. 使用模块
#创建一个Terraform模块，用于创建基本的VPC架构（VPC、子网、路由表等）。然后在主配置中调用该模块。

provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "./modules/vpc"
  vpc_cidr = "10.0.0.0/16"
  vpc_name = "my-vpc"
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
  availability_zones  = ["us-east-1a", "us-east-1b"]
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

/**
.
├── main.tf
└── modules
    └── vpc
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
4. 模块功能说明
VPC：创建一个VPC，并启用DNS支持和主机名。
子网：
创建多个公有子网和私有子网，分布在指定的可用区。
公有子网配置为自动分配公网IP。
路由表：
公有路由表配置默认路由到互联网网关。
私有路由表仅用于内部流量。
模块化设计：通过输入变量动态配置VPC、子网和可用区，便于复用。
*/