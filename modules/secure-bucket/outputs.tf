output "this_bucket" {
  description = "This S3 bucket."
  value = {
    arn                         = aws_s3_bucket.content.arn
    bucket                      = aws_s3_bucket.content.bucket
    bucket_domain_name          = aws_s3_bucket.content.bucket_domain_name
    bucket_prefix               = aws_s3_bucket.content.bucket_prefix
    bucket_regional_domain_name = aws_s3_bucket.content.bucket_regional_domain_name
    force_destroy               = aws_s3_bucket.content.force_destroy
    hosted_zone_id              = aws_s3_bucket.content.hosted_zone_id
    id                          = aws_s3_bucket.content.id
    region                      = aws_s3_bucket.content.region
    tags                        = aws_s3_bucket.content.tags
    tags_all                    = aws_s3_bucket.content.tags_all
  }
}

output "log_bucket" {
  description = "The S3 bucket used for storing access logs of this bucket."
  value = {
    arn                         = aws_s3_bucket.access_log.arn
    bucket                      = aws_s3_bucket.access_log.bucket
    bucket_domain_name          = aws_s3_bucket.access_log.bucket_domain_name
    bucket_prefix               = aws_s3_bucket.access_log.bucket_prefix
    bucket_regional_domain_name = aws_s3_bucket.access_log.bucket_regional_domain_name
    force_destroy               = aws_s3_bucket.access_log.force_destroy
    hosted_zone_id              = aws_s3_bucket.access_log.hosted_zone_id
    id                          = aws_s3_bucket.access_log.id
    region                      = aws_s3_bucket.access_log.region
    tags                        = aws_s3_bucket.access_log.tags
    tags_all                    = aws_s3_bucket.access_log.tags_all
  }
}
