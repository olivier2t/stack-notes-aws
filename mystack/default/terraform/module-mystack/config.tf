"locals" = {
  "tags_cycloid" = {
    "cycloid.io" = "true"

    "env" = "${var.env}"
  }

  "tags_stack" = {}
}

"provider" "aws" {
  "region" = "eu-west-1"
}

"resource" "aws_instance" "front" {
  "ami" = "111"

  "instance_type" = "t2.micro"

  "tags" = {
    "cycloid.io" = "true"

    "env" = "${var.env}"
  }
}

"resource" "aws_vpc" "myvpc" {
  "cidr_block" = "192.168.1.0/24"

  "tags" = {
    "cycloid.io" = "true"

    "env" = "${var.env}"
  }
}

"variable" "env" {
  "default" = "[PLACEHOLDER]"

  "type" = "string"
}

"variable" "project" {
  "default" = "[PLACEHOLDER]"

  "type" = "string"
}
