module "vpc" {
  source = "https://github.com/Dgadavin/terraform-aws-course/tree/master/modules/VPC"
}

module "ssh-keys" {
  source = "https://github.com/Dgadavin/terraform-aws-course/tree/master/modules/ssh"
  ssh_key = "${var.ssh_key}"
}
