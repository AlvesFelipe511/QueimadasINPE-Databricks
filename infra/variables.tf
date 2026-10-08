
variable "resource_group_name" {
  type        = string
  description = "Nome do Resource Group"
  default     = "rg-fiap-queimadas"
}

variable "location" {
  type        = string
  description = "Regiao Azure"
  default     = "brazilsouth"
}

variable "mysql_admin_username" {
  type        = string
  description = "Administrador do MySQL"
  default     = "queimadasadmin"
}

variable "mysql_admin_password" {
  type        = string
  description = "Senha do administrador MySQL"
  sensitive   = true
}

variable "database_name" {
  type        = string
  description = "Nome do banco de dados"
  default     = "queimadas"
}
