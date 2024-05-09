#====================================================================#
#                    Infraestrutura de Rede:                         #
# ===================================================================#


# Criação das Vnet's -------------------------------#

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
 
# Criação das Subnet's ------------------------------#

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
#                         Máquinas Virtuais:                         #
# ===================================================================#


############################# Máquinas Produção ##############################


# Criação da máquina ANSIBLE PROD ----------------#

resource "azurerm_public_ip" "grupo2-weu-prod-ansible-pip" { 

  name                = "Grupo2-WEU-PROD-ANSIBLE-PIP" 

  location            = var.Prod 

  resource_group_name = var.Default_RG_Prod

  allocation_method   = "Static" 

} 

resource "azurerm_network_interface" "ANSIBLE-PROD-NIC" {
  name                = "ANSIBLE-PROD-NIC"
  location            = var.Prod
  resource_group_name = var.Default_RG_Prod

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.grupo2-weu-prod-ansible-subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.1.111"
    public_ip_address_id          = azurerm_public_ip.grupo2-weu-prod-ansible-pip.id
  }
}

resource "azurerm_virtual_machine" "ANSIBLE-PROD" {
  name                  = var.Grupo2-weu-prod-vm-ANSIBLE
  location              = var.Prod
  resource_group_name   = var.Default_RG_Prod
  network_interface_ids = [azurerm_network_interface.ANSIBLE-PROD-NIC.id]
  vm_size               = "Standard_B2s" 

storage_os_disk {
  name              = "ANSIBLE-Prod-Disk"
  caching           = "ReadWrite"
  create_option     = "FromImage"
  managed_disk_type = "StandardSSD_LRS"
  disk_size_gb      = 30
}

  delete_os_disk_on_termination    = true#false
  delete_data_disks_on_termination = true#false

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  os_profile {
    computer_name  = var.Grupo2-weu-prod-vm-ANSIBLE-HOSTNAME
    admin_username = "controlnodeprod"
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path     = "/home/controlnodeprod/.ssh/authorized_keys"
      key_data = file("~/.ssh/ControlNodePROD.pub")
    }
  }
}

# Criação da máquina WEBSERVER PROD ----------------#

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
    computer_name  = var.Grupo2-weu-prod-vm-WEBSERVER-HOSTNAME
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

# Criação da máquina DATABASE SERVER PROD ----------------#

resource "azurerm_network_interface" "DATABASESERVER-PROD-NIC" {
  name                = "DATABASE-PROD-NIC"
  location            = var.Prod
  resource_group_name = var.Default_RG_Prod

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.grupo2-weu-prod-subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address = "10.0.2.15"
  }
}


resource "azurerm_virtual_machine" "DATABASESERVER-PROD" {
  name                  = var.Grupo2-weu-prod-vm-DATABASESERVER
  location              = var.Prod
  resource_group_name   = var.Default_RG_Prod
  network_interface_ids = [azurerm_network_interface.DATABASESERVER-PROD-NIC.id]
  vm_size               = "Standard_B1s"

storage_os_disk {
  name              = "DATABASESERVER-Prod-Disk"
  caching           = "ReadWrite"
  create_option     = "FromImage"
  managed_disk_type = "StandardSSD_LRS"
  disk_size_gb      = 30
}

  delete_os_disk_on_termination    = true#false
  delete_data_disks_on_termination = true#false

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  os_profile {
    computer_name  = var.Grupo2-weu-prod-vm-DATABASESERVER-HOSTNAME
    admin_username = "ansible"
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path     = "/home/ansible/.ssh/authorized_keys"
      key_data = file("~/.ssh/DatabaseServerPROD.pub")
    }
  }
}

# Criação da máquina WINDOWS SERVER PROD ----------------#

variable "password_Windows-PROD" {
  description = "The password associated with the administrative account of the Windows Server PROD."
  sensitive   = true
}

resource "azurerm_public_ip" "grupo2-weu-prod-windows-pip" {
  name                = "Grupo2-WEU-PROD-WINDOWS-PIP"
  location            = var.Prod
  resource_group_name = var.Default_RG_Prod
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "WINDOWS-PROD-NIC" {
  name                = "WINDOWS-PROD-NIC"
  location            = var.Prod
  resource_group_name = var.Default_RG_Prod

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.grupo2-weu-prod-subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.2.20"
    public_ip_address_id         = azurerm_public_ip.grupo2-weu-prod-windows-pip.id
  }
}
resource "azurerm_virtual_machine" "WINDOWS-PROD" {
  name                  = var.Grupo2-weu-prod-vm-WINDOWSSERVER
  location              = var.Prod
  resource_group_name   = var.Default_RG_Prod
  network_interface_ids = [azurerm_network_interface.WINDOWS-PROD-NIC.id]
  vm_size               = "Standard_B2s"

  storage_os_disk {
    name              = "WINDOWS-PROD-Disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "StandardSSD_LRS"
    disk_size_gb      = 127
  }

  delete_os_disk_on_termination    = true#false
  delete_data_disks_on_termination = true#false

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-datacenter-azure-edition"
    version   = "latest"
  }

  os_profile {
    computer_name  = var.Grupo2-weu-prod-vm-WINDOWSSERVER-HOSTNAME
    admin_username = "WinPROD"
    admin_password = var.password_Windows-PROD
  }
  os_profile_windows_config {
    provision_vm_agent = true
  }
}


######################## Máquinas Disaster Recovery ###########################

# Criação da máquina ANSIBLE DR ----------------#

resource "azurerm_public_ip" "grupo2-neu-dr-ansible-pip" { 

  name                = "Grupo2-NEU-DR-ANSIBLE-PIP" 

  location            = var.Disrec

  resource_group_name = var.Default_RG_Disrec

  allocation_method   = "Static" 

} 

resource "azurerm_network_interface" "ANSIBLE-DR-NIC" {
  name                = "ANSIBLE-DR-NIC"
  location            = var.Disrec
  resource_group_name = var.Default_RG_Disrec

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.grupo2-neu-dr-ansible-subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.1.1.111"
    public_ip_address_id          = azurerm_public_ip.grupo2-neu-dr-ansible-pip.id
}
}

resource "azurerm_virtual_machine" "ANSIBLE-DR" {
  name                  = var.Grupo2-neu-dr-vm-ANSIBLE
  location              = var.Disrec
  resource_group_name   = var.Default_RG_Disrec
  network_interface_ids = [azurerm_network_interface.ANSIBLE-DR-NIC.id]
  vm_size               = "Standard_B2s"

storage_os_disk {
  name              = "ANSIBLE-DR-Disk"
  caching           = "ReadWrite"
  create_option     = "FromImage"
  managed_disk_type = "StandardSSD_LRS"
  disk_size_gb      = 30
}

  delete_os_disk_on_termination    = true#false
  delete_data_disks_on_termination = true#false

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  os_profile {
    computer_name  = var.Grupo2-neu-dr-vm-ANSIBLE-HOSTNAME
    admin_username = "controlnodedr"
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path     = "/home/controlnodedr/.ssh/authorized_keys"
      key_data = file("~/.ssh/ControlNodeDR.pub")
    }
  }
}


# Criação da máquina WEBSERVER DR ----------------#

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

  delete_os_disk_on_termination    = true#false
  delete_data_disks_on_termination = true#false

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  os_profile {
    computer_name  = var.Grupo2-neu-dr-vm-WEBSERVER-HOSTNAME
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


# Criação da máquina DATABASE SERVER DR ----------------#

resource "azurerm_network_interface" "DATABASESERVER-DR-NIC" {
  name                = "DATABASE-DR-NIC"
  location            = var.Disrec
  resource_group_name = var.Default_RG_Disrec

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.grupo2-neu-dr-subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address = "10.1.2.15"
  }
}


resource "azurerm_virtual_machine" "DATABASESERVER-DR" {
  name                  = var.Grupo2-neu-dr-vm-DATABASESERVER
  location              = var.Disrec
  resource_group_name   = var.Default_RG_Disrec
  network_interface_ids = [azurerm_network_interface.DATABASESERVER-DR-NIC.id]
  vm_size               = "Standard_B1s"

storage_os_disk {
  name              = "DATABASESERVER-DR-Disk"
  caching           = "ReadWrite"
  create_option     = "FromImage"
  managed_disk_type = "StandardSSD_LRS"
  disk_size_gb      = 30
}

  delete_os_disk_on_termination    = true#false
  delete_data_disks_on_termination = true#false

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  os_profile {
    computer_name  = var.Grupo2-neu-dr-vm-DATABASESERVER-HOSTNAME
    admin_username = "ansible"
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path     = "/home/ansible/.ssh/authorized_keys"
      key_data = file("~/.ssh/DatabaseServerDR.pub")
    }
  }
}

# Criação da máquina WINDOWS SERVER DR ----------------#

variable "password_Windows-DR" {
  description = "The password associated with the administrative account of the Windows Server DR."
  sensitive   = true
}

resource "azurerm_public_ip" "grupo2-neu-dr-windows-pip" {
  name                = "Grupo2-NEU-DR-WINDOWS-PIP"
  location            = var.Disrec
  resource_group_name = var.Default_RG_Disrec
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "WINDOWS-DR-NIC" {
  name                = "WINDOWS-DR-NIC"
  location            = var.Disrec
  resource_group_name = var.Default_RG_Disrec

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.grupo2-neu-dr-subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.1.2.20"
    public_ip_address_id          = azurerm_public_ip.grupo2-neu-dr-windows-pip.id

  }
}

resource "azurerm_virtual_machine" "WINDOWS-DR" {
  name                  = var.Grupo2-neu-dr-vm-WINDOWSSERVER
  location              = var.Disrec
  resource_group_name   = var.Default_RG_Disrec
  network_interface_ids = [azurerm_network_interface.WINDOWS-DR-NIC.id]
  vm_size               = "Standard_B2s"

  storage_os_disk {
    name              = "WINDOWS-DR-Disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "StandardSSD_LRS"
    disk_size_gb      = 127
  }

  delete_os_disk_on_termination    = true#false
  delete_data_disks_on_termination = true#false

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-datacenter-azure-edition"
    version   = "latest"
  }

  os_profile {
    computer_name  = var.Grupo2-neu-dr-vm-WINDOWSSERVER-HOSTNAME
    admin_username = "WinDR"
    admin_password =  var.password_Windows-DR

  }

  os_profile_windows_config {
    provision_vm_agent = true
  }
}


#====================================================================#
#                               NSG's:                               #
# ===================================================================#

# WINDOWS SERVER DR NSG ----------------#
resource "azurerm_network_security_group" "grupo2-neu-dr-WINDOWSSERVER-nsg" {
  name                = "Grupo2-WEU-DR-WINDOWSSERVER-NSG"
  location            = var.Disrec
  resource_group_name = var.Default_RG_Disrec
  security_rule {
    name                       = "RDP"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

    security_rule {
    name                       = "WinRM"
    priority                   = 999
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "5985"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}


resource "azurerm_network_interface_security_group_association" "WindowsServerDR-NIC-NSG" {
  network_interface_id      = azurerm_network_interface.WINDOWS-DR-NIC.id
  network_security_group_id = azurerm_network_security_group.grupo2-neu-dr-WINDOWSSERVER-nsg.id
}

# WINDOWS SERVER PROD NSG ----------------#

resource "azurerm_network_security_group" "grupo2-weu-prod-WINDOWSSERVER-nsg" {
  name                = "Grupo2-WEU-PROD-WINDOWSSERVER-NSG"
  location            = var.Prod
  resource_group_name = var.Default_RG_Prod
  security_rule {
    name                       = "RDP"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "WinRM"
    priority                   = 999
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "5985"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface_security_group_association" "WindowsServerPROD-NIC-NSG" {
  network_interface_id      = azurerm_network_interface.WINDOWS-PROD-NIC.id
  network_security_group_id = azurerm_network_security_group.grupo2-weu-prod-WINDOWSSERVER-nsg.id
}