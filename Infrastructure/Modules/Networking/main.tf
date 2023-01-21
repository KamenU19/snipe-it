/*Reading data of the existing VPC*/
data "aws_vpc" "SnipeIT VPC" {
  
  filter {
    name = "tag:Name"
    values = ["SnipeIT VPC"]
  }
}

/*==== Subnets ======*/
/* Internet gateway for the public subnet */

resource "aws_internet_gateway" "ig" {
    vpc_id = data.aws_vpc.SnipeIT VPC.id
    tags = {
        Name = "${var.environment}-igw"
        Environment = var.environment
    }
}