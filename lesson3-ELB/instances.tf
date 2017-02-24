resource "aws_instance" "instance" {
  ami = "${lookup(var.amis, var.region)}"
  instance_type = "${var.ec2_type}"
  count = "${var.instance_count}"
  vpc_security_group_ids = [ "${module.vpc.default_security_group}", "${aws_security_group.jump-host.id}"]
  key_name = "${module.ssh-keys.ssh_key_name}"
  associate_public_ip_address = false
  subnet_id = "${module.vpc.subnet_ids_private}"
  root_block_device {
    delete_on_termination = true
    volume_size = "${var.ebs_volume_size}"
    volume_type = "${var.ebs_volume_type}"
  }
  tags {
    Name = "${var.short_name}-${var.role}-${format(var.count_format, count.index+1)}"
    sshUser = "${var.ssh_username}"
    role = "${var.role}"
  }
}

resource "aws_elb" "elb" {
  name = "${var.short_name}-${var.role}-elb"
  internal = "true"
  subnets = ["${module.vpc.subnet_ids_private}"]
  security_groups = [ "${module.vpc.default_security_group}", "${aws_security_group.elb-group.id}"]
  listener {
    instance_port = "8080"
    instance_protocol = "tcp"
    lb_port = 80
    lb_protocol = "tcp"
  }
  instances = ["${aws_instance.instance.*.id}"]
}