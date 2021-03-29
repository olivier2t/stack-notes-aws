#
# Create VPC
#

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "~> v2.17"

  name = "${var.customer}-vpc"
  cidr = var.vpc_cidr
  private_subnets = var.infra_private_subnets
  public_subnets = var.infra_public_subnets
  azs = var.vpc_azs

  enable_nat_gateway = true
  single_nat_gateway = true
}

resource "aws_security_group" "allow_bastion2vpc" {
  count = var.bastion_count > 0 ? 1 : 0

  name = "allow_bastion2vpc"
  description = "Allow SSH traffic from the bastion to the VPC"
  vpc_id = module.vpc.vpc_id
  
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    security_groups = [aws_security_group.bastion[0].id]
    self = false
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}