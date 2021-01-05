data "aws_sns_topic" "my-alerts" {
  name = "App15529_Ciena-Service-Order-Fulfilment_EC2-Dev_DevOps_Topic"
}

#Terraform module creates Cloudwatch Alarm on AWS for monitoriing Critical Usage of CPU Utilization.

resource "aws_cloudwatch_metric_alarm" "cpu_utilization_medium" {
  alarm_name                = "${var.app_id}|${var.app_name}|${var.env}|${var.platform}|${var.squadname}|Cpu-Utilization|${var.Medium_threshold_Value}|Medium"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = "1"
  metric_name               = var.cpu_metric
  namespace                 = "AWS/EC2"
  period                    = var.low_period
  statistic                 = "Maximum"
  threshold                 = var.Medium_threshold_Value
  alarm_description         = "This metric monitors ec2 cpu utilization of : \n Application_ID: ${var.app_id}  \n Application_Name: ${var.app_name}\n Owner:  ${var.squadname}  \n Platform_Name: ${var.platform} \n Environment: ${var.env} \n Metric_Type: ${var.cpu_metric} \n Metric_Value: ${var.Medium_threshold_Value}  \n Severity: Medium"
  alarm_actions             =  ["${data.aws_sns_topic.my-alerts.arn}"]
  ok_actions                =  ["${data.aws_sns_topic.my-alerts.arn}"]
  dimensions = {
    InstanceId = var.instance_id
    }
}

#Terraform module creates Cloudwatch Alarm on AWS for monitoriing High Usage of CPU Utilization.

resource "aws_cloudwatch_metric_alarm" "cpu_utilization_high" {
  alarm_name                = "${var.app_id}|${var.app_name}|${var.env}|${var.platform}|${var.squadname}|Cpu-Utilization|${var.High_threshold_Value}|High"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = "1"
  metric_name               = var.cpu_metric
  namespace                 = "AWS/EC2"
  period                    = var.high_period
  statistic                 = "Maximum"
  threshold                 = var.High_threshold_Value
  alarm_description         = "This metric monitors ec2 cpu utilization of : \n Application_ID: ${var.app_id}  \n Application_Name: ${var.app_name}\n Owner:  ${var.squadname}  \n Platform_Name: ${var.platform} \n Environment: ${var.env} \n Metric_Type: ${var.cpu_metric} \n Metric_Value: ${var.High_threshold_Value}  \n Severity: High"
  alarm_actions             =  ["${data.aws_sns_topic.my-alerts.arn}"]
  ok_actions                =  ["${data.aws_sns_topic.my-alerts.arn}"]
  dimensions = {
    InstanceId = var.instance_id
    }
}

#Terraform module creates Cloudwatch Alarm on AWS for monitoriing Medium Usage of CPU Utilization.

resource "aws_cloudwatch_metric_alarm" "cpu_utilization_critical" {
  alarm_name                = "${var.app_id}|${var.app_name}|${var.env}|${var.platform}|${var.squadname}|Cpu-Utilization|${var.Critical_threshold_Value}|Critical"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = "1"
  metric_name               = var.cpu_metric
  namespace                 = "AWS/EC2"
  period                    = var.high_period
  statistic                 = "Maximum"
  threshold                 = var.Critical_threshold_Value
  alarm_description         = "This metric monitors ec2 cpu utilization of : \n Application_ID: ${var.app_id}  \n Application_Name: ${var.app_name}\n Owner:  ${var.squadname}  \n Platform_Name: ${var.platform} \n Environment: ${var.env} \n Metric_Type: ${var.cpu_metric} \n Metric_Value: ${var.Critical_threshold_Value}  \n Severity: Critical"
  alarm_actions             =  ["${data.aws_sns_topic.my-alerts.arn}"]
  ok_actions                =  ["${data.aws_sns_topic.my-alerts.arn}"]
  dimensions = {
    InstanceId = var.instance_id
    }
}

#Terraform module creates Cloudwatch Alarm on AWS for monitoriing Health.

resource "aws_cloudwatch_metric_alarm" "health" {
  alarm_name                = "${var.app_id}|${var.app_name}|${var.env}|${var.platform}|${var.squadname}|Status-Check-Failed|1|Critical"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = "1"
  metric_name               = var.status_metric
  namespace                 = "AWS/EC2"
  period                    = "120"
  statistic                 = "SampleCount"
  threshold                 = "3"
  alarm_description         = "This metric monitors ec2 status check of : \n Application_ID: ${var.app_id}  \n Application_Name: ${var.app_name}  \nOwner:  ${var.squadname}  \n Platform_Name: ${var.platform} \n Environment: ${var.env} \n Metric_Type: ${var.status_metric} \n Metric_Value: 1   \n Severity: Critical"
  alarm_actions             =["${data.aws_sns_topic.my-alerts.arn}"]
  ok_actions                = ["${data.aws_sns_topic.my-alerts.arn}"]
  dimensions = {
    InstanceId = var.instance_id
    }
}

#Terraform module creates Cloudwatch Alarm on AWS for monitoriing Instance Health.

resource "aws_cloudwatch_metric_alarm" "instance_health" {
  alarm_name                = "${var.app_id}|${var.app_name}|${var.env}|${var.platform}|${var.squadname}|Status-Check-Failed-Instance|1|high"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = "1"
  metric_name               = var.instance_metric
  namespace                 = "AWS/EC2"
  period                    = "120"
  statistic                 = "SampleCount"
  threshold                 = "3"
  alarm_description         = "This metric monitors ec2 instance status health check of : \n Application_ID: ${var.app_id}  \n Application_Name: ${var.app_name}  \n Owner:  ${var.squadname}  \n Platform_Name: ${var.platform} \n Environment: ${var.env} \n Metric_Type: ${var.instance_metric} \n Metric_Value: 1   \n Severity: Critical"
  alarm_actions             =["${data.aws_sns_topic.my-alerts.arn}"]
  ok_actions                = ["${data.aws_sns_topic.my-alerts.arn}"]
  dimensions = {
    InstanceId = var.instance_id
    }
}

#Terraform module creates Cloudwatch Alarm on AWS for monitoriing Medium Usage of Memory Utilization.

resource "aws_cloudwatch_metric_alarm" "memory_utilization_medium" {
  alarm_name = "${var.app_id}|${var.app_name}|${var.env}|${var.platform}|${var.squadname}|Memory-Utilization|${var.Medium_threshold_Value}|Medium"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name = var.mem_metric
  namespace = "CWAgent"
  period = var.low_period
  statistic = "Maximum"
  threshold = var.Medium_threshold_Value
  alarm_description = "This metric monitors ec2 memory utilization of \n Application_ID: ${var.app_id}  \n Application_Name: ${var.app_name}  \n Owner:  ${var.squadname}  \n Platform_Name: ${var.platform} \n Environment: ${var.env} \n Metric_Type: ${var.mem_metric} \n Metric_Value: ${var.Medium_threshold_Value}  \n Severity: Medium"
  alarm_actions             =  ["${data.aws_sns_topic.my-alerts.arn}"]
  ok_actions                =  ["${data.aws_sns_topic.my-alerts.arn}"]
  dimensions = {
    InstanceId = var.instance_id
    ImageId = var.ami_id
    InstanceType = var.instance_type
    }
}

#Terraform module creates Cloudwatch Alarm on AWS for monitoriing High Usage of Memory Utilization.

resource "aws_cloudwatch_metric_alarm" "memory_utilization_high" {
  alarm_name = "${var.app_id}|${var.app_name}|${var.env}|${var.platform}|${var.squadname}|Memory-Utilization|${var.High_threshold_Value}|High"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name = var.mem_metric
  namespace = "CWAgent"
  period = var.high_period
  statistic = "Maximum"
  threshold = var.High_threshold_Value
  alarm_description = "This metric monitors ec2 memory utilization of : \n Application_ID: ${var.app_id}  \n Application_Name: ${var.app_name}  \n Owner:  ${var.squadname}  \n Platform_Name: ${var.platform} \n Environment: ${var.env} \n Metric_Type: ${var.mem_metric} \n Metric_Value: ${var.High_threshold_Value}  \n Severity: High"
  alarm_actions             =  ["${data.aws_sns_topic.my-alerts.arn}"]
  ok_actions                =  ["${data.aws_sns_topic.my-alerts.arn}"]
  dimensions = {
     InstanceId = var.instance_id
     ImageId = var.ami_id
     InstanceType = var.instance_type
    }
}

#Terraform module creates Cloudwatch Alarm on AWS for monitoriing Critical Usage of Memory Utilization.

resource "aws_cloudwatch_metric_alarm" "memory_utilization_critical" {
  alarm_name = "${var.app_id}|${var.app_name}|${var.env}|${var.platform}|${var.squadname}|Memory-Utilization|${var.Critical_threshold_Value}|Critical"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name = var.mem_metric
  namespace = "CWAgent"
  period = var.high_period
  statistic = "Maximum"
  threshold = var.Critical_threshold_Value
  alarm_description = "This metric monitors ec2 memory utilization of : \n Application_ID: ${var.app_id}  \n Application_Name: ${var.app_name}  \n Owner:  ${var.squadname}  \n Platform_Name: ${var.platform} \n Environment: ${var.env} \n Metric_Type: ${var.mem_metric} \n Metric_Value: ${var.Critical_threshold_Value}  \n Severity: Critical"
  alarm_actions             =  ["${data.aws_sns_topic.my-alerts.arn}"]
  ok_actions                =  ["${data.aws_sns_topic.my-alerts.arn}"]
  dimensions = {
    InstanceId = var.instance_id
    ImageId = var.ami_id
    InstanceType = var.instance_type
  }
}

#Terraform module creates Cloudwatch Alarm on AWS for monitoriing Medium  Usage of Disk Utilization.

resource "aws_cloudwatch_metric_alarm" "medium_Disk_Space_For_root_drive" {
  alarm_name                = "${var.app_id}|${var.app_name}|${var.env}|${var.platform}|${var.squadname}|Disk-Utilization|${var.Medium_threshold_Value}|Medium"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = "1"
  metric_name               = var.disk_metric
  namespace                 = "CWAgent"

  dimensions = {
    path = "/"
    InstanceId = var.instance_id
    ImageId = var.ami_id
    InstanceType = var.instance_type
    device = "rootfs"
    fstype = "rootfs"
  }

  period                    = var.high_period
  statistic                = "Maximum"
  threshold                 = var.Medium_threshold_Value
  alarm_description         = " This metric monitors ec2 Disk usage for  : \n Application_ID: ${var.app_id}  \n Application_Name: ${var.app_name}  \n Owner:  ${var.squadname}  \n Platform_Name: ${var.platform} \n Environment: ${var.env} \n Metric_Type: ${var.disk_metric} \n Metric_Value: ${var.Medium_threshold_Value}  \n Severity: Medium"
  actions_enabled           = true
  alarm_actions             =  ["${data.aws_sns_topic.my-alerts.arn}"]
  ok_actions                =  ["${data.aws_sns_topic.my-alerts.arn}"]
}

#Terraform module creates Cloudwatch Alarm on AWS for monitoriing High Usage of Disk Utilization.

resource "aws_cloudwatch_metric_alarm" "high_Disk_Space_For_root_drive" {
  alarm_name                = "${var.app_id}|${var.app_name}|${var.env}|${var.platform}|${var.squadname}|Disk-Utilization|${var.High_threshold_Value}|High"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = "1"
  metric_name               = var.disk_metric
  namespace                 = "CWAgent"

  dimensions = {
    path = "/"
    InstanceId = var.instance_id
    ImageId = var.ami_id
    InstanceType = var.instance_type
    device = "rootfs"
    fstype = "rootfs"
  }

  period                    = var.high_period
  statistic                = "Maximum"
  threshold                 = var.High_threshold_Value
  alarm_description         = "This metric monitors ec2 Disk usage for  : \n Application_ID: ${var.app_id}  \n Application_Name: ${var.app_name}  \nOwner:  ${var.squadname}  \n Platform_Name: ${var.platform} \n Environment: ${var.env} \n Metric_Type: ${var.disk_metric} \n Metric_Value: ${var.High_threshold_Value}  \n Severity: High"
  actions_enabled           = true
  alarm_actions             =  ["${data.aws_sns_topic.my-alerts.arn}"]
  ok_actions                =  ["${data.aws_sns_topic.my-alerts.arn}"]
}

#Terraform module creates Cloudwatch Alarm on AWS for monitoriing Critical Usage of Disk Utilization.

resource "aws_cloudwatch_metric_alarm" "critical_Disk_Space_For_root_drive" {
  alarm_name                = "${var.app_id}|${var.app_name}|${var.env}|${var.platform}|${var.squadname}|Disk-Utilization|${var.Critical_threshold_Value}|Critical"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = "1"
  metric_name               = var.disk_metric
  namespace                 = "CWAgent"

  dimensions = {
    path = "/"
    InstanceId = var.instance_id
    ImageId = var.ami_id
    InstanceType = var.instance_type
    device = "rootfs"
    fstype = "rootfs"
  }

  period                    = var.high_period
  statistic                = "Maximum"
  threshold                 = var.Critical_threshold_Value
  alarm_description         = "This metric monitors ec2 Disk usage for  : \n Application_ID: ${var.app_id}  \n Application_Name: ${var.app_name}  \nOwner:  ${var.squadname}  \n Platform_Name: ${var.platform} \n Environment: ${var.env} \n Metric_Type: ${var.disk_metric} \n Metric_Value: ${var.Critical_threshold_Value}  \n Severity: Critical"
  actions_enabled           = true
  alarm_actions             =  ["${data.aws_sns_topic.my-alerts.arn}"]
  ok_actions                =  ["${data.aws_sns_topic.my-alerts.arn}"]
}