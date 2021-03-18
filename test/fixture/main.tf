provider "azurerm" {
  features {}
}

resource "random_id" "rg_name" {
  byte_length = 8
}

variable "location" {
  default = "north europe"
}

module "container_environment" {
  source = "../.."

  name                = "acctacr${random_id.rg_name.hex}"
  resource_group_name = "rg-acct-acr-${random_id.rg_name.hex}"
  location            = "North Europe"
  sku                 = "Premium"
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

  tags = {
    Purpose     = "Testing"
    Environment = "Test"
  }
}

output "container_registry_id" {
  value = module.container_environment.container_registry_id
}
