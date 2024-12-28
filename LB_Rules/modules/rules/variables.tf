variable "environment_map" {
  type = map
  description = "environment"
  default = {
    "dev"  = "dev"
    "uat" = "uat"
    "fof" = "fof"
    "prod" = "prod"
    "qa" = "qa"
  }
}

variable "location_map" {
  type = map
  description = "location_map"
    default = {
    "eastus2"  = "eus2"
    "centralus" = "cus"
    "uksouth" = "uks"
    "ukwest" = "ukw"
    "us"= "eus2"
  }
}

variable "location" {
  type = string
  description = "location"
}

variable "purpose" {
  type        = string
  description = "(Required) The purpose in the format 'role/sequence' (e.g., 'webapp/02')."
  validation {
    condition     = can(regex("^.+/\\d+$", var.purpose))
    error_message = "The purpose must be in the format 'role/sequence', e.g., 'webapp/02'."
  }
}

variable "purpose_rg" {
  description = "Purpose for the resource group"
  type        = string
}

variable "lb_name_prefix" {
  description = "Prefix for Load Balancer names"
  type        = string
}

# variable "lb_rule_https_protocol" {
#   description = "Protocol for HTTPS Load Balancer rule"
#   type        = string
# }

# variable "lb_rule_https_frontend_port" {
#   description = "Frontend port for HTTPS Load Balancer rule"
#   type        = number
# }

# variable "lb_rule_https_backend_port" {
#   description = "Backend port for HTTPS Load Balancer rule"
#   type        = number
# }

# variable "lb_rule_https_idle_timeout_in_minutes" {
#   description = "Idle timeout in minutes for HTTPS Load Balancer rule"
#   type        = number
# }

# variable "lb_rule_https_enable_floating_ip" {
#   description = "Enable floating IP for HTTPS Load Balancer rule"
#   type        = bool
# }

# variable "lb_rule_https_enable_tcp_reset" {
#   description = "Enable TCP reset for HTTPS Load Balancer rule"
#   type        = bool
# }

# variable "lb_rule_https_disable_outbound_snat" {
#   description = "Disable outbound SNAT for HTTPS Load Balancer rule"
#   type        = bool
# }

# variable "lb_rule_tcp_protocol" {
#   description = "Protocol for TCP Load Balancer rule"
#   type        = string
# }

# variable "lb_rule_tcp_frontend_port" {
#   description = "Frontend port for TCP Load Balancer rule"
#   type        = number
# }

# variable "lb_rule_tcp_backend_port" {
#   description = "Backend port for TCP Load Balancer rule"
#   type        = number
# }

# variable "lb_rule_tcp_idle_timeout_in_minutes" {
#   description = "Idle timeout in minutes for TCP Load Balancer rule"
#   type        = number
# }

# variable "lb_rule_tcp_enable_floating_ip" {
#   description = "Enable floating IP for TCP Load Balancer rule"
#   type        = bool
# }

# variable "lb_rule_tcp_enable_tcp_reset" {
#   description = "Enable TCP reset for TCP Load Balancer rule"
#   type        = bool
# }

# variable "lb_rule_tcp_disable_outbound_snat" {
#   description = "Disable outbound SNAT for TCP Load Balancer rule"
#   type        = bool
# }

variable "subscription_name" {
  type = string
  default = "test-tech-dev-6425"
}

variable "rules_protocols" {
  type = string
}

variable "rules_frontend_ports" {
  type = string
}

variable "rules_backend_ports" {
  type = string
}

variable "rules_idle_timeout_in_minutes" {
  type = string
}

variable "rules_enable_floating_ip" {
  type = string
}

variable "rules_enable_tcp_reset" {
  type = string
}

variable "rules_disable_outbound_snat" {
  type = string
}

variable "probe_names" {
  type = string
}
