provider "aws" {
        region = "eu-west-2"
        version = "~> 3.13"
}
data "aws_sns_topic" "my-alerts" {
  name = "App15549_Simplify-Core-Services_ECS-Dev_DevOps_Topic"
}
/*
resource "aws_cloudwatch_log_metric_filter" "app-eeror" {
  #for_each       = toset(var.log_group_name)
  name           = "Microservice_Error_Logs"  #pattern       = "] ERROR "
  pattern        = var.pattern_type
  #log_group_name = "${each.value}"  log_group_name = var.log_group_name
  metric_transformation {    name      = "Crm-event-mgmt-int-App-errors"
    #namespace = "Core-Integration-Application-logs"
    namespace = var.namespace
    value     = "1"
  }
}*/
resource "aws_cloudwatch_metric_alarm" "log-error" {
  for_each    = toset(var.metric_name)
  #for_each            = var.metric_name
  #alarm_name          = "${var.app_id}|${var.app_name}|ApplicationLogs|${each.key}|${each.value}|${var.threshold_value}|High"
  alarm_name          = "${var.app_id}|${var.app_name}|ApplicationLogs|${each.value}|${var.threshold_value}|High"

  #alarm_name = "test-service-log-error-alarm"
  #alarm_description   = "Log errors are too high"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  threshold           = var.threshold_value
  period              = 60
  alarm_description = <<EOF
  The Application Log erroor for has breatched the metric threshold value.
  Please find the below details of Metric.
    Application_ID:    ${var.app_id}
    Application_Name:  ${var.app_name}
    Platform_Name:     ${var.platform}
    Owner:             ${var.squadname}
    Enviornment:       ${var.env}
    Metric_Name:       ${each.value}
    Metric_value:      ${var.threshold_value}
    Severity:          High
  EOF
 #unit                = "Count"

  #namespace = var.namespace
  namespace = "CCTA-Coreservices-Integration"
  metric_name = "${each.value}"
  statistic   = "SampleCount"

  alarm_actions = ["${data.aws_sns_topic.my-alerts.arn}"]
 # ok_actions    = ["${data.aws_sns_topic.my-alerts.arn}"]


   /*dimensions = {
    LogGroupName = var.log_group_name
  }*/

}