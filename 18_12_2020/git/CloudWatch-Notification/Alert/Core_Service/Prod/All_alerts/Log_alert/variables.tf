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
  default     = "Dev"
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
variable "threshold_value"{
  default = 3
}

variable "metric_name" {
   type        = list
   default     = [" service-order-log-error","resource-log-error","ProductIntErrorCount","PartyIntErrorCount","CustMgmtIntLogErrorCount","MobSerIntErrorCount","OrKciIntErrorCount","ServiceInvLogErrorCount"]

}