data "aws_ami" "amazon_linux_2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}

resource "aws_instance" "gpu_spot_instance" {
  ami               = data.aws_ami.amazon_linux_2.id
  instance_type     = "g4dn.xlarge"
  availability_zone = "us-west-2a"

  instance_market_options {
    market_type = "spot"

    spot_options {
      max_price                      = "0.137"
      instance_interruption_behavior = "terminate"
    }
  }

  root_block_device {
    volume_size = 30
    volume_type = "gp3"
  }

  tags = merge(var.tags, {
    Name    = "gpu-instance"
    Purpose = "gpu-budget-aware"
  })
}
