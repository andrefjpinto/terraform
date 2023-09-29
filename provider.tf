provider "aws" {
  profile = "default"
  region  = "eu-west-1"

  default_tags {
    tags = {
      environment = var.env
      project     = var.name
      creation    = var.repo
    }
  }
}