output "support_iam_role" {
  description = "The IAM role used for the support user."
  value = [for role in aws_iam_role.support : {
    arn                   = role.arn
    assume_role_policy    = role.assume_role_policy
    create_date           = role.create_date
    description           = role.description
    force_detach_policies = role.force_detach_policies
    id                    = role.id
    max_session_duration  = role.max_session_duration
    name                  = role.name
    name_prefix           = role.name_prefix
    path                  = role.path
    permissions_boundary  = role.permissions_boundary
    tags                  = role.tags
    tags_all              = role.tags_all
    unique_id             = role.unique_id
  }]
}
