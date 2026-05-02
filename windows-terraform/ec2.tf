module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 6.4"

  name = var.project_name

  create_spot_instance      = var.spot_instance
  spot_type                 = var.spot_type
  spot_wait_for_fulfillment = true

  ami                    = data.aws_ami.windows.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.win_key.key_name
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  subnet_id              = data.aws_subnets.filtered.ids[0]

  root_block_device = {
    type = var.volume_type
    size = var.volume_size
  }

  tags = {
    Name = var.project_name
  }
}
