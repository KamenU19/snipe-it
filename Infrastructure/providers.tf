provider "aws" {
    region  = "${var.region}"
}

terraform {
  required_version = ">= 1.1.1, < 1.3.7"

  backend "s3" {
    bucket = "snipeitterraform"
    key = "terraform.tfstate"
    region = "eu-west-1"
    encrypt = true
  }
}