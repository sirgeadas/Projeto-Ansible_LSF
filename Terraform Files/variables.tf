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
default = ["10.0.0.0/24"]
}

variable "Grupo2-neu-dr-vnet"{
    type = list(string)
    default = ["10.1.0.0/16"]
}

variable "Grupo2-neu-dr-subnet"{
type = list(string)
default = ["10.1.0.0/24"]
}

# Variáveis para apelidar as máquinas ----------
variable "Grupo2-weu-prod-vm-apache" {
  type        = string
  default     = "Grupo2-WEU-PROD-APACHE"
  description = "Group #2 Production VM name."
}

variable "Grupo2-neu-dr-vm-apache" {
  type        = string
  default     = "Grupo2-NEU-DR-APACHE"
  description = "Group #2 Disaster recovery VM name."
}