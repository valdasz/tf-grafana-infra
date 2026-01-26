terraform {
  backend "s3" {
  }

  required_providers {
    aws = { source = "hashicorp/aws", version = ">=6.26.0" }
  }

  required_version = ">=1.14"
}

provider "aws" {
  region = var.region
}