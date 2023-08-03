# Create Internet Gateway resource and attach it to the VPC

resource "aws_internet_gateway" "IGW" {
  vpc_id =  aws_vpc.my-vpc.id
  tags = {
    Name = "tf-demo-igw"
  }
}

# Create EIP for the IGW

resource "aws_eip" "myEIP" {
  vpc   = true
}

# Create NAT Gateway resource and attach it to the VPC
resource "aws_nat_gateway" "NAT-GW" {
  allocation_id = aws_eip.myEIP.id
  subnet_id = aws_subnet.mypublicsubnet.id
}
