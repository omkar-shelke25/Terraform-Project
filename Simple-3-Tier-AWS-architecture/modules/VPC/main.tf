module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "simple-3-tier-vpc"
  cidr = "10.0.0.0/16"

  azs              = ["ap-south-1a", "ap-south-1b"]
  public_subnets   = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets  = ["10.0.21.0/24", "10.0.22.0/24"]
  database_subnets = ["10.0.51.0/24", "10.0.52.0/24"]


  create_database_subnet_group       = true
  create_database_subnet_route_table = true

  enable_nat_gateway     = true
  one_nat_gateway_per_az = true


  enable_dns_hostnames = true
  enable_dns_support   = true


  public_subnet_tags = {
    Name = "Simple-3-Tier-Public-Subnet"
  }

  private_subnet_tags = {
    Name = "Simple-3-Tier-Private-Subnet"
  }

  database_route_table_tags = {
    Name = "Route table for database"
  }
  public_route_table_tags = {
    Name = "Simple Public Route Table"
  }
  private_route_table_tags = {
    Name = "Simple Private Route Table"
  }

  nat_gateway_tags = {
    Name = "Nat Gateway For Private subnete Of 3 tier vpc"
  }
  igw_tags = {
    Name = "Nat Gateway For Public subnete Of 3 tier vpc"
  }


  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}