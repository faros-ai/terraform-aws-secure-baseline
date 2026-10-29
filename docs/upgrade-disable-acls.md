# Migrate secure buckets to disabled ACLs

The secure-bucket module now uses `BucketOwnerEnforced` Object Ownership for both
the content bucket and its server access log bucket. It no longer manages
`aws_s3_bucket_acl.content` or `aws_s3_bucket_acl.access_log`. A bucket policy grants
`logging.s3.amazonaws.com` permission to write server access logs, restricted to the
content bucket ARN and its AWS account. Existing HTTPS enforcement is preserved.

New deployments, including buckets created with ACLs disabled during a partially
failed apply, do not need their ACLs changed. Apply the updated module normally.

## Existing deployments with ACLs enabled

Perform this migration separately for each Terraform workspace/account before a
full apply. Use the same AWS credentials/account and region as Terraform. These
steps preserve the buckets and their objects; do not remove bucket resources from
state or recreate the buckets.

1. Review existing bucket and object ACL permissions and migrate any required
   custom grants into policies before disabling ACLs. The standard content bucket
   ACL is already private; the access log bucket's `log-delivery-write` ACL grants
   permissions that must be replaced with the new policy first.
2. Update the module source/version and run `terraform init`. Set the module path
   below to match your configuration (for hephaestus it is
   `module.secure-baseline`), and use the actual access log bucket name:

   ```sh
   TF_MODULE_PATH='module.secure-baseline'
   ACCESS_LOG_BUCKET='your-audit-log-bucket-access-logs'
   ```

3. Install the replacement access log bucket policy first. Targeting is only for
   this migration; review the targeted plan before approving it:

   ```sh
   terraform apply -target="${TF_MODULE_PATH}.module.audit_log_bucket[0].aws_s3_bucket_policy.access_log_policy"
   ```

4. After the policy has been installed, reset the legacy access log bucket ACL to
   owner-only permissions. Skip this command for buckets that already have
   `BucketOwnerEnforced` ownership, because they reject ACL writes:

   ```sh
   aws s3api put-bucket-acl --bucket "$ACCESS_LOG_BUCKET" --acl private
   ```

   If the content bucket ACL has custom external grants, migrate those permissions
   and reset that bucket's ACL to `private` as well. AWS rejects
   `BucketOwnerEnforced` while a bucket ACL grants access to other accounts/groups.

5. Inspect `terraform state list` and forget only the old ACL resources that are
   present. With the default module layout, their addresses are:

   ```sh
   terraform state rm \
     "${TF_MODULE_PATH}.module.audit_log_bucket[0].aws_s3_bucket_acl.content" \
     "${TF_MODULE_PATH}.module.audit_log_bucket[0].aws_s3_bucket_acl.access_log"
   ```

   Omit any address absent from state. If using secure-bucket directly, substitute
   its module path. State removal does not issue an AWS ACL request. It also avoids
   requiring Terraform 1.7's `removed` blocks and preserves the module's existing
   Terraform version requirement.

6. Run `terraform plan` and confirm that neither bucket is replaced or destroyed.
   Apply the full configuration to enforce ownership on both buckets. Check the
   ownership settings and verify that new server access logs arrive; delivery is
   asynchronous.

External audit log buckets (`use_external_audit_log_bucket = true`) are not managed
by this child module and are unaffected by this change.

See AWS documentation for [ACL migration prerequisites](https://docs.aws.amazon.com/AmazonS3/latest/userguide/object-ownership-migrating-acls-prerequisites.html)
and [server access logging permissions](https://docs.aws.amazon.com/AmazonS3/latest/userguide/enable-server-access-logging.html).
