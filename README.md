# terraform-azurerm-container-registry

![terratest](https://github.com/DanielMabbett/terraform-azurerm-container-registry/workflows/terratest/badge.svg)

## Create a Container Registry Environment with Terraform

This Terraform module deploys a Container Registry with additional optional image definitions.

## Usage

```hcl
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


```

## Test

### Configurations

- [Configure Terraform for Azure](https://docs.microsoft.com/en-us/azure/virtual-machines/linux/terraform-install-configure)

We provide 2 ways to build, run, and test the module on a local development machine.  [Native (Mac/Linux)](#native-maclinux) or [Docker](#docker).

### Native (Mac/Linux)

#### Prerequisites

- [Ruby **(~> 2.7)**](https://www.ruby-lang.org/en/downloads/)
- [Bundler **(~> 1.15)**](https://bundler.io/)
- [Terraform **(~> 0.13.0)**](https://www.terraform.io/downloads.html)
- [Golang **(~> 1.14.3)**](https://golang.org/dl/)

#### Environment setup

We provide simple script to quickly set up module development environment:

> Note: This will not deploy the latest versions for setup. This is coming soon however.

```sh
curl -sSL https://raw.githubusercontent.com/Azure/terramodtest/master/tool/env_setup.sh | sudo bash
```

#### Run test

Then simply run it in local shell:

```sh
cd $GOPATH/src/{directory_name}/
bundle install
rake build
rake full
```

### Docker

We provide a Dockerfile to build a new image based `FROM` the `microsoft/terraform-test` Docker hub image which adds additional tools / packages specific for this module (see Custom Image section).  Alternatively use only the `microsoft/terraform-test` Docker hub image [by using these instructions](https://github.com/Azure/terraform-test).

#### Prerequisites

- [Docker](https://www.docker.com/community-edition#/download)

#### Custom Image

This builds the custom image:

```sh
docker build --build-arg BUILD_ARM_SUBSCRIPTION_ID=$ARM_SUBSCRIPTION_ID --build-arg BUILD_ARM_CLIENT_ID=$ARM_CLIENT_ID --build-arg BUILD_ARM_CLIENT_SECRET=$ARM_CLIENT_SECRET --build-arg BUILD_ARM_TENANT_ID=$ARM_TENANT_ID -t azure-network .
```

This runs the build and unit tests:

```sh
docker run --rm azure-network /bin/bash -c "bundle install && rake build"
```

This runs the end to end tests:

```sh
docker run --rm azure-network /bin/bash -c "bundle install && rake e2e"
```

This runs the full tests:

```sh
docker run --rm azure-network /bin/bash -c "bundle install && rake full"
```

## Contributing 

We welcome contributors!

## Authors

Originally created by [Daniel Mabbett](http://github.com/danielmabbett)

## License

[MIT](LICENSE)
