terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.100.0" 
    }
    
  }
  # backend "azurerm" {}
}

module "backend_pool" {
  source = "./modules/backend_pool"

  # Required inputs
  nic_names                     = var.nic_names
  location                      = var.location
  environment_map               = var.environment_map
  location_map                  = var.location_map
  purpose                       = var.purpose
  purpose_rg                    = var.purpose_rg
  lb_name_prefix                = var.lb_name_prefix
}