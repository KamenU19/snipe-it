resource "random_id" "random_id_prefix" {
  byte_length = 2
}

locals {
  production_availability_zones = ["${var.region}a", "${var.region}b", "${var.region}c"]
}

module "Networking" {
  source               = "./Modules/Networking"
  region               = var.region
  environment          = var.environment
  vpc_cidr             = var.vpc_cidr
  public_subnets_cidr  = var.public_subnets_cidr
  private_subnets_cidr = var.private_subnets_cidr
  availability_zones   = local.production_availability_zones

}

module "EC2" {
    source = "./Modules/EC2"
    ami = var.ami
    ec2_instance_type = var.ec2_instance_type
    sec_groups = module.Networking.security_groups_ids
    subnets_id = module.Networking.public_subnets_id[0]
}

module "ALB" {
  source = "./Modules/ALB"
  subnets_id = flatten(module.Networking.public_subnets_id)
  sec_groups = module.Networking.security_groups_ids
  alb_target_group_vpc_id = module.Networking.vpc_id
  alb_ec2_instance_id = module.EC2.aws_instance_id
}

module "githubrunner" {
  source = "./Modules/githubrunner"
  ami = var.ami
  ec2_instance_type = var.ec2_instance_type
  sec_groups = module.Networking.security_groups_ids
  subnets_id = module.Networking.public_subnets_id[0]
}

module "S3" {
  source        = "./Modules/S3"
  bucket-name   = var.bucket
  environment   = var.environment
  region        = var.region
  force_destroy = false
}

##
##