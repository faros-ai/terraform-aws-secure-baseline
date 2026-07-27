output "cloudtrail" {
  description = "The trail for recording events in all regions."
  value       = aws_cloudtrail.global
}

output "cloudtrail_sns_topic" {
  description = "The sns topic linked to the cloudtrail."
  value       = var.cloudtrail_sns_topic_enabled ? aws_sns_topic.cloudtrail-sns-topic[0] : null
}

output "kms_key" {
  description = "The  KMS key used for encrypting CloudTrail events."
  value       = aws_kms_key.cloudtrail
}

output "log_delivery_iam_role" {
  description = "The IAM role used for delivering CloudTrail events to CloudWatch Logs."
  value = var.cloudwatch_logs_enabled ? {
    arn                   = aws_iam_role.cloudwatch_delivery[0].arn
    assume_role_policy    = aws_iam_role.cloudwatch_delivery[0].assume_role_policy
    create_date           = aws_iam_role.cloudwatch_delivery[0].create_date
    description           = aws_iam_role.cloudwatch_delivery[0].description
    force_detach_policies = aws_iam_role.cloudwatch_delivery[0].force_detach_policies
    id                    = aws_iam_role.cloudwatch_delivery[0].id
    max_session_duration  = aws_iam_role.cloudwatch_delivery[0].max_session_duration
    name                  = aws_iam_role.cloudwatch_delivery[0].name
    name_prefix           = aws_iam_role.cloudwatch_delivery[0].name_prefix
    path                  = aws_iam_role.cloudwatch_delivery[0].path
    permissions_boundary  = aws_iam_role.cloudwatch_delivery[0].permissions_boundary
    tags                  = aws_iam_role.cloudwatch_delivery[0].tags
    tags_all              = aws_iam_role.cloudwatch_delivery[0].tags_all
    unique_id             = aws_iam_role.cloudwatch_delivery[0].unique_id
  } : null
}

output "log_group" {
  description = "The CloudWatch Logs log group which stores CloudTrail events."
  value       = var.cloudwatch_logs_enabled ? aws_cloudwatch_log_group.cloudtrail_events[0].name : null
}
