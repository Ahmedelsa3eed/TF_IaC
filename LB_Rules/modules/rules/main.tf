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

  # Read and decode the CSV file where each row represents a rule
  rules_data = csvdecode(file("${path.root}/rules.csv"))
  
  # Extract values from CSV into lists
  protocols = [for rule in local.rules_data : rule.protocol]
  frontend_ports = [for rule in local.rules_data : rule.frontend_port]
  backend_ports = [for rule in local.rules_data : rule.backend_port]
  idle_timeouts = [for rule in local.rules_data : rule.idle_timeout]
  enable_floating_ips = [for rule in local.rules_data : rule.enable_floating_ip]
  enable_tcp_resets = [for rule in local.rules_data : rule.enable_tcp_reset]
  disable_outbound_snats = [for rule in local.rules_data : rule.disable_outbound_snat]
  probes = [for rule in local.rules_data : rule.probe_name]
}

data "azurerm_resource_group" "rg" {
  # name     = join("-", [local.naming.bu, local.naming.environment, local.env_location.locations_abbreviation, local.purpose_rg, "rg"])
  name = "lb"
}

data "azurerm_lb" "internal_lb" {
  name                = join("-", [var.lb_name_prefix, local.naming.environment, local.env_location.locations_abbreviation, local.purpose_rg, local.purpose, local.sequence])
  resource_group_name = data.azurerm_resource_group.rg.name
}

data "azurerm_lb_backend_address_pool" "internal_lb_bepool" {
  name            = "internal-${local.purpose_rg}-server-bepool"
  loadbalancer_id = data.azurerm_lb.internal_lb.id
}

resource "azurerm_lb_rule" "rule" {
  count                          = length(local.rules_data)
  loadbalancer_id                = data.azurerm_lb.internal_lb.id
  name                           = "internal-${local.purpose_rg}-server-${local.protocols[count.index]}-lbrule-${count.index}"
  protocol                       = local.protocols[count.index]
  frontend_port                  = local.frontend_ports[count.index]
  backend_port                   = local.backend_ports[count.index]
  frontend_ip_configuration_name = data.azurerm_lb.internal_lb.frontend_ip_configuration[0].name
  backend_address_pool_ids       = [data.azurerm_lb_backend_address_pool.internal_lb_bepool.id]
  probe_id                       = "/subscriptions/${data.azurerm_subscription.current.subscription_id}/resourceGroups/${data.azurerm_resource_group.rg.name}/providers/Microsoft.Network/loadBalancers/${data.azurerm_lb.internal_lb.name}/probes/${local.probes[count.index]}"
  idle_timeout_in_minutes        = local.idle_timeouts[count.index]
  enable_floating_ip             = local.enable_floating_ips[count.index]
  enable_tcp_reset               = local.enable_tcp_resets[count.index]
  disable_outbound_snat          = local.disable_outbound_snats[count.index]
}