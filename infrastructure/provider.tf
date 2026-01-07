terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "mlops-in-practise-terraform-state"
    key            = "global/s3/terraform.tfstate"
    region         = var.region
    dynamodb_table = "mlops-in-practise-terraform-state-locking"
    encrypt        = true
  }
}

provider "aws" {
  region  = var.region
}
