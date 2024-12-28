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

# variable "lb_probe_protocol" {
#   description = "Protocol for Load Balancer probe"
#   type        = string
#   default     = "Tcp"
# }

# variable "lb_probe_port" {
#   description = "Port for Load Balancer probe"
#   type        = number
#   default     = 20005
# }
# variable "lb_probe_interval_in_seconds" {
#   description = "Interval in seconds for Load Balancer probe"
#   type        = number
#   default     = 5
# }

# variable "lb_probe_number_of_probes" {
#   description = "Number of probes for Load Balancer probe"
#   type        = number
#   default     = 3
# }

variable "probes_protocols" {
  type = string
  default     = "Tcp"
}

variable "probes_ports" {
  type = string
  default = "20005"
}

variable "probes_intervals_in_seconds" {
  type = string
  default = "5"
}

variable "probes_number_of_probes" {
  type = string
  default = "3"
}