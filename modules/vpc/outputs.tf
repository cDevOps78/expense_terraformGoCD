output "vpc_id" {
  value = aws_vpc.dev.id
}

output "frontend_subnets" {
  value = aws_subnet.frontend.*.id
}


output "backed_subnets" {
  value = aws_subnet.backend.*.id
}

output "mysql_subnets" {
  value = aws_subnet.mysql.*.id
}

output "public_subnets" {
  value = aws_subnet.public-subnets.*.id
}