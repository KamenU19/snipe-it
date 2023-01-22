#Create the EC2 machine
resource "aws_instance" "snipeitserver" {
  ami = var.ami
  instance_type = var.ec2_instance_type
  subnet_id = var.subnets_id[0]
  key_name = var.EC_KEY_NAME
  vpc_security_group_ids = var.sec_groups