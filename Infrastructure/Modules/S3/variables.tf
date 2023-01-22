variable "region" {
  description = "Region in which this is created"
}

variable "bucket-name" {
  type        = string
  description = "The bucket to use for storing terrform state files"
}

variable "environment" {
  type        = string
  description = "Environment name"
}

variable "force_destroy" {
  default = false
}