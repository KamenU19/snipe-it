#Create the EC2 machine
resource "aws_instance" "snipeitserver" {
  tags = { Name = "SnipeIT Server" } 
  ami = var.ami
  instance_type = var.ec2_instance_type
  subnet_id = var.subnets_id[0]
  vpc_security_group_ids = var.sec_groups
  }

  # test11
