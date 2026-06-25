terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "cc4ec7f6-6988-4611-a2e4-b0bc19663a6c"
}

resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Basic"
  admin_enabled       = true
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-enterprise-devsecops-prod"
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "enterpriseaks"

  default_node_pool {
    name       = "system"
    node_count = 1
    vm_size    = "Standard_D2as_v7"
  }

  identity {
    type = "SystemAssigned"
  }
}
