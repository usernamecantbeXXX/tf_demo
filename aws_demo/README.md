

[TF创建AWS VPC](https://juejin.cn/post/7114240460880609287)


[安装tf](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
```
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common

wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg

gpg --no-default-keyring \
--keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
--fingerprint

# 安装

echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt update && sudo apt-get install terraform

```

[安装AWS Cli](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

```
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

aws --version

aws configure  # 输入IAM用户对应的accesskey和secret

aws iam get-user
```
https://developer.hashicorp.com/terraform/tutorials/aws-get-started/aws-build

- "variables.tf"，它将包含关于我们的AWS区域和我们要使用的实例类型的信息。
- gateway.tf文件并在此定义互联网网关和NAT网关
- subnets.tf VPC内部的私有和公共子网
- main.tf 基础设施的定义