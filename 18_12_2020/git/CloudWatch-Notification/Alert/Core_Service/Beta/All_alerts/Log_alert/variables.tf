variable "AWS_REGION" {
    default = "eu-west-2"
}
variable "app_id" {
  type        = string
  description = "Application ID (e.g. `eg` or `cp`)"
  default     = "App15549"
}
variable "app_name" {
  type        = string
  description = "Name of the Application which can be get it form EDR"
  default     = "Simplify-Core-Services"
}
variable "env" {
  type        = string
  description = "Environment (e.g. `prod`, `dev`, `staging`)"
  default     = "Prod"
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
/*variable "namespace"{
  default= "CienaApplicationLogs"

}*/
variable "threshold_value"{
  default = 1
}
variable "metric_name" {
   type        = list
   default = ["service-order-app-error","crm-event-mgmt-app-errors","Cust-mgmt-int-app-error","party-mgmt-int-app-errors","resource-inv-int-app-errors","service-inventory-int-app-errors"]
}