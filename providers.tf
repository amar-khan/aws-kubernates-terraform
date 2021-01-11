terraform {
  required_version = ">= 0.12.20"
}

data "aws_availability_zones" "available" {}

provider "aws" {
    access_key = var.access_key
    secret_key = var.secret_key
    region = "us-east-2"
}

provider "aws" {
    alias = "us-east-2"
    region = "us-east-2"
}