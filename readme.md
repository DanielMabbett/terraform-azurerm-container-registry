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

## Test

Currently Not Available

## Authors

Originally created by [Daniel Mabbett](https://github.com/danielmabbett)

## License

[MIT](LICENSE)
