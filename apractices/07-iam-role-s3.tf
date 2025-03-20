#7. IAM角色和策略
#创建一个IAM角色，并附加一个策略，以允许EC2实例访问S3存储桶。编写Terraform配置来实现这一点

##
#完整配置
#1. 定义IAM角色：创建一个IAM角色，允许EC2实例承担该角色。
#2. 定义IAM策略：创建一个策略，允许访问指定的S3存储桶。
#3. 将策略附加到角色：将创建的策略附加到IAM角色。

# 创建IAM角色
resource "aws_iam_role" "ec2_s3_role" {
  name               = "ec2_s3_access_role"
  assume_role_policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
  tags = {
    Name = "EC2-S3-Access-Role"
  }
}

resource "aws_iam_policy" "s3_access_policy" {
  name        = "s3_access_policy"
  description = "允许EC2实例访问S3存储桶"
  policy      = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Effect   = "Allow"
        Resource = [
          "arn:aws:s3:::my-s3-bucket", # 替换为你的S3存储桶名称
          "arn:aws:s3:::my-s3-bucket/*"         # 允许访问存储桶中的所有对象
        ]
      }
    ]
  })
}

# 将策略附加到角色
resource "aws_iam_policy_attachment" "attach_s3_policy" {
  policy_arn = aws_iam_policy.s3_access_policy.arn
  role = aws_iam_role.ec2_s3_role.name
}

# 创建实例配置文件(确保EC2实例启动时附加了创建的实例配置文件)
resource "aws_iam_instance_profile" "ec2_s3_profile" {
  name = "ec2_s3_instance_profile"
  role = aws_iam_role.ec2_s3_role.name
}

/**
配置说明
IAM角色：

使用 aws_iam_role 资源创建一个IAM角色。
assume_role_policy 定义允许EC2服务承担该角色。
IAM策略：

使用 aws_iam_policy 资源创建一个策略。
策略允许 s3:GetObject 和 s3:ListBucket 操作，访问指定的S3存储桶。
策略附加：

使用 aws_iam_role_policy_attachment 资源将策略附加到角色。
实例配置文件：

使用 aws_iam_instance_profile 资源创建一个实例配置文件，用于将角色附加到EC2实例。
*/