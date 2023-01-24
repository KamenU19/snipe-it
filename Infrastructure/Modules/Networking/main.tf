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

# Routing tables to route traffic for Private Subnet
resource "aws_route_table" "private" {
    vpc_id = data.aws_vpc.snipeitvpc.id

    tags = {
        Name = "${var.environment}-private-route-table"
        Environment = "${var.environment}"
    }
  
}


# Routing tables to route traffic for Public Subnet
resource "aws_route_table" "public" {

    vpc_id = data.aws_vpc.snipeitvpc.id
    tags = {
        Name = "${var.environment}-public-route-table"
        Environment = "${var.environment}"
    }
  
}

# Route for Internet Gateway
resource "aws_route" "public_internet_gateway" {

    route_table_id = aws_route_table.public.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig.id
  
}

# Route table associations for both Public & Private Subnets
resource "aws_route_table_association" "public" {
    count = length(var.public_subnets_cidr)
    subnet_id = element(aws_subnet.public_subnet.*.id,  count.index)
    route_table_id = aws_route_table.public.id
  
}

resource "aws_security_group" "snipeit" {
  vpc_id = data.aws_vpc.snipeitvpc.id
  name = "snipeit"
}

#-------- Allow 443 port
resource "aws_security_group_rule" "public-secure-internet-ingress" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.snipeit.id
}

resource "aws_security_group_rule" "public-secure-internet-egress" {
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.snipeit.id
}

#-----Allow 80 port
resource "aws_security_group_rule" "public-non-secure-internet-ingress" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.snipeit.id
}

resource "aws_security_group_rule" "public-non-secure-internet-egress" {
  type              = "egress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.snipeit.id
}

#----- allow database 3306 port

resource "aws_security_group_rule" "database-ingress" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  cidr_blocks       = ["10.0.0.0/16"]
  security_group_id = aws_security_group.snipeit.id
}

resource "aws_security_group_rule" "database-egress" {
  type              = "egress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  cidr_blocks       = ["10.0.0.0/16"]
  security_group_id = aws_security_group.snipeit.id
}

#----- allow home ip

resource "aws_security_group_rule" "ssh-home-ingress" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["37.143.213.101/32"]
  security_group_id = aws_security_group.snipeit.id
}

resource "aws_security_group_rule" "ssh-home-egress" {
  type              = "egress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["37.143.213.101/32"]
  security_group_id = aws_security_group.snipeit.id
}

resource "aws_security_group_rule" "ssh-internal-ingress" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["10.0.0.0/16"]
  security_group_id = aws_security_group.snipeit.id
}

resource "aws_security_group_rule" "ssh-internal-egress" {
  type              = "egress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["10.0.0.0/16"]
  security_group_id = aws_security_group.snipeit.id
}

resource "aws_security_group_rule" "wazuh ingress" {
  type              = "ingress"
  from_port         = 1514
  to_port           = 1514
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.snipeit.id
}

resource "aws_security_group_rule" "wazuh-egress" {
  type              = "egress"
  from_port         = 1514
  to_port           = 1514
  protocol          = "tcp"
  cidr_blocks       = ["10.0.0.0/0"]
  security_group_id = aws_security_group.snipeit.id
}

resource "aws_security_group_rule" "wazuh ingress" {
  type              = "ingress"
  from_port         = 1515
  to_port           = 1515
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.snipeit.id
}

resource "aws_security_group_rule" "wazuh-egress" {
  type              = "egress"
  from_port         = 1515
  to_port           = 1515
  protocol          = "tcp"
  cidr_blocks       = ["10.0.0.0/0"]
  security_group_id = aws_security_group.snipeit.id
}

resource "aws_security_group_rule" "wazuh ingress" {
  type              = "ingress"
  from_port         = 55000
  to_port           = 55000
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.snipeit.id
}

resource "aws_security_group_rule" "wazuh-egress" {
  type              = "egress"
  from_port         = 55000
  to_port           = 55000
  protocol          = "tcp"
  cidr_blocks       = ["10.0.0.0/0"]
  security_group_id = aws_security_group.snipeit.id
}