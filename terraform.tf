# terraform

terraform {
  backend "s3" {
    region = "ap-northeast-2"
    bucket = "terraform-nalbam-seoul"
    key    = "prod-api-circleci.tfstate"
  }
  required_version = ">= 0.12"
}

provider "aws" {
  region = var.region
}
