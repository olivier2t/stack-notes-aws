output "keypair_name" {
  value = var.keypair_name != "" ? var.keypair_name : "${var.customer}-${var.project}${var.suffix}"
}

output "bastion_ip" {
  value = aws_eip.bastion.*.public_ip
}

output "bastion_sg" {
  value = aws_security_group.bastion[0].id
}

output "iam_ses_smtp_user_key" {
  value = aws_iam_access_key.ses_smtp_user.id
}

output "iam_ses_smtp_user_secret" {
  value = aws_iam_access_key.ses_smtp_user.ses_smtp_password_v4
}

output "deployment_bucket_name" {
  value = aws_s3_bucket.deployment.id
}

output "zones" {
  value = local.aws_availability_zones
}

#
# VPC
#
output "vpc_id" {
  value = module.vpc.vpc_id
}

output "vpc_nat_public_ips" {
  value = module.vpc.nat_public_ips
}

output "bastion_vpc_sg_ids" {
  value = element(aws_security_group.allow_bastion2vpc.*.id, 0)
}