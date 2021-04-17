#----------------------------------------------------------------------------
# AWS
#----------------------------------------------------------------------------
aws_region = "us-east-1"

#----------------------------------------------------------------------------
# General
#----------------------------------------------------------------------------
vpc_cidr_block          = "10.0.0.0/16"
public_az1_cidr_block   = "10.0.0.0/20"

#----------------------------------------------------------------------------
# Security Group
#----------------------------------------------------------------------------
bastion_sg_ingress_cidr_rules = [
  { from_port: 22, to_port: 22, cidrs: ["116.15.232.87/32"], protocol: "tcp", description: "Whitelisted IP 1" }
]

bastion_sg_egress_cidr_rules = [
  { from_port: 22, to_port: 22, cidrs: ["10.0.0.0/16"], protocol: "tcp", description: "ssh to VPC" },
  { from_port: 80, to_port: 80, cidrs: ["10.0.0.0/16"], protocol: "tcp", description: "http to VPC" },
  { from_port: 443, to_port: 443, cidrs: ["10.0.0.0/16"], protocol: "tcp", description: "https to VPC" },
  { from_port: 3306, to_port: 3306, cidrs: ["10.0.0.0/16"], protocol: "tcp", description: "db to VPC" }
]

#----------------------------------------------------------------------------
# Bastion
#----------------------------------------------------------------------------
bastion_ami = "ami-0915bcb5fa77e4892" # amazon linux # ami-02642c139a9dfb378 - windows 2019 server
instance_type = "t2.micro"
keyname = "bastion-key"