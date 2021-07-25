######
## VPC
######

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

##########
## SUBNETS
##########

resource "aws_subnet" "public" {
  count = length(var.public_subnets)
  cidr_block = element(var.public_subnets, count.index)
  map_public_ip_on_launch = var.map_public_ip_on_launch
  vpc_id = aws_vpc.example.id
  availability_zone = element(var.azs, count.index)
  # availability_zone_id = var.availability_zone_id
  # customer_owned_ipv4_pool = element(var.customer_owned_ipv4_pool,count.index)
  # map_customer_owned_ip_on_launch = var.map_customer_owned_ip_on_launch
  # ipv6_cidr_block = element(var.ipv6_cidr_block,count.index)
  outpost_arn = var.outpost_arn
  assign_ipv6_address_on_creation = var.assign_ipv6_address_on_creation



  tags = {
    Name = "${var.name}-pub-${count.index+1}"
  }
}

resource "aws_subnet" "private" {
  count = length(var.private_subnets)
  cidr_block = element(var.private_subnets, count.index)
  map_public_ip_on_launch = var.map_public_ip_on_launch
  vpc_id = aws_vpc.example.id
  availability_zone = element(var.azs, count.index)
  # availability_zone_id = var.availability_zone_id
  # customer_owned_ipv4_pool = element(var.customer_owned_ipv4_pool,count.index)
  # map_customer_owned_ip_on_launch = var.map_customer_owned_ip_on_launch
  # ipv6_cidr_block = element(var.ipv6_cidr_block,count.index)
  outpost_arn = var.outpost_arn
  assign_ipv6_address_on_creation = var.assign_ipv6_address_on_creation

  tags = {
    Name = "${var.name}-priv-${count.index+1}"
  }
}

resource "aws_subnet" "database" {
  count = length(var.database_subnets)
  cidr_block = element(var.database_subnets, count.index)
  map_public_ip_on_launch = var.map_public_ip_on_launch
  vpc_id = aws_vpc.example.id
  availability_zone = element(var.azs, count.index)
  # availability_zone_id = var.availability_zone_id
  # customer_owned_ipv4_pool = element(var.customer_owned_ipv4_pool,count.index)
  # map_customer_owned_ip_on_launch = var.map_customer_owned_ip_on_launch
  # ipv6_cidr_block = element(var.ipv6_cidr_block,count.index)
  outpost_arn = var.outpost_arn
  assign_ipv6_address_on_creation = var.assign_ipv6_address_on_creation

  tags = {
    Name = "${var.name}-db-${count.index+1}"
  }
}

###########
## INTERNET AND NAT GATEWAYS
###########
# Deploys a single Internet GW, and a NAT GW for each private subnet.

resource "aws_internet_gateway" "int_gateway" {
  vpc_id = aws_vpc.example.id

  tags = {
    Name = "${var.name}"
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  count = length(var.public_subnets)

  allocation_id = element(aws_eip.nat_eip.*.id,count.index)
  # connectivity_type = var.connectivity_type
  subnet_id = element(aws_subnet.public.*.id,count.index)

  tags = {
    Name = "${var.name}-${count.index+1}"
  }
}

resource "aws_eip" "nat_eip" {
  count = length(var.public_subnets)

  # address = element(var.address,count.index)
  # associate_with_private_ip = element(var.associate_with_private_ip,count.index)
  # customer_owned_ipv4_pool = element(var.customer_owned_ipv4_pool,count.index)
  # instance = element(var.instance,count.index)
  # network_border_group = element(var.network_border_group,count.index)
  # network_interface = element(var.network_interface,count.index)
  # public_ipv4_pool = element(var.public_ipv4_pool,count.index)
  vpc = var.vpc

  tags = {
    Name = "${var.name}-${count.index+1}"
  }
}

################################
# Public Route Table
################################

resource "aws_route_table" "public_rte" {
  vpc_id = aws_vpc.example.id
  depends_on = [aws_internet_gateway.int_gateway]

  tags = {
    Name = "${var.name}-Public"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.int_gateway.id
  }
}

resource "aws_route_table_association" "AssociationForRouteTablePublic" {
  count = length(var.public_subnets)
  subnet_id = element(aws_subnet.public.*.id,count.index)
  route_table_id = element(aws_route_table.public_rte.*.id,count.index)
}

################################
# Private Route Tables
################################

resource "aws_route_table" "priv_rte" {
  count = length(var.private_subnets)
  vpc_id = aws_vpc.example.id
  # depends_on = [aws_internet_gateway.igw]

tags = {
    Name = "${var.name}-Priv-${count.index+1}"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gateway[count.index].id
  }
}

resource "aws_route_table_association" "AssociationForRouteTablePrivate" {
  count = length(var.private_subnets)
  subnet_id = element(aws_subnet.private.*.id,count.index)
  route_table_id = element(aws_route_table.priv_rte.*.id,count.index)
}

