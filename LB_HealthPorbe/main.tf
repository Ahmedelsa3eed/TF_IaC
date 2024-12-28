terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.100.0" 
    }
    
  }
  # backend "azurerm" {}
}

module "azure_load_balancer_health_probes" {
  source = "./modules/health_probe"

  # Required inputs
  location                      = var.location
  environment_map               = var.environment_map
  location_map                  = var.location_map
  purpose                       = var.purpose
  purpose_rg                    = var.purpose_rg
  lb_name_prefix                = var.lb_name_prefix

  # Probe configurations
  probes_protocols               = var.probes_protocols
  probes_ports                   = var.probes_ports
  probes_intervals_in_seconds    = var.probes_intervals_in_seconds
  probes_number_of_probes        = var.probes_number_of_probes
}

