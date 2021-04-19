output s3_bucket_arn {
  value       = aws_s3_bucket.main.arn
  description = "S3 bucket arn"
}

output s3_bucket_id {
  value       = aws_s3_bucket.main.id
  description = "S3 bucket Id"
}