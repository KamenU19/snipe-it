variable "region" {
  description = "AWS Deployment region"
  default = "eu-west-1"
}

variable "environment" {
  description = "Deployment Environment"
  default = "Staging"
}

variable "vpc_cidr" {
  description = "CIDR block of the vpc"
  default     = "10.0.0.0/16"
}