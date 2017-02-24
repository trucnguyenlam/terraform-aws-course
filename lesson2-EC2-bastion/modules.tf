module "vpc" {
  source = "github.com/Dgadavin/terraform-aws-course/modules/vpc/"
}

module "ssh-keys" {
  source = "github.com/Dgadavin/terraform-aws-course/modules/ssh/"
  ssh_key = "${var.ssh_key}"
}
