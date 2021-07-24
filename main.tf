## VPC

resource "aws_vpc" "example" {
  cidr_block = var.cidr
  instance_tenancy = var.instance_tenancy
  enable_dns_support = var.enable_dns_support
  enable_dns_hostnames = var.enable_dnshostnames
  enable_classiclink = var.enable_classiclink
  enable_classiclink_dns_support = var.enable_classiclink_dns_support
  assign_generated_ipv6_cidr_block = var.assign_generated_ipv6_cidr_block

  tags = {
    Name = "${var.name}"
  }
}

## SUBNETS

resource "aws_subnet" "public" {
  count = length(var.public_subnets)
  cidr_block = element(var.public_subnets, count.index)
  map_public_ip_on_launch = var.map_public_ip_on_launch
  vpc_id = aws_vpc.example.id
  availability_zone = element(var.azs, count.index)
  availability_zone_id = var.availability_zone_id
  customer_owned_ipv4_pool = var.customer_owned_ipv4_pool
  map_customer_owned_ip_on_launch = var.map_customer_owned_ip_on_launch
  ipv6_cidr_block = var.ipv6_cidr_block
  outpost_arn = var.outpost_arn
  assign_ipv6_address_on_creation = var.assign_ipv6_address_on_creation



  tags = {
    Name = "${var.name}-Public-${count.index+1}"
  }
}

resource "aws_subnet" "private" {
  count = length(var.private_subnets)
  cidr_block = element(var.private_subnets, count.index)
  map_public_ip_on_launch = var.map_public_ip_on_launch
  vpc_id = aws_vpc.example.id
  availability_zone = element(var.azs, count.index)
  availability_zone_id = var.availability_zone_id
  customer_owned_ipv4_pool = var.customer_owned_ipv4_pool
  map_customer_owned_ip_on_launch = var.map_customer_owned_ip_on_launch
  ipv6_cidr_block = var.ipv6_cidr_block
  outpost_arn = var.outpost_arn
  assign_ipv6_address_on_creation = var.assign_ipv6_address_on_creation

  tags = {
    Name = "${var.name}-Private-${count.index+1}"
  }
}

resource "aws_subnet" "database" {
  count = length(var.database_subnets)
  cidr_block = element(var.database_subnets, count.index)
  map_public_ip_on_launch = var.map_public_ip_on_launch
  vpc_id = aws_vpc.example.id
  availability_zone = element(var.azs, count.index)
  availability_zone_id = var.availability_zone_id
  customer_owned_ipv4_pool = var.customer_owned_ipv4_pool
  map_customer_owned_ip_on_launch = var.map_customer_owned_ip_on_launch
  ipv6_cidr_block = var.ipv6_cidr_block
  outpost_arn = var.outpost_arn
  assign_ipv6_address_on_creation = var.assign_ipv6_address_on_creation

  tags = {
    Name = "${var.name}-Private-${count.index+1}"
  }
}

