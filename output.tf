output "instance_id" {
  value = aws_instance.this.id
}

output "public_dns" {
  value = aws_instance.this.public_dns
}

output "private_dns" {
  value = aws_instance.this.private_dns
}

output "private_ip" {
  value = aws_instance.this.private_ip
}


output "public_ip" {
  value = aws_instance.this.public_ip
}