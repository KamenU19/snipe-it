variable "subnets_id" {
   # type = list(string)
    description = "The subnet used from Networking module"
}

variable "alb_target_group_vpc_id" {
    description = "The vpc ID where the ALB target group will be added"
}

variable "alb_ec2_instance_id" {
  description = "The ID Of the EC2 instance to be placed in the ALB"
}

variable "sec_groups" {
  description = "The security groups for the ALB"
}