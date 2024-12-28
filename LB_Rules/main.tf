terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.100.0" 
    }
    
  }
  # backend "azurerm" {}
}

module "azure_load_balancer_rules" {
  source = "./modules/rules"

  # Required inputs
  location                      = var.location
  environment_map               = var.environment_map
  location_map                  = var.location_map
  purpose                       = var.purpose
  purpose_rg                    = var.purpose_rg
  lb_name_prefix                = var.lb_name_prefix

  # Rule configurations
  rules_protocols               = var.rules_protocols
  rules_frontend_ports          = var.rules_frontend_ports
  rules_backend_ports           = var.rules_backend_ports
  rules_idle_timeout_in_minutes = var.rules_idle_timeout_in_minutes
  rules_enable_floating_ip      = var.rules_enable_floating_ip
  rules_enable_tcp_reset        = var.rules_enable_tcp_reset
  rules_disable_outbound_snat   = var.rules_disable_outbound_snat
  probe_names                   = var.probe_names

  # TCP rule configurations
  # lb_rule_tcp_protocol                   = var.lb_rule_tcp_protocol
  # lb_rule_tcp_frontend_port              = var.lb_rule_tcp_frontend_port
  # lb_rule_tcp_backend_port               = var.lb_rule_tcp_backend_port
  # lb_rule_tcp_idle_timeout_in_minutes    = var.lb_rule_tcp_idle_timeout_in_minutes
  # lb_rule_tcp_enable_floating_ip         = var.lb_rule_tcp_enable_floating_ip
  # lb_rule_tcp_enable_tcp_reset           = var.lb_rule_tcp_enable_tcp_reset
  # lb_rule_tcp_disable_outbound_snat      = var.lb_rule_tcp_disable_outbound_snat

  # # HTTPS rule configurations
  # lb_rule_https_protocol                 = var.lb_rule_https_protocol
  # lb_rule_https_frontend_port            = var.lb_rule_https_frontend_port
  # lb_rule_https_backend_port             = var.lb_rule_https_backend_port
  # lb_rule_https_idle_timeout_in_minutes  = var.lb_rule_https_idle_timeout_in_minutes
  # lb_rule_https_enable_floating_ip       = var.lb_rule_https_enable_floating_ip
  # lb_rule_https_enable_tcp_reset         = var.lb_rule_https_enable_tcp_reset
  # lb_rule_https_disable_outbound_snat    = var.lb_rule_https_disable_outbound_snat
}

