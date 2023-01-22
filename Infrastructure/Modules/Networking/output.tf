output "vpc_id" {
  value = data.aws_vpc.snipeitvpc.id
}

output "public_subnets_id" {
  value = ["${aws_subnet.public_subnet.*.id}"]
}

output "private_subnets_id" {
  value = ["${aws_subnet.private_subnet.*.id}"]
}

output "default_sg_id" {
  value = aws_security_group.snipeit.id
}

output "security_groups_ids" {
  value = ["${data.aws_security_group.snipeit.id}"]
}

output "public_route_table" {
  value = aws_route_table.public.id
}