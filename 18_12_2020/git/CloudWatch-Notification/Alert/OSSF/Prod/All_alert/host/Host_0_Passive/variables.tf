variable "AWS_REGION" {
    default = "eu-west-2"
}
#============ Details of Application==============
variable "app_id" {
  type        = string
  description = "Application ID (e.g. `eg` or `cp`)"
  default     = "App15529"
}
variable "app_name" {
  type        = string
  description = "Name of the Application which can be get it form EDR"
  default     = "Ciena-Service-Order-Fulfilment"
}
variable "env" {
  type        = string
  description = "Environment (e.g. `prod`, `dev`, `staging`)"
  default     = "Prod-Host-0-Passive"
}
variable "platform" {
  type        = string
  default     = "Simplify"
  description = "e.g.Simplify."
}
variable "squadname" {
  type        = string
  default     = "DevOps"
  description = "e.g.DevOps."
}
#============ Details of Instance ==============
variable "instance_id" {
  type        = string
  description = "Instance Id"
  default= "i-0d4abc15762189b5f"
}
variable "ami_id" {
  type        = string
  description = "AMI Id"
  default= "ami-0b0dac855baed2946"
}
variable "instance_type" {
  type        = string
  description = "Instance Type"
  default= "m5.8xlarge"
}