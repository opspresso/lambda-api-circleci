# variable

variable "region" {
  default = "ap-northeast-2"
}

variable "name" {
  default = "api-circleci"
}

variable "stage" {
  default = "prod"
}

variable "domain" {
  default = "opspresso.com"
}

variable "s3_bucket" {
  default = "repo.opspresso.com"
}

variable "CIRCLECI_API" {
  default = "https://circleci.com/api/v1.1/project/github/username/project"
}

variable "CIRCLECI_TOKEN" {
  default = ""
}
