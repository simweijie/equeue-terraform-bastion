provider "aws" {
  region  = var.aws_region
}

#----------------------------------------------------------------------------
# Data
#----------------------------------------------------------------------------
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc
# Get VPC by CIDR block
data "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block
}

# Get Data Tier Subnets by CIDR block
data "aws_subnet" "public_az1" {
  cidr_block = var.public_az1_cidr_block
}

#----------------------------------------------------------------------------
# Security Group
#----------------------------------------------------------------------------
resource "aws_security_group" "bastion_sg" {
  name   = "Bastion Security Group"
  vpc_id = data.aws_vpc.main.id
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule
# ingress for CIDR range
resource "aws_security_group_rule" "bastion_sg_ingress_cidr" {
  for_each = {
    for bastion_sg_ingress_cidr_rule in var.bastion_sg_ingress_cidr_rules: 
      "${bastion_sg_ingress_cidr_rule.description}-${bastion_sg_ingress_cidr_rule.protocol}" => bastion_sg_ingress_cidr_rule
  }

  type              = "ingress"
  security_group_id = aws_security_group.bastion_sg.id

  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  cidr_blocks       = each.value.cidrs
}

# egress for CIDR range
resource "aws_security_group_rule" "bastion_sg_egress_cidr" {
  for_each = {
    for bastion_sg_egress_cidr_rule in var.bastion_sg_egress_cidr_rules: 
      "${bastion_sg_egress_cidr_rule.description}-${bastion_sg_egress_cidr_rule.protocol}" => bastion_sg_egress_cidr_rule
  }

  type              = "egress"
  security_group_id = aws_security_group.bastion_sg.id

  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  cidr_blocks       = each.value.cidrs
}

#----------------------------------------------------------------------------
# Bastion
#----------------------------------------------------------------------------
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance
# Free tier 750hrs/month of t2.micro or t3.micro for 1 year
# resource "aws_instance" "bastion" {
#   ami           = var.bastion_ami
#   instance_type = var.instance_type
#   subnet_id = data.aws_subnet.public_az1.id
#   vpc_security_group_ids = [aws_security_group.bastion_sg.id]
#   key_name = var.keyname
#   associate_public_ip_address = true

#   tags = {
#     Name = "Bastion"
#   }

# #   user_data = data.template_file.bastion_userdata.rendered
# #   iam_instance_profile = var.bastion_instance_profile
# }