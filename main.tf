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

resource "azurerm_resource_group" "rg" {
  name     = "${var.resource_group_name}"
  location = "${var.resource_group_location}"
}

resource "azurerm_container_registry" "acr" {
  count                    =  "${var.registry_georeplications == "" ? 1 : 0}"
  name                     = "${var.registry_name}"
  resource_group_name      = "${azurerm_resource_group.rg.name}"
  location                 = "${azurerm_resource_group.rg.location}"
  sku                      = "${var.registry_sku}"
  admin_enabled            = "${var.registry_enable_admin}"
  # georeplication_locations = "${var.registry_georeplications}"
}
resource "azurerm_container_registry" "acr-gr" {
  count                    =  "${var.registry_georeplications != "" ? 1 : 0}"
  name                     = "${var.registry_name}"
  resource_group_name      = "${azurerm_resource_group.rg.name}"
  location                 = "${azurerm_resource_group.rg.location}"
  sku                      = "${var.registry_sku}"
  admin_enabled            = "${var.registry_enable_admin}"
  georeplication_locations = "${var.registry_georeplications}"
}