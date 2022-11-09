
variable "prefix" {
  type = string
}


variable "environments" {
  type = set(string)
}


variable "location" {
  type = string
}

variable "owner" {
  type    = string
}

variable "admin_username" {
  type        = string
  description = "Administrator user name for virtual machine"
  default     = "tfadmin"
}

variable "admin_password" {
  type        = string
  description = "Password must meet Azure complexity requirements"
}