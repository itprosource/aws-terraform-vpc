variable "name" {
  type = string
  Description = ""
  default = ""
}

variable "cidr" {
  type = string
  Description = ""
  default = ""
}

variable "instance_tenancy" {
  type = string
  Description = ""
  default = ""
}

variable "enable_dns_support" {
  type = bool
  description = ""
  default = false
}

variable "enable_dnshostnames" {
  type = bool
  description = ""
  default = false
}

variable "enable_classiclink" {
  type = bool
  description = ""
  default = false
}

variable "enable_classiclink_dns_support" {
  type = bool
  description = ""
  default = false
}

variable "assign_generated_ipv6_cidr_block" {
  type = bool
  description = ""
  default = false
}