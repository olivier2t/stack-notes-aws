

output "deployment_bucket_name" {
  description = "S3 bucket name for the deployment bucket"
  value       = module.infrastructure.deployment_bucket_name
}

output "zones" {
  description = "AWS availability zones used"
  value       = module.infrastructure.zones
}

output "keypair_name" {
  description = "The deployment keypair name"
  value       = module.infrastructure.keypair_name
}

output "bastion_ip" {
  description = "The EIP attached to the bastion EC2 server"
  value       = module.infrastructure.bastion_ip
}

output "bastion_sg" {
  description = "The bastion security group ID."
  value       = module.infrastructure.bastion_sg
}

output "vpc_id" {
  description = "The VPC ID for the VPC"
  value       = module.infrastructure.vpc_id
}

output "vpc_cidr" {
  description = "The CIDR for the VPC"
  value       = module.infrastructure.vpc_cidr
}