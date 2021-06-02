variable "sitecount" {
  type = number
}


variable "prefix" {
  type = string
}

variable "location" {
  type = list(string)
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