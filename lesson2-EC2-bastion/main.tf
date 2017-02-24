variable "vpc_subnet_ids_ec2" {}
variable "ssh_key_pair" {}
variable "source_ami" {}
variable "security_group_ids" {}

resource "aws_instance" "jump-host" {
  ami = "${lookup(var.amis, var.region)}"
  instance_type = "${var.ec2_type}"
  count = 1
  vpc_security_group_ids = [ "${split(",", var.security_group_ids)}"]
  key_name = "${var.ssh_key_pair}"
  associate_public_ip_address = true
  subnet_id = "${var.vpc_subnet_ids_ec2}"
  root_block_device {
    delete_on_termination = true
    volume_size = "${var.ebs_volume_size}"
    volume_type = "${var.ebs_volume_type}"
  }
  tags {
    Name = "${var.short_name}-${var.role}"
    sshUser = "${var.ssh_username}"
    role = "${var.role}"
  }
}
