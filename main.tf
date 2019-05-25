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