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

variable "sku_name" {
  description = "SKU name for the Load Balancer."
  type        = string

  validation {
    condition     = contains(["Basic", "Standard"], var.sku_name)
    error_message = "sku_name must be either 'Basic' or 'Standard'."
  }
}

variable "private_ip_address" {
  description = "The private IP address to assign to the load balancer frontend configuration."
  type        = string
}

variable "private_ip_address_allocation" {
  description = "Allocation method for private IP address"
  type        = string
}

variable "lb_name_prefix" {
  description = "Prefix for Load Balancer names"
  type        = string
}

variable "subscription_name" {
  type = string
  default = "test-tech-dev-6425"
}
