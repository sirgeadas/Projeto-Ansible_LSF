terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
#  alias = "Tiberna"
#  subscription_id = "c34f0752-7151-4ee1-ac5c-6369a3e67318"
  features {}
}