provider "azurerm" {
  features {}
}

data "azurerm_subscription" "current" {}  # Read the current subscription info

locals {
  # get_data = csvdecode(file("../parameters.csv"))
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

  # Extract probe configurations
  protocols = split(",", var.probes_protocols)
  ports = split(",", var.probes_ports)
  intervals = split(",", var.probes_intervals_in_seconds)
  number_of_probes = split(",", var.probes_number_of_probes)
}

data "azurerm_resource_group" "rg" {
  # name     = join("-", [local.naming.bu, local.naming.environment, local.env_location.locations_abbreviation, local.purpose_rg, "rg"])
  name = "lb"
}

data "azurerm_lb" "internal_lb" {
  name                = join("-", [var.lb_name_prefix, local.naming.environment, local.env_location.locations_abbreviation, local.purpose_rg, local.purpose, local.sequence])
  resource_group_name = data.azurerm_resource_group.rg.name
}

# Load Balancer Probe
resource "azurerm_lb_probe" "probe" {
  count               = length(local.protocols)
  name                = "internal-${local.purpose_rg}-server-${local.protocols[count.index]}-probe${count.index}"
  loadbalancer_id     = data.azurerm_lb.internal_lb.id
  protocol            = local.protocols[count.index]
  port                = tonumber(local.ports[count.index])
  interval_in_seconds = tonumber(local.intervals[count.index])
  number_of_probes    = tonumber(local.number_of_probes[count.index])

  lifecycle {
    precondition {
      condition     = tonumber(local.ports[count.index]) >= 1 && tonumber(local.ports[count.index]) <= 65535
      error_message = "The probe port must be between 1 and 65535."
    }
  }
}