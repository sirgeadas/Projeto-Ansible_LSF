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
  name                 = "GRUPO2-WEU-PROD-SU"
  resource_group_name  = var.Default_RG_Prod
  virtual_network_name = azurerm_virtual_network.grupo2-weu-prod-vnet.name
  address_prefixes     = var.Grupo2-weu-prod-subnet
}

resource "azurerm_subnet" "grupo2-neu-dr-subnet" {
  name                 = "GRUPO2-NEU-DR-SUBNET"
  resource_group_name  = var.Default_RG_Disrec
  virtual_network_name = azurerm_virtual_network.grupo2-neu-dr-vnet.name
  address_prefixes     = var.Grupo2-neu-dr-subnet
}

#====================================================================#
#                    Criação das máquinas Virtuais:                  #
# ===================================================================#

#-------------------- Criação da máquina Apache PROD ----------------#

resource "azurerm_network_interface" "APACHE-PROD-NIC" {
  name                = "Apache-PROD-NIC"
  location            = var.Prod
  resource_group_name = var.Default_RG_Prod

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.grupo2-weu-prod-subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address = "10.0.0.10"
  }
}

resource "azurerm_virtual_machine" "APACHE-PROD" {
  name                  = var.Grupo2-weu-prod-vm-apache
  location              = var.Prod
  resource_group_name   = var.Default_RG_Prod
  network_interface_ids = [azurerm_network_interface.APACHE-PROD-NIC.id]
  vm_size               = "Standard_B1s"

storage_os_disk {
  name              = "Apache-Prod-Disk"
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
      key_data = file("~/.ssh/Apache-Prod-key.pub")
    }
  }
}
#-------------------- Criação da máquina Apache Disaster Recovery  ----------------#

resource "azurerm_network_interface" "APACHE-DR-NIC" {
  name                = "Apache-DR-NIC"
  location            = var.Disrec
  resource_group_name = var.Default_RG_Disrec

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.grupo2-neu-dr-subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address = "10.1.0.10"
  }
}

resource "azurerm_virtual_machine" "APACHE-DR" {
  name                  = var.Grupo2-neu-dr-vm-apache
  location              = var.Disrec
  resource_group_name   = var.Default_RG_Disrec
  network_interface_ids = [azurerm_network_interface.APACHE-DR-NIC.id]
  vm_size               = "Standard_B1s"

  storage_os_disk {
    name              = "Ubuntu-DR-Disk"
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
      key_data = file("~/.ssh/Apache-DR-key.pub")
    }
  }

}
