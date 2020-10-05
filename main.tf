resource "azurerm_resource_group" "group" {
  name     = var.resource_group_name
  location = var.location
}

locals {
  standard_tags = {
    Component   = "user-service"
    Environment = "production"
  }
}

resource "azurerm_container_registry" "registry" {
  name                = var.name
  resource_group_name = azurerm_resource_group.group.name
  location            = azurerm_resource_group.group.location
  sku                 = var.sku
  admin_enabled       = var.enable_admin
  // georeplication_locations = "${var.georeplications}"

}

resource "azurerm_container_registry_webhook" "webhooks" {
  for_each = { for object in var.webhooks : object.name => object }

  depends_on = [azurerm_container_registry.registry]

  name                = each.value.name
  resource_group_name = azurerm_resource_group.group.name
  registry_name       = azurerm_container_registry.registry.name
  location            = azurerm_resource_group.group.location

  service_uri = each.value.service_uri # "https://mywebhookreceiver.example/mytag"
  status      = each.value.status      # "enabled"
  scope       = each.value.scope       # "mytag:*"
  actions     = each.value.actions     # ["push"]
  # custom_headers = {
  #   "Content-Type" = "application/json"
  # }
}