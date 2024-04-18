terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }
}

provider "azurerm" {
 # alias = "Tiberna"
 # subscription_id = "c34f0752-7151-4ee1-ac5c-6369a3e67318"
  skip_provider_registration = true
  features {}
}
