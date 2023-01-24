variable "region" {
  description = "Region in which this is created"
}

variable "bucket-name" {
  type = string
  default = "s3terraformsnipestate"
  description = "The bucket to use for storing terrform state files"
}

variable "environment" {
  type        = string
  description = "Environment name"
}

variable "force_destroy" {
  default = false
}

variable "target_bucket" {
  default = "s3terraformsnipestate"
}

variable "s3_bucket_name" {
  default = "s3terraformsnipestate"
}
