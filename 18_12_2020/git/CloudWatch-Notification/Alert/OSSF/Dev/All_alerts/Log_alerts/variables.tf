variable "AWS_REGION" {
    default = "eu-west-2"
}
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
  default     = "Beta"
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
variable "namespace"{
  default= "CienaApplicationLogs"

}
variable "threshold_value"{
  default = 3
}
variable "metric_name" {
   type        = map
   default     = {

    "Host0" = "H0BlueplanetLogErrorCount",
    "Host1" = "H1BlueplanetLogErrorCount",
    "Host2" = "H2BlueplanetLogErrorCount",
    "Host2-New" = "H2NewBlueplanetLogErrorCount",
    "Host1-New" = "H1NewBlueplanetLogErrorCount",
    "Host0-New" = "H0NewBlueplanetLogErrorCount"

   }

}