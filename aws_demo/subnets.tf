resource "aws_subnet" "myprivatesubnet" {
  vpc_id =  aws_vpc.my-vpc.id
  cidr_block = var.prisubcidr
}

resource "aws_subnet" "mypublicsubnet" {
  vpc_id =  aws_vpc.my-vpc.id
  cidr_block = var.pubsubcidr
}
