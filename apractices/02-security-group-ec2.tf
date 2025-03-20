#2. EC2实例和安全组
#创建一个EC2实例，并为其配置一个安全组，允许HTTP (80) 和 SSH (22) 的入站流量。
#实例应位于之前创建的公共子网中。

#provider "aws" {
#  region = "us-east-1"
#}

resource "aws_security_group" "ec2_sg" {
  name = "ec2-security-group"
  description = "Allow HTTP and SSH inbound traffic"
  vpc_id = aws_vpc.my_vpc.id #使用之前创建的VPC
  ingress {
    protocol = "tcp"
    from_port = 80
    to_port = 80
    cidr_blocks = [0.0.0.0/0] # 允许所有IP访问HTTP
  }

  ingress {
    protocol = "tcp"
    from_port = "22"
    to_port = "22"
    cidr_blocks = [0.0.0.0/0] # 允许所有IP访问SSH
  }

  egress {
    protocol = "-1"
    from_port = 0
    to_port = 0
    cidr_blocks = [0.0.0.0/0] # 允许所有出站流量

  }

  tags = {
    Name = "ec2-security-group"
  }
}

resource "aws_instance" "my_ec2" {
  instance_type = "t2.micro"
  ami = "ami-0c02fb55956c7d316"
  subnet_id = aws_subnet.public_subnet_1 # 使用之前创建的公共子网ID
  security_groups = [aws_security_group.ec2_sg.name] # 关联安全组

  tags = {
    Name = "my-ec2-instance"
  }
}

/*
代码说明：
安全组：
创建了一个安全组，允许来自任何IP地址的HTTP (80) 和 SSH (22) 入站流量。
允许所有出站流量（egress 规则）。
EC2实例：
使用指定的AMI（Amazon Machine Image）和实例类型（如 t2.micro）创建EC2实例。
将实例部署在之前创建的公共子网中。
关联了刚刚创建的安全组。
*/
