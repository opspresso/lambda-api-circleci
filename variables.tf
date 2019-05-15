variable region {
  default = "ap-northeast-2"
}

variable name {
  default = "docker-to-circlci"
}

variable stage {
  default = "dev"
}

variable domain {
  default = "nalbam.com"
}

variable s3_bucket {
  default = "repo.nalbam.com"
}

variable version {
  default = "1.0.0"
}

variable CIRCLECI_API {
  default = "https://circleci.com/api/v1.1/project/gh/username/project"
}

variable CIRCLECI_TOKEN {
  default = ""
}
