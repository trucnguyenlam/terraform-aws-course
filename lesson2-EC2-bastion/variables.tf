variable "vpc_cidr_range" {default = "10.0.0.0/16"}
variable "public_subnet_cidr" {default = "10.0.0.0/24"}
variable "private_subnet_cidr" {default = "10.0.10.0/24"}
variable "region" { default = "eu-central-1" }
variable "short_name" { default = "epam-test" }

variable "amis" {
  default = {
    us-east-1 = "ami-6bb2d67c"
    us-west-1	= "ami-70632110"
    us-west-2	= "ami-2d1bce4d"
    ap-northeast-1	= "ami-2b6ba64a"
    ap-southeast-1	= "ami-55598036"
    ap-southeast-2	= "ami-0e20176d"
    eu-central-1 = "ami-721aec1d"
    eu-west-1 = "ami-7b244e08"
  }
}

#EC2 variables for bastion
variable "ec2_type" {default = "t2.nano"}
variable "ebs_volume_size" {default = "20"}
variable "ebs_volume_type" {default = "gp2"}
variable "ssh_username" {default = "ec2-user"}
variable "role" {default = "web-server"}
variable "ssh_key" {default = "~/.ssh/terraform.pub"}


variable "vpc_id" {}
variable "auth_service_port" {}
variable "index_service_port" {}
variable "mock_service_port" {}
variable "ssh_port" {}
variable "dynamodb_port" {default = "8000"}