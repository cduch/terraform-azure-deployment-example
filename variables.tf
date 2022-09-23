
variable "prefix" {
  type = string
}


variable "environments" {
  type = list(object(
  
    {
  
      site_name = string
  
      cidr_block = string
  
    }
  
  ))

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