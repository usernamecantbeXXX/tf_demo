terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }
}

provider "azurerm" {
  features {}

  subscription_id   = "8fa25555-0029-438a-b47c-ce75f4e64c74"
  tenant_id         = "fa10340e-e325-45a4-a0c8-9f5d1414f5c7"
  client_id         = "0c8be569-887a-4551-bb82-d469ea031dc6"
  client_secret     = "pocu_H~aH94x3JI-DPcFdSrsYin-ZRK3n7"
}

resource "azurerm_resource_group" "example" {
  location = "East Asia"
  name     = "Web_Test_TF_RG"
}
