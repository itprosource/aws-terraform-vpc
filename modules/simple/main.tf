
provider "aws" {
  region = "us-west-1"
}

module "vpc" {
  source = "../../"

  name = "example"

  cidr = "10.0.0.0/20"
  # 10.0.0.0/8 is reserved for EC2-Classic

  azs = ["us-west-1b", "us-west-1c"]
  private_subnets  = ["10.0.0.0/24", "10.0.1.0/24"]
  public_subnets   = ["10.0.2.0/24", "10.0.3.0/24"]
  database_subnets = ["10.0.4.0/24", "10.0.5.0/24"]
}