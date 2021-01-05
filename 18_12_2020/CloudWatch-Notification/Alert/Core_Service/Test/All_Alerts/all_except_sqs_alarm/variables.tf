variable "AWS_REGION" {
    default = "eu-west-2"
}
#====== Details of application ======================================================
variable "app_id" {
  type        = string
  description = "APP_ID (e.g. `eg` or `cp`)"
  default     = "App15549"
}
variable "app_name" {
  type        = string
  description = "The name of the ECS Service in the ECS cluster to monitor"
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
  type        = list
  description = "The name of the ECS Service in the ECS cluster to monitor"
  default     = ["service-order-integrator","or-kci-notification","mop-service-order-int","ccta-crm-event-mgmt-int","resource-inventory-integrator","customer-management-integrator","service-inventory-integrator","party-mgmt-int"]

}

#====== Basic Metric Type================================================================================
variable "cpu_metric" {
    type        = string
  description = "Metric Name Or Type "
  default = "CPUUtilization"
}
variable "mem_metric" {
    type        = string
  description = "Metric Name or Type"
  default = "MemoryUtilization"
}
variable "running_task_metric" {
    type        = string
  description = "Metric Name Or Type "
  default = "RunningTaskCount"
}

# Set evaluation period
variable "evaluation_periods" {
    type        = number
  description = "Metric Name or Type"
  default = 1
}

# ====== Period==================================================================================
variable "high_period" {
  type        = number
  description = "Set the high period"
  default     =  60
}
# #====== Threshold Value ===========================================================================
variable "Critical_threshold_value" {
  type        = number
  description = "Set the limit value "
  default     = 85
}
variable "running_task_threshold" {
  type        = number
  description = "The no of running task count"
  default     = 1
}
#====== ApiGateway Dimentions===========================================================
variable "api_name" {
  type        = string
  description = "The name of the ECS Service in the ECS cluster to monitor"
  default     = "bt-coreservices"
}
variable "private_api_name" {
  type        = string
  description = "The name of the ECS Service in the ECS cluster to monitor"
  default     = "bt-coreservices-private"
}
variable "ssl_api_name" {
  type        = string
  description = "The name of the ECS Service in the ECS cluster to monitor"
  default     = "bt-coreservices-ma-ssl"
}
variable "resources" {
  description = "Methods that have Cloudwatch alarms enabled"
  type        = map
  default     = {
    "/customermanagement/account/notification/{source}"          = "POST",
    "/customermanagement/account/{id}"                           = "GET",
    "/customermanagement/contact/{id}"                           = "GET",
    "/partymanagement/notification"                              = "POST",
    "/resourceinventorymanagement/notification"                  = "POST",
    "/openreach/kcinotification"                                 = "POST",
    "serviceordermanagement/mop-serviceorder-notifications"      = "POST",
    "/serviceordermanagement/notification"                       = "POST",
    "/serviceordermanagement/serviceorder"                       = "POST",
    "/serviceordermanagement/mop-serviceorder"                   = "POST",
    "/serviceinventorymanagement/notification"                   = "POST",
    "/serviceinventorymanagement/notification/{consumer-filter}" = "POST"
    #"/productinventorymanagement/notification"                  = "POST",
  }
}
variable "stage" {
  description = "API Gateway stage"
  type        = string
  default     = "test"
}
#====== SQS Dimentions===================================================================
variable "queue_name" {
  type        = list
  description = "SQS Queue Names"
  default = ["ccta-ORKCIToBP_DLQ","ccta-PrtyMgmtToServiceNow_DLQ","ccta-crm-event-mgmt-int_DLQ","ccta-mop-service-order-to-vlocity_DLQ"]
 # All Kano Will be replaced by ccta- ["kano-RrcInvToServiceNow_DLQ","kano-SvcInvToServiceNow_DLQ","kano-SvcOrdToVlocity_DLQ","kano-SvcOrdToServiceNow_DLQ"]
}
#====== Metric Type======================================================================
variable "metric_5x" {
  type        = string
  description = "Metric Name Or Type "
  default = "5XXError"
}
variable "metric_4x" {
  type        = string
  description = "Metric Name or Type"
  default = "4XXError"
}
variable "latency_metric" {
  type        = string
  description = "Metric Name Or Type "
  default = "Latency"
}
variable "sqs_metric" {
  type        = string
  description = "Metric Name or Type"
  default = "ApproximateNumberOfMessagesVisible"
}
#==================Set Threshold Values=============================================================
variable "threshold_value" {
    type        = number
  description = "Metric Name or Type"
  default = 1
}
variable "latency_threshold_value" {
    type        = number
  description = "Metric Name or Type"
  default = 10000
}
#======================== Auto Scaling Variables ======================================================
variable "max_capacity" {
  description = "Maximum number of tasks to scale to"
  default     = "2"
}
variable "min_capacity" {
  description = "Minimum number of tasks to scale to"
  default     = "1"
}

variable "scale_up_count" {
  description = "The number of members by which to scale up, when the adjustment bounds are breached. Should always be positive value"
  default     = "1"
}
variable "scale_down_count" {
  description = "The number of members by which to scale down, when the adjustment bounds are breached. Should always be negative value"
  default     = "-1"
}

variable "scale_down_upper_bound" {
  description = "The upper bound for the difference between the alarm threshold and the CloudWatch metric. Without a value, AWS will treat this bound as infinity"
  default     = "0"
}
variable "scale_up_lower_bound" {
  description = "The lower bound for the difference between the alarm threshold and the CloudWatch metric. Without a value, AWS will treat this bound as negative infinity"
  default     = "0"
}