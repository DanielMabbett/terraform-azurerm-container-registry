provider "azurerm" {
  features {}
}

resource "random_id" "rg_name" {
  byte_length = 8
}

variable "location" {
  default = "north europe"
}

resource "azurerm_resource_group" "test" {
  name     = "acct-${random_id.rg_name.hex}"
  location = var.location
}

module "container_environment" {
  source = "../.."

  depends_on = [azurerm_resource_group.test]

  name                = "acctestcr"
  resource_group_name = "rg-container-registry-test"
  location            = "north europe"
  sku                 = "premium"
  enable_admin        = false

  webhooks = [
    {
      name        = "mywebhook"
      service_uri = "https://mywebhookreceiver.example/mytag"
      status      = "enabled"
      scope       = "mytag:*"
      actions     = ["push"]
      custom_headers = {
        "Content-Type" = "application/json"
      }
    },
  ]
}
  
output "container_registry_id" {
  value = module.container_environment.container_registry_id
}
