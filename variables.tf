variable "name" {
  type = string
  description = ""
  default = ""
}

## VPC

variable "cidr" {
  type = string
  description = ""
  default = ""
}

variable "instance_tenancy" {
  type = string
  description = ""
  default = "default"
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

variable "public_subnets" {
  type = list(string)
  description = ""
  default = []
}

variable "private_subnets" {
  type = list(string)
  description = ""
  default = []
}

variable "database_subnets" {
  type = list(string)
  description = ""
  default = []
}

variable "map_public_ip_on_launch" {
  type = bool
  description = ""
  default = false
}

variable "azs" {
  type = list(string)
  description = ""
  default = []
}

variable "availability_zone_id" {
  type = list(string)
  description = ""
  default = []
}

variable "customer_owned_ipv4_pool" {
  type = list(string)
  description = ""
  default = []
}

variable "map_customer_owned_ip_on_launch" {
  type = bool
  description = ""
  default = false
}

variable "ipv6_cidr_block" {
  type = list(string)
  description = ""
  default = []
}

variable "outpost_arn" {
  type = string
  description = ""
  default = ""
}

variable "assign_ipv6_address_on_creation" {
  type = bool
  description = ""
  default = false
}

## GATEWAYS

variable "connectivity_type" {
  type = string
  description = ""
  default = ""
}

variable "address" {
  type = list(string)
  description = ""
  default = []
}

variable "associate_with_private_ip" {
  type = list(string)
  description = ""
  default = []
}

variable "instance" {
  type = list(string)
  description = ""
  default = []
}

variable "network_border_group" {
  type = list(string)
  description = ""
  default = []
}

variable "network_interface" {
  type = list(string)
  description = ""
  default = []
}

variable "public_ipv4_pool" {
  type = list(string)
  description = ""
  default = []
}

variable "vpc" {
  type = bool
  description = ""
  default = true
}