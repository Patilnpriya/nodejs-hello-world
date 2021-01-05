provider "aws" {
        region = "eu-west-2"
        version = "~> 3.13"
}
data "aws_sns_topic" "my-alerts" {
  name = "App15529_Ciena-Service-Order-Fulfilment_EC2-Prod_DevOps_Lambda_Topic"
}
/*
resource "aws_cloudwatch_log_metric_filter" "app-eeror" {
  #for_each       = toset(var.log_group_name)
  name           = "Microservice_Error_Logs"
  #pattern       = "] ERROR "
  pattern        = var.pattern_type
  #log_group_name = "${each.value}"
  log_group_name = var.log_group_name

  metric_transformation {
    name      = "Crm-event-mgmt-int-App-errors"
    #namespace = "Core-Integration-Application-logs"
    namespace = var.namespace
    value     = "1"
  }
}*/
resource "aws_cloudwatch_metric_alarm" "log-error" {
  for_each       = var.metric_name
  alarm_name          = "${var.app_id}|${var.app_name}|ApplicationLogs|${each.key}|${each.value}|${var.threshold_value}|High"
  #alarm_name = "test-service-log-error-alarm"
  alarm_description   = "Log errors are too high"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  threshold           = var.threshold_value
  period              = 60
 #unit                = "Count"

  namespace = var.namespace
  #namespace = "CCTA-Coreservices-Integration"
  metric_name = "${each.value}"
  statistic   = "SampleCount"

  alarm_actions = ["${data.aws_sns_topic.my-alerts.arn}"]
 # ok_actions    = ["${data.aws_sns_topic.my-alerts.arn}"]


   /*dimensions = {
    LogGroupName = var.log_group_name
  }*/

}