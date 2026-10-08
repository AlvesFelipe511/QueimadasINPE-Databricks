
terraform {
  required_version = ">= 1.6.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }

    databricks = {
      source  = "databricks/databricks"
      version = "~> 1.83"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-fiap-queimadas"
    storage_account_name = "stfiap7019527f3f"
    container_name       = "tfstate"
    key                  = "monitor-queimadas.tfstate"

    use_azuread_auth = true
    use_cli          = true
  }
}

provider "azurerm" {
  features {}
}
