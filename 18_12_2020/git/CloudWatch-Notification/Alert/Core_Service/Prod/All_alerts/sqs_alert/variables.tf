variable "env" {
 default = "Dev"

}
variable "app_id"{
 default = "App15549"
}
variable "AWS_REGION" {
    default = "eu-west-2"
}
#====== Details of application ======================================================
variable "app_name" {
  type        = string
  description = "The name of the ECS Service in the ECS cluster to monitor"
  default     = "Simplify-Core-Services"
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
variable "enabled" {
  type        = bool
  default     = true
  description = "Enable/disable resources creation"
}
variable "cluster_name" {
  type        = string
  description = "The name of the ECS cluster to monitor"
  default = "kano-coreservices-cluster"
}
variable "service_name" {
  type        = string
  description = "The name of the ECS Service in the ECS cluster to monitor"
  #default     = ["service-order-integrator","resource-inventory-integrator","supply-chain-integrator","customer-management-integrator","service-inventory-integrator","party-mgmt-int"]
  default     ="ccta-crm-event-mgmt-int"
}

# ====== Period==================================================================================
variable "high_period" {
  type        = number
  description = "Set the high period"
  default     =  60
}

#====== SQS Dimentions===================================================================
variable "queue_name" {
  type        = string
  description = "SQS Queue Names"
  default = "ccta-crm-event-mgmt-int"
}
#====== Metric Type======================================================================

variable "sqs_metric" {
  type        = string
  description = "Metric Name or Type"
  default = "ApproximateNumberOfMessagesVisible"
}

variable "sqs_threshold_value" {
    type        = number
  description = "Metric Name or Type"
  default = 600
}
