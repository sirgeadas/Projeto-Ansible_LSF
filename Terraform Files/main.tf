# Criação da Vnet ------------------------------

resource "azurerm_virtual_network" "grupo2-weu-prod-vnet" {
name = "Grupo2-WEU-PROD-VNET"
location = var.Prod
resource_group_name = var.Default_RG_Prod
address_space       = var.Grupo2-weu-prod-vnet
}


resource "azurerm_virtual_network" "grupo2-neu-dr-vnet" {
name = "Grupo2-NEU-DR-VNET"
location = var.Disrec
resource_group_name = var.Default_RG_Disrec
address_space       = var.Grupo2-neu-dr-vnet
}

# Criação da Subnet ----------------------------

resource "azurerm_subnet" "grupo2-new-prod-subnet" {
  name                 = "Grupo2-WEU-PROD-SU"
  resource_group_name  = var.Default_RG_Prod
  virtual_network_name = azurerm_virtual_network.grupo2-weu-prod-vnet.name
  address_prefixes     = var.Grupo2-weu-prod-subnet
}

resource "azurerm_subnet" "grupo2-new-dr-subnet" {
  name                 = "Grupo2-NEU-DR-SUBNET"
  resource_group_name  = var.Default_RG_Disrec
  virtual_network_name = azurerm_virtual_network.grupo2-neu-dr-vnet.name
  address_prefixes     = var.Grupo2-neu-dr-subnet
}
