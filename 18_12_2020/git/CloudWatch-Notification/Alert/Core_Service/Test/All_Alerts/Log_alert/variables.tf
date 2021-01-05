variable "AWS_REGION" {
    default = "eu-west-2"
}variable "app_id" {
  type        = string
  description = "Application ID (e.g. `eg` or `cp`)"
  default     = "App155249"
}
variable "app_name" {
  type        = string
  description = "Name of the Application which can be get it form EDR"
  default     = "Simplify-Core-Services"
  
}
variable "env" {
  type        = string
  description = "Environment (e.g. `prod`, `dev`, `staging`)"
  default     = "Test"
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
  default = 1
}

variable "metric_name" {
   type        = list
   default     = ["ProductLogError","crm-envet-app-error","Customer-Management-Errors","MopSerLogError","party-mgmt-Log-errors","Resource-Inventory-Errors","Service-Inventory-Errors","Service-Order-Errors","test-info-pattern-or-kci"]

}