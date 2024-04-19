#====================================================================#
#                    Infraestrutura de Rede:                         #
# ===================================================================#


#-------------------- Criação da Vnet -------------------------------#

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
 
#------------------- Criação da Subnet ------------------------------#

resource "azurerm_subnet" "grupo2-weu-prod-subnet" {
  name                 = "GRUPO2-WEU-PROD-SUBNET"
  resource_group_name  = var.Default_RG_Prod
  virtual_network_name = azurerm_virtual_network.grupo2-weu-prod-vnet.name
  address_prefixes     = var.Grupo2-weu-prod-subnet
}

resource "azurerm_subnet" "grupo2-weu-prod-ansible-subnet" {
  name                 = "GRUPO2-WEU-PROD-ANSIBLE-SUBNET"
  resource_group_name  = var.Default_RG_Prod
  virtual_network_name = azurerm_virtual_network.grupo2-weu-prod-vnet.name
  address_prefixes     = var.Grupo2-weu-prod-ansible-subnet
}

# -------

resource "azurerm_subnet" "grupo2-neu-dr-subnet" {
  name                 = "GRUPO2-NEU-DR-SUBNET"
  resource_group_name  = var.Default_RG_Disrec
  virtual_network_name = azurerm_virtual_network.grupo2-neu-dr-vnet.name
  address_prefixes     = var.Grupo2-neu-dr-subnet
}

resource "azurerm_subnet" "grupo2-neu-dr-ansible-subnet" {
  name                 = "GRUPO2-NEU-DR-ANISBLE-SUBNET"
  resource_group_name  = var.Default_RG_Disrec
  virtual_network_name = azurerm_virtual_network.grupo2-neu-dr-vnet.name
  address_prefixes     = var.Grupo2-neu-dr-ansible-subnet
}


#====================================================================#
#                    Criação das máquinas Virtuais:                  #
# ===================================================================#


################### Máquinas Produção ###################


#-------------------- Criação da máquina WEBSERVER PROD ----------------#

resource "azurerm_network_interface" "WEBSERVER-PROD-NIC" {
  name                = "WEBSERVER-PROD-NIC"
  location            = var.Prod
  resource_group_name = var.Default_RG_Prod

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.grupo2-weu-prod-subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address = "10.0.2.10"
  }
}

resource "azurerm_virtual_machine" "WEBSERVER-PROD" {
  name                  = var.Grupo2-weu-prod-vm-WEBSERVER
  location              = var.Prod
  resource_group_name   = var.Default_RG_Prod
  network_interface_ids = [azurerm_network_interface.WEBSERVER-PROD-NIC.id]
  vm_size               = "Standard_B1s"

storage_os_disk {
  name              = "WEBSERVER-Prod-Disk"
  caching           = "ReadWrite"
  create_option     = "FromImage"
  managed_disk_type = "StandardSSD_LRS"
  disk_size_gb      = 30
}

  delete_os_disk_on_termination    = false
  delete_data_disks_on_termination = false

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  os_profile {
    computer_name  = "hostname"
    admin_username = "ansible"
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path     = "/home/ansible/.ssh/authorized_keys"
      key_data = file("~/.ssh/WebServerPROD.pub")
    }
  }
}

################### Máquinas Disaster Recovery ###################


#-------------------- Criação da máquina WEBSERVER Disaster Recovery  ----------------#

resource "azurerm_network_interface" "WEBSERVER-DR-NIC" {
  name                = "WEBSERVER-DR-NIC"
  location            = var.Disrec
  resource_group_name = var.Default_RG_Disrec

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.grupo2-neu-dr-subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address = "10.1.2.10"
  }
}

resource "azurerm_virtual_machine" "WEBSERVER-DR" {
  name                  = var.Grupo2-neu-dr-vm-WEBSERVER
  location              = var.Disrec
  resource_group_name   = var.Default_RG_Disrec
  network_interface_ids = [azurerm_network_interface.WEBSERVER-DR-NIC.id]
  vm_size               = "Standard_B1s"

  storage_os_disk {
    name              = "WEBSERVER-DR-Disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "StandardSSD_LRS"
    disk_size_gb      = 30
  }

  delete_os_disk_on_termination    = false
  delete_data_disks_on_termination = false

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  os_profile {
    computer_name  = "hostname"
    admin_username = "ansible"
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path     = "/home/ansible/.ssh/authorized_keys"
      key_data = file("~/.ssh/WebServerDR.pub")
    }
  }

}
