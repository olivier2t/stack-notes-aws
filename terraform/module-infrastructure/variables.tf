##### Meta information

variable "customer" {
  description = "Name of the infrastructure (as used internally by Cycloid, the customer name)"
  default     = ""
}

variable "project" {
  description = "Name of the project"
  default     = "infrastructure"
}

#variable "env" {
#  description = "Name of the env (for display in the AWS console)"
#  default     = "infra"
#}

#variable "suffix" {
#  description = "Suffix for all resources names, useful if the infrastructure stack is deployed twice on the same AWS account"
#  default     = ""
#}

#variable "backup_bucket_prefix" {
#  description = "Prefix for the S3 backup bucket (change it if a bucket with the same name already exists) - defaults to '$${var.customer}-'"
#  default     = ""
#}

#variable "extra_tags" {
#  default = {}
#}

locals {
  standard_tags = {
    "cycloid.io" = "true"
    env          = var.env
    project      = var.project
    customer     = var.customer
  }
  merged_tags = merge(local.standard_tags, var.extra_tags)
}

#
# Variables
#
variable "vpc_cidr" {
    description = "The CIDR of the VPC"
    default = "10.0.0.0/16"
}

variable "vpc_private_subnets" {
    description = "The private subnets for the VPC"
    default = ["10.0.0.0/24", "10.0.2.0/24", "10.0.4.0/24"]
}

variable "vpc_public_subnets" {
    description = "The public subnets for the VPC"
    default = ["10.0.1.0/24", "10.0.3.0/24", "10.0.5.0/24"]
}

variable "vpc_azs" {
    description = "The availability zones of the VPC"
    default = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
}

variable "bastion_count" {
    description = "Number of bastions to create (use 0 if you want no bastion)"
    default = 1
}

variable "bastion_allowed_networks" {
    description = "Networks allowed to connect to the bastion using SSH"
    default = "0.0.0.0/0"
}

variable "bastion_instance_type" {
description = "Instance type for the bastion"
default = "t3.micro"
}


##### S3 bucket

#variable "create_s3_bucket_remote_state" {
#  description = "To know if a terraform_remote_state s3 bucket has to be created or not"
#  default     = false
#}

##### IAM and authorizations

#variable "create_infra_user" {
#  description = "If an admin user infra has to be created or not"
#  default     = false
#}

# variable "extra_admin_users" {
#   description = "List of users to give the administrator access role to"
#   default     = []
# }

# variable "readonly_users" {
#   description = "List of users to give a read-only access to"
#   default     = []
# }

# variable "readonly_groups" {
#   description = "List of groups to give a read-only access to"
#   default     = []
# }

# variable "create_backup_user" {
#   description = "If a backup user has to be created or not"
#   default     = false
# }

##### Keypair

variable "keypair_name" {
  description = "The human-readable keypair name to be used for instances deployment"
  default     = ""
}

variable "keypair_public" {
  description = "The public SSH key, for SSH access to newly-created instances"
}

##### Network environment

# Please note the VPCs are created even if we don't need them. That's because
# we can't add the count parameter to the modules yet.
# Oce we can "count" the modules, we may even use a list of maps, allowing to
# define any number of VPCs.

data "aws_region" "current" {}

data "aws_availability_zones" "available" {
  state = "available"
}

variable "zones" {
  description = "To use specific AWS Availability Zones."
  default     = []
}

locals {
  aws_availability_zones = length(var.zones) > 0 ? var.zones : data.aws_availability_zones.available.names
}

# Allow metrics (prometheus) to collect data from bastion
# variable "metrics_allowed_sg" {
#   default     = ""
#   description = "Security group allowed to reach metrics ports like the node exporter one"
# }

# Vpc endpoint

# variable "enable_dynamodb_endpoint" {
#   description = "Should be true if you want to provision a DynamoDB endpoint to the VPC"
#   default     = false
# }

# variable "enable_s3_endpoint" {
#   description = "Should be true if you want to provision an S3 endpoint to the VPC"
#   default     = false
# }

