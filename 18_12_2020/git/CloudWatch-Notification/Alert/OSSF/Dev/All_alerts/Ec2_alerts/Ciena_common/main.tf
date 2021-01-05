provider "aws" {
    version = "~> 3.6"
    region  = var.AWS_REGION
}
module "ec2_alarms" {
  source                        = "/root/cloduwatch/EC2alerts_deploy/module"
  app_id                        = var.app_id
  app_name                      = var.app_name
  platform                      = var.platform
  squadname                     = var.squadname
  env                           = var.env
  # EC2 Instance Details
  instance_id                   = var.instance_id
  ami_id                        = var.ami_id
  instance_type                 = var.instance_type
}