provider "azurerm" {
  features {}
}

# data "azurerm_subscription" "current" {}  # Read the current subscription info

locals {
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
  name = "test19015357"
}

resource "azurerm_lb" "internal_lb" {
  name                = join("-", [var.lb_name_prefix, local.naming.environment, local.env_location.locations_abbreviation, local.purpose_rg, local.purpose, local.sequence])
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name
  sku                 = var.sku_name

  frontend_ip_configuration {
    name                          = "internal-${local.purpose_rg}-server-feip"
    private_ip_address            = var.private_ip_address
    private_ip_address_allocation = var.private_ip_address_allocation
  }
}