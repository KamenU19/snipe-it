variable "ami" {
    description = "the AMI used to build the instance with"
}

variable "ec2_instance_type" {
  description = "The Type of the instance when launched"
}

variable "sec_groups" {
  description = "the security group from Networking"
}

variable "subnets_id" {
    type = list(string)
    description = "The subnet used from Networking module"
}
variable "EC_KEY_NAME" {
    default = "snipe-it-key"
  description = "The security key used to sSH"
}

variable "key_path" {
  default = ".app/snipe-it-key.pem"
  description = "The security key used to sSH"
}