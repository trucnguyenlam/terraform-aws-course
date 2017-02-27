resource "aws_security_group" "jump-host" {
  name = "${var.short_name}-jump-host"
  description = "Allow inbound traffic for jump-host"
  vpc_id = "${module.vpc.vpc_id}"

  ingress { # SSH
    from_port = 0
    to_port = 65535
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress { # ICMP
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "elb-group" {
  name = "${var.short_name}-elb-group"
  description = "Allow inbound traffic for jump-host"
  vpc_id = "${module.vpc.vpc_id}"

  ingress { # SSH
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress { # ICMP
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}