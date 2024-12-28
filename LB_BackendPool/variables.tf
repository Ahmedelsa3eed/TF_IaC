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

variable "nic_names" {
  type        = string
  description = "List of network interface names to query."
  default = "nic1,nic2"
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