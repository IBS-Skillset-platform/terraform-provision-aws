terraform {
  required_version = ">= 0.14.9"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
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