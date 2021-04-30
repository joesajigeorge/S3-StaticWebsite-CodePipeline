output s3_static_website_url {
  value       = module.s3.s3_static_website_url
  description = "S3 bucket static website URL"
}

output cloudfront_domainname {
  value       = module.s3.cloudfront_domainname
  description = "Cloudfront domain name"
}