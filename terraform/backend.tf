terraform {
  backend "s3" {
    bucket = "eks-yuvaraj"
    region = "us-east-1"
    key = "eac-eks/terraform.tfstate"
    profile = "saml"
  }
}
