/*Reading data of the existing VPC*/
data "aws_vpc" "snipeitvpc" {
  
  filter {
    name = "tag:Name"
    values = ["snipeitvpc"]
  }
}

/*==== Subnets ======*/
/* Internet gateway for the public subnet */

resource "aws_internet_gateway" "ig" {
    vpc_id = data.aws_vpc.snipeitvpc.id
    tags = {
        Name = "${var.environment}-igw"
        Environment = var.environment
    }
}

#Public subnet 
resource "aws_subnet" "public_subnet" {
    vpc_id = "${data.aws_vpc.snipeitvpc.id}"
    count = "${length(var.public_subnets_cidr)}"
    cidr_block = "${element(var.public_subnets_cidr,   count.index)}"
    availability_zone = "${element(var.availability_zones,   count.index)}"
    map_public_ip_on_launch = true
    tags= {
        Name = "${var.environment}-${element(var.availability_zones, count.index)}-public-subnet"
        Environment =  "${var.environment}"
    }
}

#Private subnet
resource "aws_subnet" "private_subnet" {
  vpc_id = "${data.aws_vpc.snipeitvpc.id}"
  count = "${length(var.private_subnets_cidr)}"
  cidr_block = "${element(var.private_subnets_cidr, count.index)}"
  availability_zone =  "${element(var.availability_zones,   count.index)}"
  map_public_ip_on_launch = false
  tags = {
    Name = "${var.environment}-${element(var.availability_zones, count.index)}-private-subnet"
    Environment = "${var.environment}"
  }
}
