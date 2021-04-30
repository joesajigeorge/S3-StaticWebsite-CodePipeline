output s3_static_website_url {
  value       = aws_s3_bucket.main.bucket_regional_domain_name
  description = "S3 bucket static website URL"
}

output cloudfront_domainname {
  value       = aws_cloudfront_distribution.s3_distribution.domain_name
  description = "Cloudfront domain name"
}

output s3_bucket_arn {
  value       = aws_s3_bucket.main.arn
  description = "S3 bucket arn"
}

output s3_bucket_id {
  value       = aws_s3_bucket.main.id
  description = "S3 bucket Id"
}

output aws_cloudfront_distribution_id {
  value       = aws_cloudfront_distribution.s3_distribution.id
  description = "Cloudfront distribution id"
}