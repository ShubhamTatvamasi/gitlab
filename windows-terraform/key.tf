resource "random_uuid" "ssh_key_uuid" {}

resource "aws_key_pair" "win_key" {
  key_name   = "${var.project_name}-key-${random_uuid.ssh_key_uuid.result}"
  public_key = file(var.public_key_path)
}
