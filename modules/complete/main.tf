#############
## COMPLEX VPC
#############

provider "aws" {
  region = "us-west-1"
}

module "vpc" {
  source = "../../"
  # The resources for this file live two directories above, in the root directory.

  name = "example"
  # The name will be used to identify all resources. For example, subnets will be tagged with the name
  # along with the type of subnet (public, private, or db).

  cidr = "10.0.0.0/20"
  # Identifies the cidr block for your VPC.
  # NOTE: 10.0.0.0/8 is reserved for EC2-Classic

  azs = ["us-west-1b", "us-west-1c"]
  private_subnets  = ["10.0.0.0/24", "10.0.1.0/24"]
  public_subnets   = ["10.0.2.0/24", "10.0.3.0/24"]
  database_subnets = ["10.0.4.0/24", "10.0.5.0/24"]
  # If you want to utilize a highly-available architecture spread across AZs, you can include multiple AZs
  # and multiple subnets. For each AZ specified, include that many subnets. If you want a single failover AZ,
  # then specify 2 AZs and 2 subnets in each layer you want to use.
  # If you don't want to use a layer, don't specify any subnets - just leave it blank.

  instance_tenancy = "default"
  enable_dns_support = false
  enable_dnshostnames = false
  enable_classiclink = false
  enable_classiclink_dns_support = false
  assign_generated_ipv6_cidr_block = false
  map_public_ip_on_launch = false

  assign_ipv6_address_on_creation = false
}