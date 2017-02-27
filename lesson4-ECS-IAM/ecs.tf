resource "aws_ecs_cluster" "epam-test-cluster" {
  name = "${var.ecs_service_cluster}"
}

data "template_file" "nginx" {
  template = "${file("user-data/nginx_docker.json")}"

  vars {
    docker-image = "nginx:latest"
  }
}

resource "aws_ecs_task_definition" "nginx" {
  family                = "epam-test-nginx"
  container_definitions = "${data.template_file.nginx.rendered}"
}

resource "aws_ecs_service" "nginx" {
  name            = "nginx-service"
  cluster         = "${aws_ecs_cluster.epam-test-cluster.id}"
  task_definition = "${aws_ecs_task_definition.nginx.arn}"
  desired_count   = "1"
  iam_role        = "${aws_iam_role.default.arn}"
  deployment_maximum_percent = 100
  deployment_minimum_healthy_percent = 0

  load_balancer {
    elb_name       = "${aws_elb.elb.id}"
    container_name = "epam-test-nginx"
    container_port = 80
  }
}