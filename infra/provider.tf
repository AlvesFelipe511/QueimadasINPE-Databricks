
terraform {
  required_version = ">= 1.6.0"

  required_providers {

    # Provider da Azure
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }

    # Provider do Databricks
    databricks = {
      source  = "databricks/databricks"
      version = "~> 1.83"
    }

    # Provider para gerar nomes únicos
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }

  # Armazenamento remoto do Terraform State
  backend "azurerm" {
    resource_group_name  = "rg-fiap-queimadas"
    storage_account_name = "stfiap7019527f3f"
    container_name       = "tfstate"
    key                  = "monitor-queimadas.tfstate"

    # Autenticação pelo Microsoft Entra ID
    use_azuread_auth = true
  }
}

# Configuração do provider Azure
provider "azurerm" {
  features {}
}
