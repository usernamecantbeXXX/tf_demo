

terraform {
  backend "remote" {
    organization = "my-org"  # 替换为你的Terraform Cloud组织名称
    workspaces {
      name = "my-workspace"  # 替换为你的工作区名称
    }
  }
}