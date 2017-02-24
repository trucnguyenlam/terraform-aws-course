module "vpc" {
  source = "github.com/Dgadavin/terraform-aws-course/tree/master/modules/vpc"
}

module "ssh-keys" {
  source = "github.com/Dgadavin/terraform-aws-course/tree/master/modules/ssh"
  ssh_key = "${var.ssh_key}"
}
