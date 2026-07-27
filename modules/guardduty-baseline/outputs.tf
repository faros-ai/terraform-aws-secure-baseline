output "guardduty_detector" {
  description = "The GuardDuty detector."
  value = {
    account_id                   = aws_guardduty_detector.default.account_id
    arn                          = aws_guardduty_detector.default.arn
    enable                       = aws_guardduty_detector.default.enable
    finding_publishing_frequency = aws_guardduty_detector.default.finding_publishing_frequency
    id                           = aws_guardduty_detector.default.id
    tags                         = aws_guardduty_detector.default.tags
    tags_all                     = aws_guardduty_detector.default.tags_all
  }
}
