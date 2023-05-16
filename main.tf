terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.5.0"
    }
    random = {
          source  = "hashicorp/random"
          version = ">= 2.2"
    }
  }

}

provider "aws" {
  region  = var.region

  default_tags {
    tags = {
      Environment       = "RnD"
      Project           = "Skillset"
      Name              = "HappyStays"
      CostCenter        = "CDx"
    }
  }
}

module "eks-cluster" {
  source = "./eks-cluster"
}

module "rds-aurora" {
  source = "./rds-aurora"
}

module "s3-bucket" {
  source = "./s3-bucket"
}

module "nosql-db" {
  source = "./nosql-db"
}

module "secrets-manager" {
  source = "./secrets-manager"
}
