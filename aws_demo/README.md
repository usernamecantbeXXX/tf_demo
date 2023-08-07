

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

- main.tf 基础设施的定义
- "variables.tf"，它将包含关于我们的AWS区域和我们要使用的实例类型的信息。 https://support.huaweicloud.com/basics-terraform/terraform_0011.html
- "vpc.tf" 定义vpc
- gateway.tf文件并在此定义互联网网关和NAT网关
- route-table.tf 定义路由表，并关联路由表和nat/igw 网关
- subnets.tf VPC内部的私有和公共子网

## 执行

### terraform init

```
ubuntu@ip-10-1-0-88:~/tf_demo/aws_demo$ terraform init

Initializing the backend...

Initializing provider plugins...
- Finding hashicorp/aws versions matching "~> 5.0"...
- Installing hashicorp/aws v5.11.0...
- Installed hashicorp/aws v5.11.0 (signed by HashiCorp)

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
ubuntu@ip-10-1-0-88:~/tf_demo/aws_demo$ ll
total 44
drwxrwxr-x 3 ubuntu ubuntu 4096 Aug  7 07:33 ./
drwxrwxr-x 8 ubuntu ubuntu 4096 Aug  7 07:31 ../
drwxr-xr-x 3 ubuntu ubuntu 4096 Aug  7 07:33 .terraform/
-rw-r--r-- 1 ubuntu ubuntu 1406 Aug  7 07:33 .terraform.lock.hcl
-rw-rw-r-- 1 ubuntu ubuntu 1577 Aug  7 06:43 README.md
-rw-rw-r-- 1 ubuntu ubuntu  739 Aug  4 02:31 gateway.tf
-rw-rw-r-- 1 ubuntu ubuntu  407 Aug  7 06:16 main.tf
-rw-rw-r-- 1 ubuntu ubuntu  888 Aug  7 01:24 route-table.tf
-rw-rw-r-- 1 ubuntu ubuntu  324 Aug  7 02:10 subnets.tf
-rw-rw-r-- 1 ubuntu ubuntu  281 Aug  7 06:42 variables.tf
-rw-rw-r-- 1 ubuntu ubuntu  240 Aug  3 08:36 vpc.tf

```

### terraform plan

```
ubuntu@ip-10-1-0-88:~/tf_demo/aws_demo$ terraform plan

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_eip.myEIP will be created
  + resource "aws_eip" "myEIP" {
      + allocation_id        = (known after apply)
      + association_id       = (known after apply)
      + carrier_ip           = (known after apply)
      + customer_owned_ip    = (known after apply)
      + domain               = "vpc"
      + id                   = (known after apply)
      + instance             = (known after apply)
      + network_border_group = (known after apply)
      + network_interface    = (known after apply)
      + private_dns          = (known after apply)
      + private_ip           = (known after apply)
      + public_dns           = (known after apply)
      + public_ip            = (known after apply)
      + public_ipv4_pool     = (known after apply)
      + tags_all             = (known after apply)
      + vpc                  = (known after apply)
    }

  # aws_internet_gateway.IGW will be created
  + resource "aws_internet_gateway" "IGW" {
      + arn      = (known after apply)
      + id       = (known after apply)
      + owner_id = (known after apply)
      + tags     = {
          + "Name" = "tf-demo-igw"
        }
      + tags_all = {
          + "Name" = "tf-demo-igw"
        }
      + vpc_id   = (known after apply)
    }

  # aws_nat_gateway.NAT-GW will be created
  + resource "aws_nat_gateway" "NAT-GW" {
      + allocation_id                      = (known after apply)
      + association_id                     = (known after apply)
      + connectivity_type                  = "public"
      + id                                 = (known after apply)
      + network_interface_id               = (known after apply)
      + private_ip                         = (known after apply)
      + public_ip                          = (known after apply)
      + secondary_private_ip_address_count = (known after apply)
      + secondary_private_ip_addresses     = (known after apply)
      + subnet_id                          = (known after apply)
      + tags                               = {
          + "Name" = "tf demo NAT"
        }
      + tags_all                           = {
          + "Name" = "tf demo NAT"
        }
    }

  # aws_route_table.privRT will be created
  + resource "aws_route_table" "privRT" {
      + arn              = (known after apply)
      + id               = (known after apply)
      + owner_id         = (known after apply)
      + propagating_vgws = (known after apply)
      + route            = [
          + {
              + carrier_gateway_id         = ""
              + cidr_block                 = "0.0.0.0/0"
              + core_network_arn           = ""
              + destination_prefix_list_id = ""
              + egress_only_gateway_id     = ""
              + gateway_id                 = ""
              + ipv6_cidr_block            = ""
              + local_gateway_id           = ""
              + nat_gateway_id             = (known after apply)
              + network_interface_id       = ""
              + transit_gateway_id         = ""
              + vpc_endpoint_id            = ""
              + vpc_peering_connection_id  = ""
            },
        ]
      + tags             = {
          + "Name" = "tf-rtb-pri"
        }
      + tags_all         = {
          + "Name" = "tf-rtb-pri"
        }
      + vpc_id           = (known after apply)
    }

  # aws_route_table.publRT will be created
  + resource "aws_route_table" "publRT" {
      + arn              = (known after apply)
      + id               = (known after apply)
      + owner_id         = (known after apply)
      + propagating_vgws = (known after apply)
      + route            = [
          + {
              + carrier_gateway_id         = ""
              + cidr_block                 = "0.0.0.0/0"
              + core_network_arn           = ""
              + destination_prefix_list_id = ""
              + egress_only_gateway_id     = ""
              + gateway_id                 = (known after apply)
              + ipv6_cidr_block            = ""
              + local_gateway_id           = ""
              + nat_gateway_id             = ""
              + network_interface_id       = ""
              + transit_gateway_id         = ""
              + vpc_endpoint_id            = ""
              + vpc_peering_connection_id  = ""
            },
        ]
      + tags             = {
          + "Name" = "tf-rtb-pub"
        }
      + tags_all         = {
          + "Name" = "tf-rtb-pub"
        }
      + vpc_id           = (known after apply)
    }

  # aws_route_table_association.PriRTAss will be created
  + resource "aws_route_table_association" "PriRTAss" {
      + id             = (known after apply)
      + route_table_id = (known after apply)
      + subnet_id      = (known after apply)
    }

  # aws_route_table_association.PubRTAss will be created
  + resource "aws_route_table_association" "PubRTAss" {
      + id             = (known after apply)
      + route_table_id = (known after apply)
      + subnet_id      = (known after apply)
    }

  # aws_subnet.myprivatesubnet will be created
  + resource "aws_subnet" "myprivatesubnet" {
      + arn                                            = (known after apply)
      + assign_ipv6_address_on_creation                = false
      + availability_zone                              = (known after apply)
      + availability_zone_id                           = (known after apply)
      + cidr_block                                     = "11.1.1.0/24"
      + enable_dns64                                   = false
      + enable_resource_name_dns_a_record_on_launch    = false
      + enable_resource_name_dns_aaaa_record_on_launch = false
      + id                                             = (known after apply)
      + ipv6_cidr_block_association_id                 = (known after apply)
      + ipv6_native                                    = false
      + map_public_ip_on_launch                        = false
      + owner_id                                       = (known after apply)
      + private_dns_hostname_type_on_launch            = (known after apply)
      + tags                                           = {
          + "Name" = "tf-demo-private-subnet"
        }
      + tags_all                                       = {
          + "Name" = "tf-demo-private-subnet"
        }
      + vpc_id                                         = (known after apply)
    }

  # aws_subnet.mypublicsubnet will be created
  + resource "aws_subnet" "mypublicsubnet" {
      + arn                                            = (known after apply)
      + assign_ipv6_address_on_creation                = false
      + availability_zone                              = (known after apply)
      + availability_zone_id                           = (known after apply)
      + cidr_block                                     = "11.1.0.0/24"
      + enable_dns64                                   = false
      + enable_resource_name_dns_a_record_on_launch    = false
      + enable_resource_name_dns_aaaa_record_on_launch = false
      + id                                             = (known after apply)
      + ipv6_cidr_block_association_id                 = (known after apply)
      + ipv6_native                                    = false
      + map_public_ip_on_launch                        = false
      + owner_id                                       = (known after apply)
      + private_dns_hostname_type_on_launch            = (known after apply)
      + tags                                           = {
          + "Name" = "tf-demo-public-subnet"
        }
      + tags_all                                       = {
          + "Name" = "tf-demo-public-subnet"
        }
      + vpc_id                                         = (known after apply)
    }

  # aws_vpc.my-vpc will be created
  + resource "aws_vpc" "my-vpc" {
      + arn                                  = (known after apply)
      + assign_generated_ipv6_cidr_block     = false
      + cidr_block                           = "11.1.0.0/16"
      + default_network_acl_id               = (known after apply)
      + default_route_table_id               = (known after apply)
      + default_security_group_id            = (known after apply)
      + dhcp_options_id                      = (known after apply)
      + enable_dns_hostnames                 = true
      + enable_dns_support                   = true
      + enable_network_address_usage_metrics = (known after apply)
      + id                                   = (known after apply)
      + instance_tenancy                     = "default"
      + ipv6_association_id                  = (known after apply)
      + ipv6_cidr_block                      = (known after apply)
      + ipv6_cidr_block_network_border_group = (known after apply)
      + main_route_table_id                  = (known after apply)
      + owner_id                             = (known after apply)
      + tags                                 = {
          + "Name" = "tf-demo"
        }
      + tags_all                             = {
          + "Name" = "tf-demo"
        }
    }

Plan: 10 to add, 0 to change, 0 to destroy.

───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.

```

### terraform apply

```
ubuntu@ip-10-1-0-88:~/tf_demo/aws_demo$ terraform apply

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_eip.myEIP will be created
  + resource "aws_eip" "myEIP" {
      + allocation_id        = (known after apply)
      + association_id       = (known after apply)
      + carrier_ip           = (known after apply)
      + customer_owned_ip    = (known after apply)
      + domain               = "vpc"
      + id                   = (known after apply)
      + instance             = (known after apply)
      + network_border_group = (known after apply)
      + network_interface    = (known after apply)
      + private_dns          = (known after apply)
      + private_ip           = (known after apply)
      + public_dns           = (known after apply)
      + public_ip            = (known after apply)
      + public_ipv4_pool     = (known after apply)
      + tags_all             = (known after apply)
      + vpc                  = (known after apply)
    }

  # aws_internet_gateway.IGW will be created
  + resource "aws_internet_gateway" "IGW" {
      + arn      = (known after apply)
      + id       = (known after apply)
      + owner_id = (known after apply)
      + tags     = {
          + "Name" = "tf-demo-igw"
        }
      + tags_all = {
          + "Name" = "tf-demo-igw"
        }
      + vpc_id   = (known after apply)
    }

  # aws_nat_gateway.NAT-GW will be created
  + resource "aws_nat_gateway" "NAT-GW" {
      + allocation_id                      = (known after apply)
      + association_id                     = (known after apply)
      + connectivity_type                  = "public"
      + id                                 = (known after apply)
      + network_interface_id               = (known after apply)
      + private_ip                         = (known after apply)
      + public_ip                          = (known after apply)
      + secondary_private_ip_address_count = (known after apply)
      + secondary_private_ip_addresses     = (known after apply)
      + subnet_id                          = (known after apply)
      + tags                               = {
          + "Name" = "tf demo NAT"
        }
      + tags_all                           = {
          + "Name" = "tf demo NAT"
        }
    }

  # aws_route_table.privRT will be created
  + resource "aws_route_table" "privRT" {
      + arn              = (known after apply)
      + id               = (known after apply)
      + owner_id         = (known after apply)
      + propagating_vgws = (known after apply)
      + route            = [
          + {
              + carrier_gateway_id         = ""
              + cidr_block                 = "0.0.0.0/0"
              + core_network_arn           = ""
              + destination_prefix_list_id = ""
              + egress_only_gateway_id     = ""
              + gateway_id                 = ""
              + ipv6_cidr_block            = ""
              + local_gateway_id           = ""
              + nat_gateway_id             = (known after apply)
              + network_interface_id       = ""
              + transit_gateway_id         = ""
              + vpc_endpoint_id            = ""
              + vpc_peering_connection_id  = ""
            },
        ]
      + tags             = {
          + "Name" = "tf-rtb-pri"
        }
      + tags_all         = {
          + "Name" = "tf-rtb-pri"
        }
      + vpc_id           = (known after apply)
    }

  # aws_route_table.publRT will be created
  + resource "aws_route_table" "publRT" {
      + arn              = (known after apply)
      + id               = (known after apply)
      + owner_id         = (known after apply)
      + propagating_vgws = (known after apply)
      + route            = [
          + {
              + carrier_gateway_id         = ""
              + cidr_block                 = "0.0.0.0/0"
              + core_network_arn           = ""
              + destination_prefix_list_id = ""
              + egress_only_gateway_id     = ""
              + gateway_id                 = (known after apply)
              + ipv6_cidr_block            = ""
              + local_gateway_id           = ""
              + nat_gateway_id             = ""
              + network_interface_id       = ""
              + transit_gateway_id         = ""
              + vpc_endpoint_id            = ""
              + vpc_peering_connection_id  = ""
            },
        ]
      + tags             = {
          + "Name" = "tf-rtb-pub"
        }
      + tags_all         = {
          + "Name" = "tf-rtb-pub"
        }
      + vpc_id           = (known after apply)
    }

  # aws_route_table_association.PriRTAss will be created
  + resource "aws_route_table_association" "PriRTAss" {
      + id             = (known after apply)
      + route_table_id = (known after apply)
      + subnet_id      = (known after apply)
    }

  # aws_route_table_association.PubRTAss will be created
  + resource "aws_route_table_association" "PubRTAss" {
      + id             = (known after apply)
      + route_table_id = (known after apply)
      + subnet_id      = (known after apply)
    }

  # aws_subnet.myprivatesubnet will be created
  + resource "aws_subnet" "myprivatesubnet" {
      + arn                                            = (known after apply)
      + assign_ipv6_address_on_creation                = false
      + availability_zone                              = (known after apply)
      + availability_zone_id                           = (known after apply)
      + cidr_block                                     = "11.1.1.0/24"
      + enable_dns64                                   = false
      + enable_resource_name_dns_a_record_on_launch    = false
      + enable_resource_name_dns_aaaa_record_on_launch = false
      + id                                             = (known after apply)
      + ipv6_cidr_block_association_id                 = (known after apply)
      + ipv6_native                                    = false
      + map_public_ip_on_launch                        = false
      + owner_id                                       = (known after apply)
      + private_dns_hostname_type_on_launch            = (known after apply)
      + tags                                           = {
          + "Name" = "tf-demo-private-subnet"
        }
      + tags_all                                       = {
          + "Name" = "tf-demo-private-subnet"
        }
      + vpc_id                                         = (known after apply)
    }

  # aws_subnet.mypublicsubnet will be created
  + resource "aws_subnet" "mypublicsubnet" {
      + arn                                            = (known after apply)
      + assign_ipv6_address_on_creation                = false
      + availability_zone                              = (known after apply)
      + availability_zone_id                           = (known after apply)
      + cidr_block                                     = "11.1.0.0/24"
      + enable_dns64                                   = false
      + enable_resource_name_dns_a_record_on_launch    = false
      + enable_resource_name_dns_aaaa_record_on_launch = false
      + id                                             = (known after apply)
      + ipv6_cidr_block_association_id                 = (known after apply)
      + ipv6_native                                    = false
      + map_public_ip_on_launch                        = false
      + owner_id                                       = (known after apply)
      + private_dns_hostname_type_on_launch            = (known after apply)
      + tags                                           = {
          + "Name" = "tf-demo-public-subnet"
        }
      + tags_all                                       = {
          + "Name" = "tf-demo-public-subnet"
        }
      + vpc_id                                         = (known after apply)
    }

  # aws_vpc.my-vpc will be created
  + resource "aws_vpc" "my-vpc" {
      + arn                                  = (known after apply)
      + assign_generated_ipv6_cidr_block     = false
      + cidr_block                           = "11.1.0.0/16"
      + default_network_acl_id               = (known after apply)
      + default_route_table_id               = (known after apply)
      + default_security_group_id            = (known after apply)
      + dhcp_options_id                      = (known after apply)
      + enable_dns_hostnames                 = true
      + enable_dns_support                   = true
      + enable_network_address_usage_metrics = (known after apply)
      + id                                   = (known after apply)
      + instance_tenancy                     = "default"
      + ipv6_association_id                  = (known after apply)
      + ipv6_cidr_block                      = (known after apply)
      + ipv6_cidr_block_network_border_group = (known after apply)
      + main_route_table_id                  = (known after apply)
      + owner_id                             = (known after apply)
      + tags                                 = {
          + "Name" = "tf-demo"
        }
      + tags_all                             = {
          + "Name" = "tf-demo"
        }
    }

Plan: 10 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

aws_eip.myEIP: Creating...
aws_vpc.my-vpc: Creating...
aws_eip.myEIP: Creation complete after 0s [id=eipalloc-0759ee82a00fe9a96]
aws_vpc.my-vpc: Still creating... [10s elapsed]
aws_vpc.my-vpc: Creation complete after 11s [id=vpc-007c863bbdc75ab62]
aws_internet_gateway.IGW: Creating...
aws_subnet.myprivatesubnet: Creating...
aws_subnet.mypublicsubnet: Creating...
aws_internet_gateway.IGW: Creation complete after 0s [id=igw-0c6b906b660fb355b]
aws_route_table.publRT: Creating...
aws_subnet.mypublicsubnet: Creation complete after 1s [id=subnet-00b9b68c25890d856]
aws_nat_gateway.NAT-GW: Creating...
aws_subnet.myprivatesubnet: Creation complete after 1s [id=subnet-00972bbd155da0bd1]
aws_route_table.publRT: Creation complete after 1s [id=rtb-0ccfeaff124174f21]
aws_route_table_association.PubRTAss: Creating...
aws_route_table_association.PubRTAss: Creation complete after 0s [id=rtbassoc-0348bcd1ff17988a7]
aws_nat_gateway.NAT-GW: Still creating... [10s elapsed]
aws_nat_gateway.NAT-GW: Still creating... [20s elapsed]
aws_nat_gateway.NAT-GW: Still creating... [30s elapsed]
aws_nat_gateway.NAT-GW: Still creating... [40s elapsed]
aws_nat_gateway.NAT-GW: Still creating... [50s elapsed]
aws_nat_gateway.NAT-GW: Still creating... [1m0s elapsed]
aws_nat_gateway.NAT-GW: Still creating... [1m10s elapsed]
aws_nat_gateway.NAT-GW: Still creating... [1m20s elapsed]
aws_nat_gateway.NAT-GW: Still creating... [1m30s elapsed]
aws_nat_gateway.NAT-GW: Creation complete after 1m33s [id=nat-073c0c273f0de27ba]
aws_route_table.privRT: Creating...
aws_route_table.privRT: Creation complete after 1s [id=rtb-03ce15db7f8c6ee27]
aws_route_table_association.PriRTAss: Creating...
aws_route_table_association.PriRTAss: Creation complete after 0s [id=rtbassoc-059fe9b573cd9efc7]

Apply complete! Resources: 10 added, 0 changed, 0 destroyed.

ubuntu@ip-10-1-0-88:~/tf_demo/aws_demo$ ll
total 60
drwxrwxr-x 3 ubuntu ubuntu  4096 Aug  7 07:53 ./
drwxrwxr-x 8 ubuntu ubuntu  4096 Aug  7 07:31 ../
drwxr-xr-x 3 ubuntu ubuntu  4096 Aug  7 07:33 .terraform/
-rw-r--r-- 1 ubuntu ubuntu  1406 Aug  7 07:33 .terraform.lock.hcl
-rw-rw-r-- 1 ubuntu ubuntu  1577 Aug  7 06:43 README.md
-rw-rw-r-- 1 ubuntu ubuntu   739 Aug  4 02:31 gateway.tf
-rw-rw-r-- 1 ubuntu ubuntu   407 Aug  7 06:16 main.tf
-rw-rw-r-- 1 ubuntu ubuntu   888 Aug  7 01:24 route-table.tf
-rw-rw-r-- 1 ubuntu ubuntu   324 Aug  7 02:10 subnets.tf
-rw-rw-r-- 1 ubuntu ubuntu 14299 Aug  7 07:53 terraform.tfstate
-rw-rw-r-- 1 ubuntu ubuntu   281 Aug  7 06:42 variables.tf
-rw-rw-r-- 1 ubuntu ubuntu   240 Aug  3 08:36 vpc.tf


```

## 修改 eip name

```
ubuntu@ip-10-1-0-88:~/tf_demo/aws_demo$ terraform apply
aws_vpc.my-vpc: Refreshing state... [id=vpc-007c863bbdc75ab62]
aws_eip.myEIP: Refreshing state... [id=eipalloc-0759ee82a00fe9a96]
aws_internet_gateway.IGW: Refreshing state... [id=igw-0c6b906b660fb355b]
aws_subnet.mypublicsubnet: Refreshing state... [id=subnet-00b9b68c25890d856]
aws_subnet.myprivatesubnet: Refreshing state... [id=subnet-00972bbd155da0bd1]
aws_route_table.publRT: Refreshing state... [id=rtb-0ccfeaff124174f21]
aws_nat_gateway.NAT-GW: Refreshing state... [id=nat-073c0c273f0de27ba]
aws_route_table_association.PubRTAss: Refreshing state... [id=rtbassoc-0348bcd1ff17988a7]
aws_route_table.privRT: Refreshing state... [id=rtb-03ce15db7f8c6ee27]
aws_route_table_association.PriRTAss: Refreshing state... [id=rtbassoc-059fe9b573cd9efc7]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  ~ update in-place

Terraform will perform the following actions:

  # aws_eip.myEIP will be updated in-place
  ~ resource "aws_eip" "myEIP" {
        id                   = "eipalloc-0759ee82a00fe9a96"
      ~ tags                 = {
          + "Name" = "tf-demo-eip"
        }
      ~ tags_all             = {
          + "Name" = "tf-demo-eip"
        }
        # (11 unchanged attributes hidden)
    }

Plan: 0 to add, 1 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

aws_eip.myEIP: Modifying... [id=eipalloc-0759ee82a00fe9a96]
aws_eip.myEIP: Modifications complete after 0s [id=eipalloc-0759ee82a00fe9a96]

Apply complete! Resources: 0 added, 1 changed, 0 destroyed.
ubuntu@ip-10-1-0-88:~/tf_demo/aws_demo$ ll
total 100
drwxrwxr-x 3 ubuntu ubuntu  4096 Aug  7 08:10 ./
drwxrwxr-x 8 ubuntu ubuntu  4096 Aug  7 07:31 ../
drwxr-xr-x 3 ubuntu ubuntu  4096 Aug  7 07:33 .terraform/
-rw-r--r-- 1 ubuntu ubuntu  1406 Aug  7 07:33 .terraform.lock.hcl
-rw-rw-r-- 1 ubuntu ubuntu 26427 Aug  7 08:05 README.md
-rw-rw-r-- 1 ubuntu ubuntu   782 Aug  7 08:05 gateway.tf
-rw-rw-r-- 1 ubuntu ubuntu   407 Aug  7 06:16 main.tf
-rw-rw-r-- 1 ubuntu ubuntu   888 Aug  7 01:24 route-table.tf
-rw-rw-r-- 1 ubuntu ubuntu   324 Aug  7 02:10 subnets.tf
-rw-rw-r-- 1 ubuntu ubuntu 14487 Aug  7 08:10 terraform.tfstate
-rw-rw-r-- 1 ubuntu ubuntu 14299 Aug  7 08:10 terraform.tfstate.backup
-rw-rw-r-- 1 ubuntu ubuntu   281 Aug  7 06:42 variables.tf
-rw-rw-r-- 1 ubuntu ubuntu   240 Aug  3 08:36 vpc.tf

```