terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.5.0"
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