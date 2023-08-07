# Create Internet Gateway resource and attach it to the VPC

resource "aws_internet_gateway" "IGW" {
  vpc_id =  aws_vpc.my-vpc.id # igw是給VPC 然后在通过加进路由表与子网产生关联
  tags = {
    Name = "tf-demo-igw"
  }
}

# Create EIP for the IGW

resource "aws_eip" "myEIP" {
  domain   = "vpc"
}

# Create NAT Gateway resource and attach it to the VPC
resource "aws_nat_gateway" "NAT-GW" {
  tags = {
    Name = "tf demo NAT"
  }
  allocation_id = aws_eip.myEIP.id
  subnet_id = aws_subnet.mypublicsubnet.id

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.IGW] # 要先有igw？
}
