terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.0.0"
}

provider "aws" {
  region  = var.region
}

module "homolog__enviroment" {
    source = "../homolog_env"
    region = "us-east-1"
    name = "test"
    security-group = ""
    vpc-id = ""
    subnet-id = ""
    elb-sg = ""
    db-name = ""
    db-engie = ""
    db-engie-verison = ""
    db-instance-class = ""
}

