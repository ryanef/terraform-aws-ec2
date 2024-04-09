resource "aws_instance" "this" {
  ami                         = var.ami
  associate_public_ip_address = var.associate_public_ip_address
  availability_zone           = var.availability_zone
  iam_instance_profile        = var.iam_instance_profile
  instance_type               = var.instance_type
  key_name                    = var.key_name
  user_data                   = var.use_user_data != null ? filebase64("${path.module}/userdata.sh") : null

  monitoring      = var.monitoring
  security_groups = var.security_groups
  subnet_id       = var.subnet_id
  tenancy         = var.tenancy

  instance_market_options {
    market_type = "spot"

    spot_options {
      instance_interruption_behavior = var.instance_interruption_behavior
      max_price                      = var.max_price
      spot_instance_type             = var.spot_instance_type
      valid_until                    = var.valid_until
    }

  }
  private_dns_name_options {
    enable_resource_name_dns_a_record    = var.enable_resource_name_dns_a_record
    enable_resource_name_dns_aaaa_record = var.enable_resource_name_dns_aaaa_record
    hostname_type                        = var.hostname_type
  }

  root_block_device {
    delete_on_termination = var.delete_on_termination
    volume_size           = var.volume_size
    volume_type           = var.volume_type
  }


  tags = {
    Name = "${var.vpc_name}-${var.environment}-${var.instance_name}"
  }
}

resource "aws_launch_template" "foo" {
  count = var.use_launch_template ? 1 : 0
  name  = "${var.instance_name}_launch_template"

  block_device_mappings {
    device_name = "/dev/sdf"

    ebs {
      volume_size = var.volume_size
    }
  }

  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }

  # cpu_options {
  #   core_count       = 4
  #   threads_per_core = 2
  # }

  # credit_specification {
  #   cpu_credits = "standard"
  # }

  # disable_api_stop        = true
  # disable_api_termination = true

  # ebs_optimized = true

  # elastic_gpu_specifications {
  #   type = "test"
  # }


  iam_instance_profile {
    name = var.iam_instance_profile
  }

  image_id = var.ami

  instance_initiated_shutdown_behavior = var.instance_interruption_behavior

  instance_market_options {
    market_type = "spot"
  }

  instance_type = var.instance_type


  key_name = var.key_name



  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
    instance_metadata_tags      = "enabled"
  }

  monitoring {
    enabled = var.monitoring
  }

  network_interfaces {
    associate_public_ip_address = var.associate_public_ip_address
  }



  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${var.vpc_name}-${var.environment}-${var.instance_name}-lt"
    }
  }

  user_data = var.use_user_data != null ? filebase64("${path.module}/userdata.sh") : null
}