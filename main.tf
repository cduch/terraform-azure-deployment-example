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
  version = "0.0.6"

  for_each = {for e in var.environments:  e.site_name => environment}

  name           = each.value.site_name
  prefix         = "${var.prefix}${each.value}-"
  suffix         = ""
  admin_username = var.admin_username
  admin_password = var.admin_password
  owner          = var.owner
  location       = var.location
}
