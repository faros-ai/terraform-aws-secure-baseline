variable "unauthorized_api_calls_enabled" {
  description = "The boolean flag whether the unauthorized_api_calls alarm is enabled or not. No resources are created when set to false."
  type        = bool
  default     = true
}

variable "unauthorized_api_calls_pattern" {
  description = "Pattern for unauthorized_api_calls metric filter"
  type        = string
  default     = ""
}

variable "no_mfa_console_signin_pattern" {
  description = "Pattern for no_mfa_console_signin metric filter"
  type        = string
  default     = ""
}

variable "root_usage_pattern" {
  description = "Pattern for root_usage metric filter"
  type        = string
  default     = ""
}

variable "iam_changes_pattern" {
  description = "Pattern for iam_changes metric filter"
  type        = string
  default     = ""
}

variable "cloudtrail_cfg_changes_pattern" {
  description = "Pattern for cloudtrail_cfg_changes metric filter"
  type        = string
  default     = ""
}

variable "console_signin_failures_pattern" {
  description = "Pattern for console_signin_failures metric filter"
  type        = string
  default     = ""
}

variable "disable_or_delete_cmk_pattern" {
  description = "Pattern for disable_or_delete_cmk metric filter"
  type        = string
  default     = ""
}

variable "s3_bucket_policy_changes_pattern" {
  description = "Pattern for s3_bucket_policy_changes metric filter"
  type        = string
  default     = ""
}

variable "aws_config_changes_pattern" {
  description = "Pattern for aws_config_changes metric filter"
  type        = string
  default     = ""
}

variable "security_group_changes_pattern" {
  description = "Pattern for security_group_changes metric filter"
  type        = string
  default     = ""
}

variable "nacl_changes_pattern" {
  description = "Pattern for nacl_changes metric filter"
  type        = string
  default     = ""
}

variable "network_gw_changes_pattern" {
  description = "Pattern for network_gw_changes metric filter"
  type        = string
  default     = ""
}

variable "route_table_changes_pattern" {
  description = "Pattern for route_table_changes metric filter"
  type        = string
  default     = ""
}

variable "vpc_changes_pattern" {
  description = "Pattern for vpc_changes metric filter"
  type        = string
  default     = ""
}

variable "organizations_changes_pattern" {
  description = "Pattern for organizations_changes metric filter"
  type        = string
  default     = ""
}

variable "no_mfa_console_signin_enabled" {
  description = "The boolean flag whether the no_mfa_console_signin alarm is enabled or not. No resources are created when set to false."
  type        = bool
  default     = true
}

variable "mfa_console_signin_allow_sso" {
  description = "The boolean flag whether the no_mfa_console_signin alarm allows SSO auth to be ignored."
  type        = bool
  default     = false
}

variable "root_usage_enabled" {
  description = "The boolean flag whether the root_usage alarm is enabled or not. No resources are created when set to false."
  type        = bool
  default     = true
}

variable "iam_changes_enabled" {
  description = "The boolean flag whether the iam_changes alarm is enabled or not. No resources are created when set to false."
  type        = bool
  default     = true
}

variable "cloudtrail_cfg_changes_enabled" {
  description = "The boolean flag whether the cloudtrail_cfg_changes alarm is enabled or not. No resources are created when set to false."
  type        = bool
  default     = true
}

variable "console_signin_failures_enabled" {
  description = "The boolean flag whether the console_signin_failures alarm is enabled or not. No resources are created when set to false."
  type        = bool
  default     = true
}

variable "disable_or_delete_cmk_enabled" {
  description = "The boolean flag whether the disable_or_delete_cmk alarm is enabled or not. No resources are created when set to false."
  type        = bool
  default     = true
}

variable "s3_bucket_policy_changes_enabled" {
  description = "The boolean flag whether the s3_bucket_policy_changes alarm is enabled or not. No resources are created when set to false."
  type        = bool
  default     = true
}

variable "aws_config_changes_enabled" {
  description = "The boolean flag whether the aws_config_changes alarm is enabled or not. No resources are created when set to false."
  type        = bool
  default     = true
}

variable "security_group_changes_enabled" {
  description = "The boolean flag whether the security_group_changes alarm is enabled or not. No resources are created when set to false."
  type        = bool
  default     = true
}

variable "nacl_changes_enabled" {
  description = "The boolean flag whether the nacl_changes alarm is enabled or not. No resources are created when set to false."
  type        = bool
  default     = true
}

variable "network_gw_changes_enabled" {
  description = "The boolean flag whether the network_gw_changes alarm is enabled or not. No resources are created when set to false."
  type        = bool
  default     = true
}

variable "route_table_changes_enabled" {
  description = "The boolean flag whether the route_table_changes alarm is enabled or not. No resources are created when set to false."
  type        = bool
  default     = true
}

variable "vpc_changes_enabled" {
  description = "The boolean flag whether the vpc_changes alarm is enabled or not. No resources are created when set to false."
  type        = bool
  default     = true
}

variable "organizations_changes_enabled" {
  description = "The boolean flag whether the organizations_changes alarm is enabled or not. No resources are created when set to false."
  type        = bool
  default     = true
}

variable "alarm_namespace" {
  description = "The namespace in which all alarms are set up."
  type        = string
  default     = "CISBenchmark"
}

variable "cloudtrail_log_group_name" {
  description = "The name of the CloudWatch Logs group to which CloudTrail events are delivered."
  type        = string
}

variable "sns_topic_name" {
  description = "The name of the SNS Topic which will be notified when any alarm is performed."
  type        = string
  default     = "CISAlarm"
}

variable "sns_topic_kms_master_key_id" {
  description = "To enable SNS Topic encryption enter value with the ID of a custom master KMS key that is used for encryption"
  type        = string
  default     = null
}

variable "tags" {
  description = "Specifies object tags key and value. This applies to all resources created by this module."
  type        = map(string)
  default = {
    "Terraform" = "true"
  }
}
