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
  default     = "Dev-Common"
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
  default= "i-047916ccb296990db"
}
variable "ami_id" {
  type        = string
  description = "Image ID "
  default= "ami-09068d6ae2cc1683f"
}
variable "instance_type" {
  type        = string
  description = "Instance Type"
  default= "m5.4xlarge"
}