variable "ami" {
  type = string
  default = "ami-080e1f13689e07408"
  description = "default is set to ubuntu22 us-east-1"
}

variable "associate_public_ip_address" {
  type = bool
  default = true
}

variable "availability_zone" {
  type = string
}

variable "delete_on_termination" {
  default = true
  type = bool
  description = "For EC2 Root Block Device"
}

variable "environment" {
  default = "dev"
  type = string
}

variable "enable_resource_name_dns_a_record" {
  type = bool
  default = true
}
variable "enable_resource_name_dns_aaaa_record" {
  type = bool
  default = false
}

variable "hostname_type" {
  type = string
  default = "ip-name"
  description = "for IPv4 only subnets DNS name must be based on IPv4 address. IPv6 must be based on instance name "
}
variable "iam_instance_profile" {
  type =string
  default = null
}

variable "instance_name" {
  type = string
  default = "tf-ec2"
}
variable "instance_type" {
  default = "t3.micro"
  type = string
}
variable "instance_interruption_behavior"{
  type = string
  default = "terminate"
  description = "possible values: hibernate, stop, terminate"
}
variable "key_name" {
  type = string
  default = "ec2servers"
}


variable "launch_template" {
  default = null
  type = map(object({
    id = string
    name = string
    version = string
  }))
  description = "version default is $Default. could be a specific number or $Latest"
}

variable "max_price" {
  type = string
  default = "0.01"
}
variable "monitoring" {
  default = false
  type = bool
}

variable "security_groups" {
  default = null
  type = list(string)
}

variable "spot_instance_type" {
  type = string
  default = "one-time"
  description = "possible values: one-time, persistent"
}

variable "subnet_id" {
  type = string
  default = null
}
variable "tenancy" {
  type = string
  default = "default"
}

variable "volume_size" {
  default = 10
  type = number
}

variable "volume_type" {
  default = "gp3"
  type = string
  description = " Valid values include standard, gp2, gp3, io1, io2, sc1, or st1"
}

variable "valid_until" {
  type = string
  default = null
}
variable "vpc_name" {
  type = string
}