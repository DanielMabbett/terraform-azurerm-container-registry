variable "resource_group_name" {
  default = "myRegistryRG"
  description = "The name for the resource group where the Azure Container Registry will reside."
}

variable "resource_group_location" {
  default = "north europe"
  description = "The location for the resource group where the Azure Container Registry will reside."
}

variable "registry_name" {
  default = "myRegistry"
  description = "The name for the Azure Container Registry"
}

variable "registry_sku" {
  default = "premium"
  description = "The SKU for the Azure Container Registry"
}

variable "registry_enable_admin" {
  default = false
  description = "The SKU for the Azure Container Registry"
}

variable "registry_georeplications" {
  default = ""
  description = "The SKU for the Azure Container Registry"
}