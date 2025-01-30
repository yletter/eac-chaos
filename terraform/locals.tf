locals {
  region = "us-east-1"
  name   = "chaos-cluster"
  vpc_cidr = "10.1.0.0/16"
  azs      = ["us-east-1a", "us-east-1b"]
  public_subnets  = ["10.1.1.0/24", "10.1.2.0/24"]
  private_subnets = ["10.1.3.0/24", "10.1.4.0/24"]
  intra_subnets   = ["10.1.5.0/24", "10.1.6.0/24"]
}