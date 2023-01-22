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
  availability_zones   = local.production_availability_zones

}


##
##