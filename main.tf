# Terraform Main

provider "aws" {
  region = "${var.region}"
}

terraform {
  backend "s3" {
    region = "ap-northeast-2"
    bucket = "terraform-opspresso-seoul"
    key = "dev-docker-to-circlci.tfstate"
  }
  required_version = "> 0.11.0"
}

module "domain" {
  source = "git::https://github.com/nalbam/terraform-aws-route53.git"
  domain = "${var.domain}"
}

module "dev-api" {
  source = "git::https://github.com/nalbam/terraform-aws-lambda-api.git"
  region = "${var.region}"

  name         = "${var.name}"
  stage        = "${var.stage}"
  description  = "docker > lambda > circleci"
  runtime      = "nodejs8.10"
  handler      = "index.handler"
  memory_size  = 512
  timeout      = 5
  s3_bucket    = "${var.s3_bucket}"
  s3_source    = "target/lambda.zip"
  s3_key       = "lambda/${var.name}/${var.name}-${var.version}.zip"
  http_methods = ["ANY"]

  // domain
  zone_id         = "${module.domain.zone_id}"
  certificate_arn = "${module.domain.certificate_arn}"
  domain_name     = "${var.stage}-${var.name}.${var.domain}"

  env_vars = {
    PROFILE        = "${var.stage}"
    CIRCLECI_API   = "${var.CIRCLECI_API}"
    CIRCLECI_TOKEN = "${var.CIRCLECI_TOKEN}"
  }
}

output "url" {
  value = "https://${module.dev-api.domain}/webhook"
}
