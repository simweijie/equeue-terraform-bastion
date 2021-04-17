terraform {
  backend "s3" {
    bucket = "nus-iss-equeue-terraform"
    key    = "bastion/tfstate"
    region = "us-east-1"
  }
}