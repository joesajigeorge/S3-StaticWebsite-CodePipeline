variable s3_bucket_id {
  description = "Name of the S3 bucket"
}

variable s3_bucket_arn {
    description = "ARN of the S3 bucket"
}

variable region {
  type        = string
  description = "The AWS region"
}

variable projectname {
  type        = string
  description = "The name of the project"
}

variable env {
  type        = string
  description = "The name of the environment"
}

variable aws_cloudfront_distribution_id {
  description = "Cloudfront distribution id"
}