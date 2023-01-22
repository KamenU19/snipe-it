resource "aws_instance" "runner" {
    tags = { Name = "Github Runner1" } 
    ami = var.ami
    instance_type = var.ec2_instance_type
    subnet_id = var.subnets_id[0]
    vpc_security_group_ids = var.sec_groups
    user_data = file ("./Infrastructure/githubrunner/setup.sh")
}