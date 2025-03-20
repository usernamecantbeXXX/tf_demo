#3. RDS实例
#编写Terraform配置来创建一个Amazon RDS实例（如MySQL），并确保它位于私有子网中。
#设置适当的参数，如存储类型、实例类型和连接信息。

# 创建RDS子网组
resource "aws_db_subnet_group" "rds_subnet_group" {
  name = "rds-subnet-group"
  subnet_ids = [aws_subnet.private_subnet.id]
  tags = {
    Name = "rds-subnet-group"
  }
}
# 创建RDS安全组
resource "aws_security_group" "rds-sg" {
  name = "rds-security-group"
  description = "Allow MySQL inbound traffic"
  vpc_id = aws_vpc.my_vpc.id # 使用之前创建的VPC ID
  ingress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = ["10.0.0.0/16"] # 允许VPC内的流量访问MySQL
  }
  egress {
    protocol = "-1"
    from_port = 0
    to_port = 0
    cidr_blocks = ["0.0.0.0./0"] # 允许所有出站流量
  }
  tags = {
    Name = "rds-security-group"
  }
}

# 创建RDS实例（Mysql）
resource "aws_db_instance" "mysql_rds" {
  identifier = "mysql-rds-instance"
  engine = "mysql"
  engine_version = "8.0" # MySQL版本
  instance_class = "db.t3.micro" # 实例类型
  allocated_storage = 20 # 存储大小（GB）
  storage_type = "gp2" # 存储类型（通用SSD）
  username = "admin" # 主用户名
  password = "yourpassword" # 主用户密码
  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name # 关联子网组
  vpc_security_group_ids = [aws_security_group.rds-sg.id] # 关联安全组
  skip_final_snapshot = true # 删除实例时不创建最终快照
  publicly_accessible = fasle # 禁止公网访问
  tags = {
    Name = "mysql-rds-instance"
  }
}

/*
代码说明：
RDS子网组：
创建了一个RDS子网组，将RDS实例部署在之前创建的私有子网中。
RDS安全组：
创建了一个安全组，允许VPC内的流量访问MySQL端口（3306）。
RDS实例：
创建了一个MySQL RDS实例，指定了引擎版本、实例类型、存储类型和大小。
设置了主用户名和密码，确保实例位于私有子网中，并禁止公网访问。
关联了子网组和安全组。*/
