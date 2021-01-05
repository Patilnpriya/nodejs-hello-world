variable "AWS_REGION" {
    default = "eu-west-2"
}
#============ Details of Application==============
variable "app_id" {  type        = string
  description = "Application ID (e.g. `eg` or `cp`)"
  default     = "App15529"
}
variable "app_name" {
  type        = string
  description = "Name of the Application which can be get it form EDR"
  default     = "Ciena-Service-Fulfilment"
}
variable "env" {
  type        = string
  description = "Environment (e.g. `prod`, `dev`, `staging`)"
  default     = ""
}
variable "platform" {
  type        = string
  default     = "Simplify"
  description = "e.g.Simplify."
}variable "squadname" {  type        = string
  default     = "DevOps"
  description = "e.g.DevOps."
}
#============ Details of Instance ==============
variable "instance_id" {
  type        = string
  description = "Instance Id"
  default= ""
}
variable "ami_id" {
  type        = string
  description = "AMI Id"
  default= ""
}
variable "instance_type" {
  type        = string
  description = "Instance Type"
  default= ""
}
#============ Details of Metric Type ==============
variable "cpu_metric" {
    type        = string
  description = "Metric Name Or Type "
  default = "CPUUtilization"
}
variable "mem_metric" {
    type        = string
  description = "Metric Name or Type"
  default = "mem_used_percent"
}
variable "status_metric" {
    type        = string
  description = "Metric Name or Type"
  default = "StatusCheckFailed"
}
variable "instance_metric" {
    type        = string
  description = "Metric Name or Type"
  default = "StatusCheckFailed_Instance"
}
variable "disk_metric" {
    type        = string
  description = "Metric Name or Type"
  default = "disk_used_percent"
}
#============ Set Period==============
variable "low_period" {
  type        = number
  description = "Set the Low period"
  default     = 300
}
variable "high_period" {
  type        = number
  description = "Set the High period"
  default     =  60
}
#============ Set Threshold Value =============
variable "Medium_threshold_Value" {
  type        = number
  description = "Set the limit value "
  default     = 60
}
variable "High_threshold_Value" {
  type        = number
  description = "Set the limit value"
  default     = 75
}
variable "Critical_threshold_Value" {
  type        = number
  description = "Set the limit value "
  default     = 85
}