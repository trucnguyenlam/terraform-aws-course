resource "aws_instance" "jump-host" {
  ami = "${lookup(var.amis, var.region)}"
  instance_type = "${var.ec2_type}"
  count = 1
  vpc_security_group_ids = [ "${module.vpc.default_security_group}", "${aws_security_group.jump-host.id}"]
  key_name = "${module.ssh-keys.ssh_key_name}"
  associate_public_ip_address = true
  subnet_id = "${module.vpc.subnet_ids_public}"
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