variable "region" {
  description = "AWS Deployment region"
  default = "eu-west-1"
}

variable "environment" {
  description = "Deployment Environment"
  default = "Snipeit"
}

variable "vpc_cidr" {
  description = "CIDR block of the vpc"
  default     = "10.0.0.0/16"
}

variable "public_subnets_cidr" {
  type        = list(any)
  description = "CIDR block for Public Subnet"
  default     = ["10.0.1.0/24","10.0.2.0/24" ,"10.0.3.0/24"]
}

variable "private_subnets_cidr" {
  type        = list(any)
  description = "CIDR block for Private Subnet"
  default     = ["10.0.10.0/24", "10.0.11.0/24" ,"10.0.12.0/24"]
}

variable "ami" {
    default = "ami-0333305f9719618c7"
}

variable "ec2_instance_type" {
  default = "t2.micro"
}

variable "bucket" {
  description = "S3 bucket for terraform states"
  default = "s3terraformsnipestate"
}