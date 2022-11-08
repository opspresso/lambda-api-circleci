# backend

terraform {
  required_version = ">= 0.12"

  backend "s3" {
    region = "ap-northeast-2"
    bucket = "terraform-nalbam-seoul"
    key    = "prod-api-circleci.tfstate"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.40.0"
    }
  }
}

# terraform {
#   backend "remote" {
#     organization = "nalbam"
#     workspaces {
#       name = "web-nalbam"
#     }
#   }
# }

provider "aws" {
  region = var.region
}

# aws s3 cp s3://terraform-nalbam-seoul/prod-api-circleci.tfstate ./terraform.tfstate
