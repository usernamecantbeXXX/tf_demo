#4. 负载均衡器
#创建一个内部负载均衡器，并将其与多个EC2实例关联。
#确保负载均衡器的安全组允许来自内部网络的流量。

# 创建负载均衡安全组
resource "aws_security_group" "alb-sg" {
  name = "alb-security-group"
  description = "Allow internal traffice to ALB"
  vpc_id = aws_vpc.my_vpc.id
  ingress {
    protocol = "tcp"
    from_port = 80
    to_port = 80
    cidr_blocks = ["10.0.0.0/16"]
  }
  egress {
    protocol = "-1"
    from_port = 0
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "alb-security-group"
  }
}

# 创建内部负载均衡器
resource "aws_alb" "internal_alb" {
  name = "internal-alb"
  internal = true # 设置为内部负载均衡器
  load_balance_type = "application"
  security_groups = [aws_security_group.alb-sg.id]  # 关联安全组
  subnets = [aws_subnet.private_subnet.id] # 关联私有子网
  tags = {
    Name = "internal-alb"
  }
}

# 创建目标组
resource "aws_lb_target_group" "alb_tg" {
  name = "alb-target-group"
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.my_vpc.id
  health_check {
    path = "/"
    protocol = "HTTP"
    port = "traffic-port" # 健康检查将使用与目标组中定义的流量端口相同的端口
    healthy_threshold = 3
    unhealthy_threshold = 3
    timeout = 5
    interval = 30
  }
  tags = {
    Name = "alb-target-group"
  }
}

# 创建监听器
resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_alb.internal_alb.arn
  port = 80
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.alb_tg.arn
  }
}

# 将EC2 注册到目标组
resource "aws_lb_target_group_attachment" "ec2_attachment" {
  count = length(aws_instance.my_ec2) # 假设有多EC2实例
  target_group_arn = aws_lb_target_group.alb_tg.arn
  target_id = aws_instance.my_ec2[count.index].id
  port = 80
}

/*
代码说明：
内部负载均衡器：
创建了一个内部应用负载均衡器（ALB），internal = true 确保它仅在VPC内部可用。
负载均衡器位于私有子网中，并关联了安全组。
负载均衡器安全组：
允许来自VPC内（10.0.0.0/16）的HTTP流量（端口80）。
允许所有出站流量。
目标组：
创建了一个目标组，用于将流量路由到EC2实例。
配置了健康检查，确保只有健康的实例接收流量。
监听器：
创建了一个HTTP监听器，将流量转发到目标组。
EC2实例注册：
将多个EC2实例注册到目标组，确保负载均衡器可以将流量分发到这些实例。*/
