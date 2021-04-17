variable "aws_region" {}

variable "vpc_cidr_block" {}
variable "public_az1_cidr_block" {}

variable "bastion_sg_ingress_cidr_rules" {}
variable "bastion_sg_egress_cidr_rules" {}

variable "bastion_ami" {}
variable "instance_type" {}
variable "keyname" {}