# Run with Terraform >= 1.7: terraform -chdir=modules/secure-bucket test
# All resources and AWS identity are overridden, so no AWS API calls are needed.
# The real provider evaluates the policy document locally.
provider "aws" {
  region                      = "us-east-1"
  access_key                  = "test"
  secret_key                  = "test"
  skip_credentials_validation = true
  skip_requesting_account_id  = true
  skip_metadata_api_check     = true
}

variables {
  bucket_name     = "test-audit-log"
  log_bucket_name = "test-audit-log-access-logs"
}

override_data {
  target = data.aws_caller_identity.current
  values = {
    account_id = "123456789012"
  }
}

override_resource {
  target = aws_s3_bucket.content
  values = {
    id  = "test-audit-log"
    arn = "arn:aws:s3:::test-audit-log"
  }
}

override_resource {
  target = aws_s3_bucket.access_log
  values = {
    id  = "test-audit-log-access-logs"
    arn = "arn:aws:s3:::test-audit-log-access-logs"
  }
}

override_resource {
  target = aws_s3_bucket_ownership_controls.content
}

override_resource {
  target = aws_s3_bucket_ownership_controls.access_log
}

override_resource {
  target = aws_s3_bucket_public_access_block.content
}

override_resource {
  target = aws_s3_bucket_public_access_block.access_log
}

override_resource {
  target = aws_s3_bucket_server_side_encryption_configuration.content
}

override_resource {
  target = aws_s3_bucket_server_side_encryption_configuration.access_log
}

override_resource {
  target = aws_s3_bucket_logging.content
}

override_resource {
  target = aws_s3_bucket_policy.access_log_policy
}

override_resource {
  target = aws_s3_bucket_versioning.content
}

run "access_logging_without_acls" {
  command = apply

  assert {
    condition = alltrue([
      one(aws_s3_bucket_ownership_controls.content.rule).object_ownership == "BucketOwnerEnforced",
      one(aws_s3_bucket_ownership_controls.access_log.rule).object_ownership == "BucketOwnerEnforced",
    ])
    error_message = "Both buckets must disable ACLs."
  }

  assert {
    condition = length([
      for statement in jsondecode(data.aws_iam_policy_document.access_log_policy.json).Statement : statement
      if statement.Effect == "Allow"
      ]) == 1 && anytrue([
      for statement in jsondecode(data.aws_iam_policy_document.access_log_policy.json).Statement :
      try(
        statement.Effect == "Allow" &&
        statement.Principal.Service == "logging.s3.amazonaws.com" &&
        statement.Action == "s3:PutObject" &&
        statement.Resource == "arn:aws:s3:::test-audit-log-access-logs/*" &&
        statement.Condition.ArnLike["aws:SourceArn"] == "arn:aws:s3:::test-audit-log" &&
        statement.Condition.StringEquals["aws:SourceAccount"] == "123456789012",
        false
      )
    ])
    error_message = "Only S3 log delivery from this bucket and account may write access logs."
  }

  assert {
    condition = anytrue([
      for statement in jsondecode(data.aws_iam_policy_document.access_log_policy.json).Statement :
      try(
        statement.Effect == "Deny" &&
        statement.Principal == "*" &&
        statement.Action == "s3:*" &&
        toset(statement.Resource) == toset(["arn:aws:s3:::test-audit-log-access-logs", "arn:aws:s3:::test-audit-log-access-logs/*"]) &&
        statement.Condition.Bool["aws:SecureTransport"] == "false",
        false
      )
    ])
    error_message = "The access log policy must continue denying unencrypted transport."
  }

  assert {
    condition = (
      aws_s3_bucket_logging.content.target_bucket == "test-audit-log-access-logs" &&
      aws_s3_bucket_logging.content.target_prefix == "" &&
      aws_s3_bucket_policy.access_log_policy.policy == data.aws_iam_policy_document.access_log_policy.json
    )
    error_message = "Logging must target the bucket with the generated delivery policy."
  }
}
