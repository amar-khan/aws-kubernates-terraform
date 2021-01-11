module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.6.0"

  name                 = "${var.env}-vpc"
  cidr                 = "21.0.0.0/16"
  azs                  = data.aws_availability_zones.available.names
  private_subnets      = ["21.0.1.0/24", "21.0.2.0/24", "21.0.3.0/24"]
  public_subnets       = ["21.0.4.0/24", "21.0.5.0/24", "21.0.6.0/24"]
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
  }
}