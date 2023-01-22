#Create the load balancer
resource "aws_lb" "app" {
  name               = "snipeitalb"
  internal           = false
  load_balancer_type = "application"
  subnets            = var.subnets_id
  security_groups    = var.sec_groups
}

#Create the Load Balancer listener on HTTPS/443 
resource "aws_lb_listener" "app" {
  load_balancer_arn = aws_lb.app.arn
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn = data.aws_acm_certificate.issued.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}

#Create thee target group with forwarding port 80 to the EC2
resource "aws_lb_target_group" "target_group" {
  name     = "SnipeIT-Target-Group-lb"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.alb_target_group_vpc_id

  health_check {
    port     = 80
    protocol = "HTTP"
    timeout  = 5
    interval = 10
  }
}

#Attach the target group to the load balancer
resource "aws_lb_target_group_attachment" "blue" {
  #count            = length(aws_instance.blue)
  target_group_arn = aws_lb_target_group.target_group.arn
  target_id        = var.alb_ec2_instance_id
  port             = 80
}

#The data for the certificate
data "aws_acm_certificate" "issued" {
  domain   = "eramba.link"
  types       = ["AMAZON_ISSUED"]
  most_recent = true
}

#The data for the domain 
data "aws_route53_zone" "main" {
  name =  "eramba.link"
}

#Add the ALB DNS to the route53 A record as alias with simple routing policy
resource "aws_route53_record" "www" {
  allow_overwrite = true
  zone_id = data.aws_route53_zone.main.zone_id
  name    = "eramba.link"
  type    = "A"

  alias {
    name                   = aws_lb.app.dns_name
    zone_id                = aws_lb.app.zone_id
    evaluate_target_health = true
  }
}