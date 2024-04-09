resource "aws_instance" "this" {
  ami = var.ami
  associate_public_ip_address = var.associate_public_ip_address
  availability_zone = var.availability_zone
  iam_instance_profile = var.iam_instance_profile
  instance_type = var.instance_type
  key_name = var.key_name

  monitoring = var.monitoring
  security_groups = var.security_groups
  subnet_id = var.subnet_id
  tenancy = var.tenancy

  private_dns_name_options {
    enable_resource_name_dns_a_record = var.enable_resource_name_dns_a_record
    enable_resource_name_dns_aaaa_record = var.enable_resource_name_dns_aaaa_record
    hostname_type = var.hostname_type
  }

  root_block_device {
    delete_on_termination = var.delete_on_termination
    volume_size = var.volume_size
    volume_type = var.volume_type
  }
  

  tags = {
    Name = "${var.vpc_name}-${var.environment}-ec2"
  }
}