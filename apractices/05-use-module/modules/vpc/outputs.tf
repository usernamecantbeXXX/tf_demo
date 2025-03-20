output "vpc_id" {
  description = "VPC的ID"
  value = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "公有子网的ID列表"
  value = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "私有子网的ID列表"
  value = aws_subnet.private[*].id
}