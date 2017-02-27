data "template_file" "init" {
  template = "${file("user-data/init.tpl")}"
  vars {
    cluster_name = "${var.ecs_service_cluster}"
  }
}

resource "aws_instance" "instance" {
  ami = "${lookup(var.amis, var.region)}"
  instance_type = "${var.ec2_type}"
  count = "${var.instance_count}"
  vpc_security_group_ids = [ "${module.vpc.default_security_group}", "${aws_security_group.jump-host.id}"]
  key_name = "${module.ssh-keys.ssh_key_name}"
  user_data = "${data.template_file.init.rendered}"
  iam_instance_profile = "${aws_iam_instance_profile.default.name}"
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
  internal = "false"
  subnets = ["${module.vpc.subnet_ids_private}", "${module.vpc.subnet_ids_public}"]
  security_groups = [ "${module.vpc.default_security_group}", "${aws_security_group.elb-group.id}"]
  listener {
    instance_port = "80"
    instance_protocol = "tcp"
    lb_port = 80
    lb_protocol = "tcp"
  }
}