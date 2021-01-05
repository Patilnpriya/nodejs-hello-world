provider "aws" {
        region = "eu-west-2"
        version = "~> 3.0"
}
data "aws_sns_topic" "my-alerts" {
  name = "App15549_Simplify-Core-Services_ECS-Dev_DevOps_Topic"
}
resource "aws_iam_role" "ecs_autoscale_role" {
  name               = "ccta-coreservices-ecs-autoscale-role"
  permissions_boundary = "arn:aws:iam::016818321538:policy/DcpPermissionsBoundary"
  assume_role_policy = "${file("${path.module}/policies/ecs-autoscale-role.json")}"
  tags =  {
        Application_ID          = "${var.app_id}"
        Environment             = "${var.env}"
        Application_Name        = "${var.cluster_name}-autoscale"
        Owner                   = "Terraform"
        Platform                = var.platform
      }
}
resource "aws_iam_role_policy" "ecs_autoscale_role_policy" {
  name   = "ccta-coreservices-ecs-autoscale-role-policy"
  policy = "${file("${path.module}/policies/ecs-autoscale-role-policy.json")}"
  role   = aws_iam_role.ecs_autoscale_role.id
  /*tags =  {
        Application_ID          = "${var.app_id}"
        Environment             = "${var.env}"
       Application_Name        = "${var.cluster_name}-autoscale"
       Owner                   = "Terraform"
        Platform                = var.platform
     }*/
}
resource "aws_appautoscaling_target" "cpu_target" {
  for_each           = toset(var.service_name)
  service_namespace  = "ecs"
  resource_id        = "service/${var.cluster_name}/${each.value}"
  #resource_id        = "service/${var.cluster_name}/${each.value}"
  #resource_id        = "service/kano-coreservices-cluster/${aws_ecs_service.ecs_service_def["${each.key}"].name}"
  scalable_dimension = "ecs:service:DesiredCount"
  role_arn           = "arn:aws:iam::016818321538:role/aws-service-role/ecs.application-autoscaling.amazonaws.com/AWSServiceRoleForApplicationAutoScaling_ECSService"
  min_capacity       = var.min_capacity
  max_capacity       = var.max_capacity
}

resource "aws_appautoscaling_policy" "scale_up" {
  for_each                = toset(var.service_name)
  name                    = "${var.env}-${each.value}-cpu_mem_high_scale_up"
  service_namespace       = "ecs"
  resource_id             = "service/${var.cluster_name}/${each.key}"
  #resource_id            = "service/${aws_ecs_cluster.ecs-cluster.name}/${aws_ecs_service.ecs_service_def["${each.key}"].name}"
  #resource_id            = "service/kano-coreservices-cluster/${aws_ecs_service.ecs_service_def["${each.key}"].name}"
  scalable_dimension      = "ecs:service:DesiredCount"


  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Maximum"

    step_adjustment {
      metric_interval_lower_bound = var.scale_up_lower_bound
      scaling_adjustment = var.scale_up_count
    }
  }

  #depends_on = ["aws_appautoscaling_target.target["${each.key}"]"]
}
#-------------------------------------------------------------
#set upper bound value Date : 29-10-2020
#-------------------------------------------------------------
/*resource "aws_appautoscaling_policy" "scale_down" {
  for_each                = toset(var.service_name)
  name                    = "${var.env}-${each.value}-cpu_mem_low_scale_down"
  service_namespace       = "ecs"
  resource_id             = "service/${var.cluster_name}/${each.key}"
  #resource_id        = "service/${var.cluster_name}/${each.value}"
  #resource_id             = "service/${aws_ecs_cluster.ecs-cluster.name}/${aws_ecs_service.ecs_service_def["${each.key}"].name}"
  #resource_id        = "service/kano-coreservices-cluster/${aws_ecs_service.ecs_service_def["${each.key}"].name}"
  scalable_dimension      = "ecs:service:DesiredCount"

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Maximum"

    step_adjustment {
      metric_interval_upper_bound = var.scale_down_upper_bound
      scaling_adjustment = var.scale_down_count
    }
  }

  #depends_on = ["aws_appautoscaling_target.target["${each.key}"]"]
}
*/
#--------------------------------------------------------------------------------------------------------
#Terraform module creates Cloudwatch Alarm on AWS for monitoriing Critical Usage of CPU Utilization.
#--------------------------------------------------------------------------------------------------------
resource "aws_cloudwatch_metric_alarm" "cpu_utilization_critical" {
  for_each            = toset(var.service_name)
  alarm_name          = "${var.app_id}|${var.app_name}|ECS-${var.env}|${each.value}|Cpu-Utilization|${var.Critical_threshold_value}|Critical"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.evaluation_periods
  metric_name         = var.cpu_metric
  namespace           = "AWS/ECS"
  period              = var.high_period
  statistic           = "Average"
  threshold           = var.Critical_threshold_value
  alarm_description   = "This metric monitors ECS CPU utilization of : \n Application_ID: ${var.app_id}  \n Application_Name: ${var.app_name}  \n Service_Name: ${each.value}  \n Platform_Name: ${var.platform}  \n Environment: ${var.env} \n Owner: ${var.squadname}  \n Metric_Type: ${var.cpu_metric} \n Metric_value: ${var.Critical_threshold_value}  \n Severity: Critical"
  alarm_actions       = ["${data.aws_sns_topic.my-alerts.arn}","${aws_appautoscaling_policy.scale_up["${each.key}"].arn}"]


 dimensions = {
    ClusterName = var.cluster_name
    ServiceName = "${each.value}"

  }
}
#------------------------------------------------------------------------------------------------------------
#Terraform module creates Cloudwatch Alarm on AWS for monitoriing Critical Usage of Memory Utilization.
#------------------------------------------------------------------------------------------------------------
resource "aws_cloudwatch_metric_alarm" "memory_utilization_critical" {
  for_each            = toset(var.service_name)
  alarm_name          = "${var.app_id}|${var.app_name}|ECS-${var.env}|${each.value}|Memory-Utilization|${var.Critical_threshold_value}|Critical"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.evaluation_periods
  metric_name         = var.mem_metric
  namespace           = "AWS/ECS"
  period              = var.high_period
  statistic           = "Maximum"
  threshold           = var.Critical_threshold_value

  alarm_description = "This metric monitors ECS Memory utilization of : \n Application_ID: ${var.app_id}  \n Application_Name: ${var.app_name}  \n Service_Name:  ${each.value} \n Platform_Name: ${var.platform}  \n Environment: ${var.env} \n Owner: ${var.squadname} \n Metric_Type: ${var.mem_metric} \n Metric_value: ${var.Critical_threshold_value}  \n Severity: High"
  alarm_actions             = ["${data.aws_sns_topic.my-alerts.arn}","${aws_appautoscaling_policy.scale_up["${each.key}"].arn}"]


  dimensions = {
    ClusterName = var.cluster_name
    ServiceName = "${each.value}"

  }

}
#-----------------------------------------------------------------------------------
#Terraform module creates Cloudwatch Alarm on AWS for monitoriing Running Task.
#-----------------------------------------------------------------------------------
resource "aws_cloudwatch_metric_alarm" "running_task" {
  for_each            = toset(var.service_name)
  alarm_name          = "${var.app_id}|${var.app_name}|ECS-${var.env}|${each.value}|Running-Task-Count|${var.running_task_threshold}|Critical"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = var.evaluation_periods
  metric_name         = var.running_task_metric
  namespace           = "ECS/ContainerInsights"
  period              = var.high_period
  statistic           = "Maximum"
  threshold           = var.running_task_threshold
  alarm_description = "This metric monitors running Task Count of ECS Cluster : \n Application_ID: ${var.app_id}  \n Application_Name: ${var.app_name}  \n Service_Name:  ${each.value} \n Platform_Name: ${var.platform} \n Environment: ${var.env} \n Owner: ${var.squadname}  \n Metric_Type: ${var.running_task_metric} \n Metric_value: ${var.running_task_threshold}  \n Severity: Critical"
  alarm_actions             = ["${data.aws_sns_topic.my-alerts.arn}"]

  dimensions = {
    ClusterName = var.cluster_name
    ServiceName = "${each.value}"

  }

}
#====================ApiGateways Alarm =================================================================
#-------------------------------------------------------------------------------------------------------
#Terraform module creates Cloudwatch Alarm on AWS for 5XXError Api Count.
#-------------------------------------------------------------------------------------------------------
resource "aws_cloudwatch_metric_alarm" "gateway_error_5xx" {
  for_each            = var.resources
  alarm_name          = "${var.app_id}|${var.app_name}|ApiGateway-${var.env}|${var.api_name}|${each.key}|${each.value}|${var.metric_5x}|${var.threshold_value}|High"
  comparison_operator = "GreaterThanThreshold"
  treat_missing_data  = "notBreaching"
  metric_name         = var.metric_5x
  namespace           = "AWS/ApiGateway"
  period              = 60
  evaluation_periods  = 1
  threshold           = var.threshold_value
  statistic           = "Maximum"
  unit                = "Count"
  alarm_description = <<EOF
 The ${each.key} resource of ${var.api_name} Api has exceeded it's  ${var.metric_5x} threshold value.
 Please find the below details of ApiGateway Metric.
  Application_ID:    ${var.app_id}
  Application_Name:  ${var.app_name}
  Service_Name:      ${each.key}
  Platform_Name:     ${var.platform}
  Owner:             ${var.squadname}
  Enviornment:       ${var.env}
  ApiName:           ${var.api_name}
  Resource_Name:     ${each.key}
  Method:            ${each.value}
  Stage:             ${var.stage}
  Metric_Name:       ${var.metric_5x}
  Metric_value:      ${var.threshold_value}
  Severity:          High
 EOF

  alarm_actions             = ["${data.aws_sns_topic.my-alerts.arn}"]


  dimensions = {
    ApiName = var.api_name
    Resource = "${each.key}"
    Method =   "${each.value}"
    Stage = var.stage
  }
}
#-----------------------------------------------------------------------------------
#Terraform module creates Cloudwatch Alarm on AWS for 4XXError Count.
#-----------------------------------------------------------------------------------
resource "aws_cloudwatch_metric_alarm" "gateway_error_4xx" {
  for_each            = var.resources
  alarm_name          = "${var.app_id}|${var.app_name}|ApiGateway-${var.env}|${var.api_name}|${each.key}|${each.value}|${var.metric_4x}|${var.threshold_value}|High"
  comparison_operator = "GreaterThanThreshold"
  treat_missing_data  = "notBreaching"
  metric_name         = var.metric_4x
  namespace           = "AWS/ApiGateway"
  period              = 60
  evaluation_periods  = 1
  threshold           = var.threshold_value
  statistic           = "Maximum"
  unit                = "Count"

  alarm_description = <<EOF
 The ${each.key} resource of ${var.api_name} Api has exceeded it's  ${var.metric_4x} threshold value.
 Please find the below details of ApiGateway Metric.
  Application_ID:    ${var.app_id}
  Application_Name:  ${var.app_name}
  Service_Name:      ${each.key}
  Platform_Name:     ${var.platform}
  Owner:             ${var.squadname}
  Enviornment:       ${var.env}
  ApiName:           ${var.api_name}
  Resource_Name:     ${each.key}
  Method:            ${each.value}
  Stage:             ${var.stage}
  Metric_Name:       ${var.metric_4x}
  Metric_value:      ${var.threshold_value}
  Severity:          High


 EOF

  alarm_actions             = ["${data.aws_sns_topic.my-alerts.arn}"]

  dimensions = {
    ApiName = var.api_name
    Resource = "${each.key}"
    Method =   "${each.value}"
    Stage = var.stage
  }
}
#-----------------------------------------------------------------------------------
#Terraform module creates Cloudwatch Alarm on AWS for Latency alarm in Miliseconds.
#-----------------------------------------------------------------------------------
resource "aws_cloudwatch_metric_alarm" "gateway_latency" {
  for_each            = var.resources
  alarm_name          = "${var.app_id}|${var.app_name}|ApiGateway-${var.env}||${var.api_name}|${each.key}|${each.value}|{var.latency_metric}|${var.latency_threshold_value}|High"
  comparison_operator = "GreaterThanThreshold"
  treat_missing_data  = "notBreaching"
  metric_name         = var.latency_metric
  namespace           = "AWS/ApiGateway"
  period              = 60
  evaluation_periods  = 1
  threshold           = var.latency_threshold_value
  statistic           = "Maximum"
  unit                = "Milliseconds"

  alarm_description = <<EOF
The ${each.key} resource of ${var.api_name} Api has exceeded it's  ${var.latency_metric} threshold value.
 Please find the below details of ApiGateway Metric.
  Application_ID:    ${var.app_id}
  Application_Name:  ${var.app_name}
  Service_Name:      ${each.key}
  Platform_Name:     ${var.platform}
  Owner:             ${var.squadname}
  Enviornment:       ${var.env}
  ApiName:           ${var.api_name}
  Resource_Name:     ${each.key}
  Method:            ${each.value}
  Stage:             ${var.stage}
  Metric_Name:       ${var.latency_metric}
  Metric_value:      ${var.latency_threshold_value}
  Severity:          High

 EOF
  alarm_actions             = ["${data.aws_sns_topic.my-alerts.arn}"]


  dimensions = {
    ApiName = var.api_name
    Resource = "${each.key}"
    Method =   "${each.value}"
    Stage = var.stage
  }
}
#====================ApiGateways Alarm =================================================================
#-------------------------------------------------------------------------------------------------------
#Terraform module creates Cloudwatch Alarm on AWS for 5XXError Api Count.
#-------------------------------------------------------------------------------------------------------
resource "aws_cloudwatch_metric_alarm" "gateway_error_5xx_private" {
  for_each            = var.resources
  alarm_name          = "${var.app_id}|${var.app_name}|ApiGateway-${var.env}|${var.private_api_name}|${each.key}|${each.value}|${var.metric_5x}|${var.threshold_value}|High"
  comparison_operator = "GreaterThanThreshold"
  treat_missing_data  = "notBreaching"
  metric_name         = var.metric_5x
  namespace           = "AWS/ApiGateway"
  period              = 60
  evaluation_periods  = 1
  threshold           = var.threshold_value
  statistic           = "Maximum"
  unit                = "Count"
  alarm_description = <<EOF
 The ${each.key} resource of ${var.private_api_name} Api has exceeded it's  ${var.metric_5x} threshold value.
 Please find the below details of ApiGateway Metric.
  Application_ID:    ${var.app_id}
  Application_Name:  ${var.app_name}
  Service_Name:      ${each.key}
  Platform_Name:     ${var.platform}
  Owner:             ${var.squadname}
  Enviornment:       ${var.env}
  ApiName:           ${var.private_api_name}
  Resource_Name:     ${each.key}
  Method:            ${each.value}
  Stage:             ${var.stage}
  Metric_Name:       ${var.metric_5x}
  Metric_value:      ${var.threshold_value}
  Severity:          High
 EOF

  alarm_actions             = ["${data.aws_sns_topic.my-alerts.arn}"]


  dimensions = {
    ApiName = var.private_api_name
    Resource = "${each.key}"
    Method =   "${each.value}"
    Stage = var.stage
  }
}
#-----------------------------------------------------------------------------------
#Terraform module creates Cloudwatch Alarm on AWS for 4XXError Count.
#-----------------------------------------------------------------------------------
resource "aws_cloudwatch_metric_alarm" "gateway_error_4xx_private" {
  for_each            = var.resources
  alarm_name          = "${var.app_id}|${var.app_name}|ApiGateway-${var.env}|${var.private_api_name}|${each.key}|${each.value}|${var.metric_4x}|${var.threshold_value}|High"
  comparison_operator = "GreaterThanThreshold"
  treat_missing_data  = "notBreaching"
  metric_name         = var.metric_4x
  namespace           = "AWS/ApiGateway"
  period              = 60
  evaluation_periods  = 1
  threshold           = var.threshold_value
  statistic           = "Maximum"
  unit                = "Count"

  alarm_description = <<EOF
 The ${each.key} resource of ${var.private_api_name} Api has exceeded it's  ${var.metric_4x} threshold value.
 Please find the below details of ApiGateway Metric.
  Application_ID:    ${var.app_id}
  Application_Name:  ${var.app_name}
  Service_Name:      ${each.key}
  Platform_Name:     ${var.platform}
  Owner:             ${var.squadname}
  Enviornment:       ${var.env}
  ApiName:           ${var.private_api_name}
  Resource_Name:     ${each.key}
  Method:            ${each.value}
  Stage:             ${var.stage}
  Metric_Name:       ${var.metric_4x}
  Metric_value:      ${var.threshold_value}
  Severity:          High


 EOF

  alarm_actions             = ["${data.aws_sns_topic.my-alerts.arn}"]

  dimensions = {
    ApiName = var.private_api_name
    Resource = "${each.key}"
    Method =   "${each.value}"
    Stage = var.stage
  }
}
#-----------------------------------------------------------------------------------
#Terraform module creates Cloudwatch Alarm on AWS for Latency alarm in Miliseconds.
#-----------------------------------------------------------------------------------
resource "aws_cloudwatch_metric_alarm" "gateway_latency_private" {
  for_each            = var.resources
  alarm_name          = "${var.app_id}|${var.app_name}|ApiGateway-${var.env}|${var.private_api_name}|${each.key}|${each.value}|${var.latency_metric}|${var.latency_threshold_value}|High"
  comparison_operator = "GreaterThanThreshold"
  treat_missing_data  = "notBreaching"
  metric_name         = var.latency_metric
  namespace           = "AWS/ApiGateway"
  period              = 60
  evaluation_periods  = 1
  threshold           = var.latency_threshold_value
  statistic           = "Maximum"
  unit                = "Milliseconds"

  alarm_description = <<EOF
The ${each.key} resource of ${var.private_api_name} Api has exceeded it's  ${var.latency_metric} threshold value.
 Please find the below details of ApiGateway Metric.
  Application_ID:    ${var.app_id}
  Application_Name:  ${var.app_name}
  Service_Name:      ${each.key}
  Platform_Name:     ${var.platform}
  Owner:             ${var.squadname}
  Enviornment:       ${var.env}
  ApiName:           ${var.private_api_name}
  Resource_Name:     ${each.key}
  Method:            ${each.value}
  Stage:             ${var.stage}
  Metric_Name:       ${var.latency_metric}
  Metric_value:      ${var.latency_threshold_value}
  Severity:          High

 EOF
  alarm_actions             = ["${data.aws_sns_topic.my-alerts.arn}"]


  dimensions = {
    ApiName = var.private_api_name
    Resource = "${each.key}"
    Method =   "${each.value}"
    Stage = var.stage
  }
}
#==============================SQS Queue================================================================
#-------------------------------------------------------------------------------------------------------
#Terraform module creates Cloudwatch Alarm on AWS for sqs with approximate messages visible in the queue.
#-------------------------------------------------------------------------------------------------------
resource "aws_cloudwatch_metric_alarm" "dlq_messages" {
  for_each            = toset(var.queue_name)
  alarm_name          = "${var.app_id}|${var.app_name}|SQS-${var.env}|${each.value}|${var.sqs_metric}|${var.threshold_value}|High"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  treat_missing_data  = "notBreaching"
  metric_name         = var.sqs_metric
  namespace           = "AWS/SQS"
  period              = 60
  evaluation_periods  = 1
  threshold           = var.threshold_value
  statistic           = "Maximum"
  unit                = "Count"

  alarm_description = <<EOF
 The Number of Messages visible in the ${each.value} queue is more than One.
 Please find the below details of SQS Queue Metric.
  Application_ID:    ${var.app_id}
  Application_Name:  ${var.app_name}
  Platform_Name:     ${var.platform}
  Owner:             ${var.squadname}
  Enviornment:       ${var.env}
  QueueName:         ${each.value}
  Metric_Name:       ${var.sqs_metric}
  Metric_value:      ${var.threshold_value}
  Severity:          High
 EOF

  alarm_actions             = ["${data.aws_sns_topic.my-alerts.arn}",]
  dimensions = {
    QueueName = "${each.value}"
  }
}