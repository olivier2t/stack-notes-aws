resource "aws_security_group" "allow_internet2bastion" {
  name = "allow_internet2bastion"
  description = "Allow SSH traffic from the internet to the bastion"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.bastion_allowed_networks]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_eip" "bastion" {
  instance = aws_instance.bastion.id
  vpc      = true
}

resource "aws_instance" "bastion" {
  ami           = data.aws_ami.debian_stretch.id
  instance_type = var.bastion_instance_type
  key_name      = var.keypair_name != "" ? var.keypair_name : "${var.customer}-${var.project}"

  vpc_security_group_ids = aws_security_group.bastion.id

  subnet_id               = element(module.vpc.public_subnets, 0)

  lifecycle {
    ignore_changes = [ami]
  }
}