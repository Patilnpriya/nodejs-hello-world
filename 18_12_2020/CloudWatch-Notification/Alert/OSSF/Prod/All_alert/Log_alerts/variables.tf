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
variable "namespace"{
  default= "CienaApplicationLogs"

}
variable "threshold_value"{
  default = 3
}
variable "metric_name" {
   type        = map
   default     = {

    "Host0-Active" = "H0ABlueplanetErrorCount",
    "Host1-Active" = "H1ABlueplanetErrorCount",
    "Host2-Active" = "H2ABlueplanetErrorCount",
    "Host2-Passive" = "H2PBluePlanetErrorCount",
    "Host1-Passive" = "H1PBluePlanetErrorCount",
    "Host0-Passive" = "H0PBluePlanetErrorCount",
    "Host0-ACTIVE" = "H0ASolutionBkupErrorCount"

   }

}