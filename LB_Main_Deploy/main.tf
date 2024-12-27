terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.100.0" 
    }
    
  }
  # backend "azurerm" {}
}

module "lb" {
  source = "./modules/load_balancer"
  
  location                      = var.location
  purpose                       = var.purpose
  purpose_rg                    = var.purpose_rg
  sku_name                      = var.sku_name
  private_ip_address            = var.private_ip_address
  private_ip_address_allocation = var.private_ip_address_allocation
  lb_name_prefix                = var.lb_name_prefix
}