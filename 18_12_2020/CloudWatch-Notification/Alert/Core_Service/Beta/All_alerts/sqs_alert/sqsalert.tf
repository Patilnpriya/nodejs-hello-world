provider "aws" {
        region = var.AWS_REGION
        version = "~> 3.13"
}
data "aws_sns_topic" "my-alerts" {
  name = "App15549_Simplify-Core-Services_ECS-Beta_DevOps_Lambda_Topic"
}
data "aws_iam_role" "ecs-autoscale" {
  name = "ccta-coreservices-ecs-autoscale"
}

resource "aws_appautoscaling_target" "sqs_target" {
  service_namespace  = "ecs"
  resource_id        = "service/${var.cluster_name}/${var.service_name}"
  #resource_id        = "service/${var.cluster_name}/${var.service_name}"
  #resource_id        = "service/kano-coreservices-cluster/${aws_ecs_service.ecs_service_def["${each.key}"].name}"
  scalable_dimension = "ecs:service:DesiredCount"
  role_arn           = data.aws_iam_role.ecs-autoscale.arn
  min_capacity       = var.min_capacity
  max_capacity       = var.max_capacity
}

resource "aws_appautoscaling_policy" "scale_up" {
  count = var.sqs_threshold_value >= 0 ? 1 : 0

  name                    = "${var.service_name}_${var.env}_SQS_MSG_Scale_up"
  service_namespace       = "ecs"
  resource_id             = "service/${var.cluster_name}/${var.service_name}"
  scalable_dimension      = "ecs:service:DesiredCount"


  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Maximum"
    min_adjustment_magnitude = 0

    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment = 1
    }
  }

  depends_on = ["aws_appautoscaling_target.sqs_target"]
}
#-------------------------------------------------------------
#set upper bound value Date : 29-10-2020
#-------------------------------------------------------------
resource "aws_cloudwatch_metric_alarm" "queue-messages-high" {
  count = var.sqs_threshold_value >= 0 ? 1 : 0

  alarm_name          = "${var.app_id}|${var.app_name}|SQS-${var.env}|${var.queue_name}|${var.sqs_metric}|${var.sqs_threshold_value}|High"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  treat_missing_data  = "breaching"
  metric_name         = var.sqs_metric
  namespace           = "AWS/SQS"
  period              = 60
  evaluation_periods  = 1
  threshold           = var.sqs_threshold_value
  statistic           = "Sum"
  unit                = "Count"

  alarm_description = <<EOF
 The Number of Messages visible in the ${var.queue_name} queue is more than One.
 Please find the below details of SQS Metric.
  Application_ID:    ${var.app_id}
  Application_Name:  ${var.app_name}
  Service_Name:      ${var.service_name}
  Platform_Name:     ${var.platform}
  Owner:             ${var.squadname}
  Enviornment:       ${var.env}
  QueueName:         ${var.queue_name}
  Metric_Name:       ${var.sqs_metric}
  Metric_Value:      ${var.sqs_threshold_value}
  Severity:          High

  EOF

  alarm_actions             = ["${data.aws_sns_topic.my-alerts.arn}","${aws_appautoscaling_policy.scale_up[count.index].arn}"]
  dimensions = {
    QueueName = var.queue_name
  }
}