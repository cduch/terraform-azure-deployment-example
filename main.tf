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


module "vm-example-module" {
  source  = "app.terraform.io/carstenduch/vm-example-module/azure"
  version = "0.0.1"

  for_each = var.location

  prefix         = var.prefix
  suffix         = "-${each.value}"
  admin_username = var.admin_username
  admin_password = var.admin_password
  owner          = var.owner
  location       = each.value

}
