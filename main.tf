terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.26"
    }
  }
  required_version = ">=0.14.9"
}

provider "azurerm" {
  features {}
}

module "dc-deployment" {
  source         = "./modules/dc-deployment"
  count          = var.sitecount
  prefix         = var.prefix
  suffix         = "-${count.index}"
  admin_username = var.admin_username
  admin_password = var.admin_password
  owner          = var.owner
  location       = length(var.location) - 1 >= count.index ? var.location[count.index] : var.location[0]
}
