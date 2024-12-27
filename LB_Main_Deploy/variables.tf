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

variable "subnetname" {
  type = string
  # lz<app>-<env>-<region>-<purpose>-snet-<nn>
  default = "6425-dev-eus2-lb-snet-02"
#  sensitive = true
}

# vnet address_space
variable "address_space" {
  type = string
  description = "The address space that is used the virtual network."
  default = "10.0.0.0/16"
}

variable "subnet_address_prefixes" {
  type = string
  description = ""
  default = "10.0.1.0/24"
}

variable "purpose_rg" {
  description = "Purpose for the resource group"
  type        = string
  default     = "sgs"
}

variable "sku_name" {
  description = "SKU name for the Load Balancer."
  type        = string
  default     = "Standard"
}

variable "lb_name_prefix" {
  description = "Prefix for Load Balancer names"
  type        = string
  default     = "6425"
}

variable "private_ip_address" {
  description = "The private IP address to assign to the load balancer frontend configuration."
  type        = string
  default     = "10.0.0.1"
}

variable "private_ip_address_allocation" {
  description = "Allocation method for private IP address"
  type        = string
  default     = "Static"
}
