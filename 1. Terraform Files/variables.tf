# Variáveis que definem as Regiões ----------
variable "Prod"{
    type = string
    default = "West Europe"
}

variable "Disrec"{
type = string
default = "North Europe"
}

# Variáveis Production default Resource Group ----------
variable "Default_RG_Prod" {
  type        = string
  default     = "grupo2-weu-prod-rg"
  description = "Group #2 default Production resource group."
}

# Variáveis Disaster recovery default Resource Group ----------
variable "Default_RG_Disrec" {
  type        = string
  default     = "grupo2-neu-dr-rg"
  description = "Group #2 default Disaster recovery resource group."
}


# Variáveis da Vnet e Subnet ----------
variable "Grupo2-weu-prod-vnet"{
    type = list(string)
    default = ["10.0.0.0/16"]
}

variable "Grupo2-weu-prod-subnet"{
type = list(string)
default = ["10.0.2.0/24"]
}

variable "Grupo2-weu-prod-ansible-subnet"{
type = list(string)
default = ["10.0.1.0/24"]
}

# --------------

variable "Grupo2-neu-dr-vnet"{
    type = list(string)
    default = ["10.1.0.0/16"]
}

variable "Grupo2-neu-dr-subnet"{
type = list(string)
default = ["10.1.2.0/24"]
}

variable "Grupo2-neu-dr-ansible-subnet"{
type = list(string)
default = ["10.1.1.0/24"]
}

# Variáveis para apelidar as máquinas ----------

variable "Grupo2-weu-prod-vm-ANSIBLE" {
  type        = string
  default     = "Grupo2-WEU-PROD-ANSIBLE"
  description = "Group #2 Production Ansible Control node."
}

variable "Grupo2-neu-dr-vm-ANSIBLE" {
  type        = string
  default     = "Grupo2-NEU-DR-ANSIBLE"
  description = "Group #2 Disaster recovery Ansible Control node."
}
# ------

variable "Grupo2-weu-prod-vm-WEBSERVER" {
  type        = string
  default     = "Grupo2-WEU-PROD-WEBSERVER"
  description = "Group #2 Production Web Server."
}

variable "Grupo2-neu-dr-vm-WEBSERVER" {
  type        = string
  default     = "Grupo2-NEU-DR-WEBSERVER"
  description = "Group #2 Disaster recovery Web Server."
}

# -----

variable "Grupo2-weu-prod-vm-WINDOWSSERVER" {
  type        = string
  default     = "Grupo2-WEU-PROD-WINDOWSSERVER"
  description = "Group #2 Production Windows Server."
}

variable "Grupo2-neu-dr-vm-WINDOWSSERVER" {
  type        = string
  default     = "Grupo2-NEU-DR-WINDOWSSERVER"
  description = "Group #2 Disaster recovery Windows Server."
}

# -----
variable "Grupo2-weu-prod-vm-DATABASESERVER" {
  type        = string
  default     = "Grupo2-WEU-PROD-DATABASESERVER"
  description = "Group #2 Production Database Server."
}

variable "Grupo2-neu-dr-vm-DATABASESERVER" {
  type        = string
  default     = "Grupo2-NEU-DR-DATABASESERVER"
  description = "Group #2 Disaster recovery Database Server."
}

# Variáveis para hostname ----------

variable "Grupo2-weu-prod-vm-ANSIBLE-HOSTNAME" {
  type        = string
  default     = "GRUPO2_ANSIBLE_PROD"
  description = "Group #2 Production Ansible Control node hostname."
}

variable "Grupo2-neu-dr-vm-ANSIBLE-HOSTNAME" {
  type        = string
  default     = "GRUPO2_ANSIBLE_DR"
  description = "Group #2 Disaster recovery Ansible Control node hostname."
}

# ------

variable "Grupo2-weu-prod-vm-WEBSERVER-HOSTNAME" {
  type        = string
  default     = "Grupo2_PROD_WEBSERVER"
  description = "Group #2 Production Web Server hostname."
}

variable "Grupo2-neu-dr-vm-WEBSERVER-HOSTNAME" {
  type        = string
  default     = "Grupo2_DR_WEBSERVER"
  description = "Group #2 Disaster recovery Web Server hostname."
}

# -----

variable "Grupo2-weu-prod-vm-WINDOWSSERVER-HOSTNAME" {
  type        = string
  default     = "GRUPO2_PROD_WINDOWS"
  description = "Group #2 Production Windows Server hostname."
}

variable "Grupo2-neu-dr-vm-WINDOWSSERVER-HOSTNAME" {
  type        = string
  default     = "GRUPO2_DR_WINDOWS"
  description = "Group #2 Disaster recovery Windows Server hostname."
}

# -----

variable "Grupo2-weu-prod-vm-DATABASESERVER-HOSTNAME" {
  type        = string
  default     = "Grupo2_PROD_DATABASESERVER"
  description = "Group #2 Production Database Server hostname."
}

variable "Grupo2-neu-dr-vm-DATABASESERVER-HOSTNAME" {
  type        = string
  default     = "Grupo2_DR_DATABASESERVER"
  description = "Group #2 Disaster recovery Database Server hostname."
}

