# azure-container-registry

A terraform module to provide Azure Container Registries in Azure with the following
characteristics:
* SKU Type
* Location
* Registry Name
* Resource Group Name


## Usage

Simple Azure Containe Registry example:

```hcl
module "test" {
  source                       = "github.com/DanielMabbett/terraform-azure-container-registry/"
  registry_name                = "myregistry"
  registry_sku                 = "basic"
  resource_group_location      = "north europe"
  resource_group_name          = "rg-containers-01"
}
```

## Terraform Azurerm Container Registry 

This module seeks to create an Azure Container Registry for the user.

## Usage
```hcl-terraform
module "terraform-azurerm-container-registry"{
  source   = "https://github.com/DanielMabbett/terraform-azure-container-registry.git"
  resource_group_name     = "rg-registry-dev"
  location = "westeurope"
  registry_georeplications = "westeurope"
}
```

## Authors

Originally created by [Daniel Mabbett](https://github.com/danielmabbett)

## License

[MIT](LICENSE)
