variable "environment" {
  description = "Deployment Environment"
}

variable "vpc_cidr" {

  description = "CIDR block of the vpc"
}

variable "region" {
  description = "Region in which the bastion host will be launched"
}

variable "availability_zones" {
  type        = list
  description = "AZ in which all the resources will be deployed"
}
