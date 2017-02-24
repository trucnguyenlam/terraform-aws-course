variable "short_name" {default = "example"}
variable "ssh_key" {}

resource "aws_key_pair" "deployer" {
  key_name = "key-${var.short_name}"
  public_key = "${file(var.ssh_key)}"
}

output "ssh_key_name" {
	value = "${aws_key_pair.deployer.key_name}"
}
