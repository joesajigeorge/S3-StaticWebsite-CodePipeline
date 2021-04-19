variable "s3_bucketname" {
  description = "Name of the S3 bucket"
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