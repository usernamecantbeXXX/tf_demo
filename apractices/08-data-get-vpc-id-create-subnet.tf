#8. 使用Terraform数据源
#使用Terraform数据源获取现有的VPC ID，并在此VPC中创建新的子网。

data "aws_vpc" "existing_vpc" {
  filter {
    name = "tag:Name" # 根据标签过滤VPC
    values = ["my-existing-vpc"] # 替换为你的VPC名称标签
  }
}

# 在现有的VPC中新建子网
resource "aws_subnet" "new_subnet" {
  vpc_id = data.aws_vpc.existing_vpc.id # 使用数据源获取的VPC ID
  cidr_block = "10.0.10.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "new-subnet"
  }
}

# 输出VPC ID 和新的子网ID
output "vpc_id_08" {
  description = "现有的VPC ID"
  value = data.aws_vpc.existing_vpc.id
}

output "new_subnet_id" {
  description = "新的子网 ID"
  value = aws_subnet.new_subnet.id
}