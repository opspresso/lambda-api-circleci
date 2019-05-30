# terraform

terraform {
  backend "s3" {
    region = "ap-northeast-2"
    bucket = "terraform-opspresso-seoul"
    key    = "dev-docker-to-circleci.tfstate"
  }
  required_version = ">= 0.12"
}

provider "aws" {
  region = var.region
}
