variable "location" {
  type = string
  description = "location"
  default = "eastus2"
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

variable "purpose" {
  type        = string
  description = "(Required) The purpose in the format 'role/sequence' (e.g., 'webapp/02')."
  validation {
    condition     = can(regex("^.+/\\d+$", var.purpose))
    error_message = "The purpose must be in the format 'role/sequence', e.g., 'webapp/02'."
  }
  default = "weapp/02"
}

variable "purpose_rg" {
  description = "Purpose for the resource group"
  type        = string
  default     = "sgs"
}

variable "lb_name_prefix" {
  description = "Prefix for Load Balancer names"
  type        = string
  default     = "6425"
}


# variable "lb_rule_tcp_protocol" {
#   description = "Protocol for TCP Load Balancer rule"
#   type        = string
#   default     = "Tcp"
# }

# variable "lb_rule_tcp_frontend_port" {
#   description = "Frontend port for TCP Load Balancer rule"
#   type        = number
#   default     = 20000
# }

# variable "lb_rule_tcp_backend_port" {
#   description = "Backend port for TCP Load Balancer rule"
#   type        = number
#   default     = 20000
# }

# variable "lb_rule_tcp_idle_timeout_in_minutes" {
#   description = "Idle timeout in minutes for TCP Load Balancer rule"
#   type        = number
#   default     = 5
# }

# variable "lb_rule_tcp_enable_floating_ip" {
#   description = "Enable floating IP for TCP Load Balancer rule"
#   type        = bool
#   default     = false
# }

# variable "lb_rule_tcp_enable_tcp_reset" {
#   description = "Enable TCP reset for TCP Load Balancer rule"
#   type        = bool
#   default     = false
# }

# variable "lb_rule_tcp_disable_outbound_snat" {
#   description = "Disable outbound SNAT for TCP Load Balancer rule"
#   type        = bool
#   default     = false
# }

# variable "lb_rule_https_protocol" {
#   description = "Protocol for HTTPS Load Balancer rule"
#   type        = string
#   default = "Tcp"
# }

# variable "lb_rule_https_frontend_port" {
#   description = "Frontend port for HTTPS Load Balancer rule"
#   type        = number
#   default     = 443
# }

# variable "lb_rule_https_backend_port" {
#   description = "Backend port for HTTPS Load Balancer rule"
#   type        = number
#   default     = 443
# }

# variable "lb_rule_https_idle_timeout_in_minutes" {
#   description = "Idle timeout in minutes for HTTPS Load Balancer rule"
#   type        = number
#   default     = 5
# }

# variable "lb_rule_https_enable_floating_ip" {
#   description = "Enable floating IP for HTTPS Load Balancer rule"
#   type        = bool
#   default     = false
# }

# variable "lb_rule_https_enable_tcp_reset" {
#   description = "Enable TCP reset for HTTPS Load Balancer rule"
#   type        = bool
#   default     = false
# }

# variable "lb_rule_https_disable_outbound_snat" {
#   description = "Disable outbound SNAT for HTTPS Load Balancer rule"
#   type        = bool
#   default     = false
# }

variable "rules_protocols" {
  type = string
  default = "Tcp,Tcp"
}

variable "rules_frontend_ports" {
  type = string
  default = "20000,443"
}

variable "rules_backend_ports" {
  type = string
  default = "20000,443"
}

variable "rules_idle_timeout_in_minutes" {
  type = string
  default = "5,5"  
}

variable "rules_enable_floating_ip" {
  type = string
  default = "false,false"
}

variable "rules_enable_tcp_reset" {
  type = string
  default = "false,false"
}

variable "rules_disable_outbound_snat" {
  type = string
  default = "false,false"
}

variable "probe_names" {
  description = "Name for Load Balancer probe"
  type        = string
  default     = "internal-sgs-server-Tcp-probe0,internal-sgs-server-Tcp-probe0"
}