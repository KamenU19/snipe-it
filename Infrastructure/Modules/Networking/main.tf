/*Reading data of the existing VPC*/
data "aws_vpc" "snipeitvpc" {
  
  filter {
    name = "tag:Name"
    values = ["snipeitvpc"]
  }
}

/*==== Subnets7 ======*/
/* Internet gateway for the public subnet */

resource "aws_internet_gateway" "ig" {
    vpc_id = data.aws_vpc.snipeitvpc.id
    tags = {
        Name = "${var.environment}-igw"
        Environment = var.environment
    }
}
