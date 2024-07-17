output "server_1_public_ip" {
  value = aws_eip.web_server_1.public_ip
}

output "server_2_public_ip" {
  value = aws_eip.web_server_2.public_ip
}

output "server_1_id" {
  value = aws_instance.web_server_instance_1.id
}

output "server_2_id" {
  value = aws_instance.web_server_instance_2.id
}

output "load_balancer_dns" {
  value = aws_lb.web_server_lb.dns_name
}
