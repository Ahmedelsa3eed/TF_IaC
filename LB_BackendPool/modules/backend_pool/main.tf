provider "azurerm" {
  features {}
}

# data "azurerm_subscription" "current" {}  # Read the current subscription info

locals {
  nic_names = split(",", var.nic_names)
  # Define data for naming standards
  naming = {
    bu                = lower(split("-", var.subscription_name)[1])
    environment       = lower(split("-", var.subscription_name)[2])
    locations         = var.location
    nn                = lower(split("-", var.subscription_name)[3])
    subscription_name = var.subscription_name
  }
  env_location = {
    env_abbreviation       = var.environment_map[local.naming.environment]
    locations_abbreviation = var.location_map[local.naming.locations]
  }
  # Split purpose_full into purpose and sequence based on "/"
  purpose_parts = split("/", var.purpose)
  # Extract purpose and sequence from purpose_parts
  purpose  = length(local.purpose_parts) > 0 ? local.purpose_parts[0] : null
  sequence = length(local.purpose_parts) > 1 ? local.purpose_parts[1] : null
  purpose_rg = var.purpose_rg
}

data "azurerm_resource_group" "rg" {
  # name     = join("-", [local.naming.bu, local.naming.environment, local.env_location.locations_abbreviation, local.purpose_rg, "rg"])
  name = "lb"
}

data "azurerm_lb" "internal_lb" {
  name                = join("-", [var.lb_name_prefix, local.naming.environment, local.env_location.locations_abbreviation, local.purpose_rg, local.purpose, local.sequence])
  resource_group_name = data.azurerm_resource_group.rg.name
}

# Define Backend Address Pool
resource "azurerm_lb_backend_address_pool" "internal_lb_bepool" {
  loadbalancer_id = data.azurerm_lb.internal_lb.id
  name            = "internal-${local.purpose_rg}-server-bepool"
}

data "azurerm_network_interface" "nic" {
  for_each = toset(local.nic_names)

  name                = each.value
  resource_group_name = data.azurerm_resource_group.rg.name
}

# Associate NICs with backend pool
resource "azurerm_network_interface_backend_address_pool_association" "lb_backend_association" {
  for_each = {
    for nic_name in local.nic_names : nic_name => data.azurerm_network_interface.nic[nic_name]
    if length(data.azurerm_network_interface.nic[nic_name].ip_configuration) > 0
  }

  network_interface_id    = each.value.id
  ip_configuration_name   = each.value.ip_configuration[0].name
  backend_address_pool_id = azurerm_lb_backend_address_pool.internal_lb_bepool.id

  lifecycle {
    precondition {
      condition     = length(each.value.ip_configuration) > 0
      error_message = "Network interface ${each.key} must have at least one IP configuration."
    }
  }
}