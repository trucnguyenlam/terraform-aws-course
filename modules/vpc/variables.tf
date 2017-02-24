variable "vpc_cidr_range" {default = "10.0.0.0/16"}
variable "public_subnet_cidr" {default = "10.0.0.0/24"}
variable "private_subnet_cidr" {default = "10.0.10.0/24"}
variable "region" { default = "eu-central-1" }
variable "short_name" { default = "epam-test" }