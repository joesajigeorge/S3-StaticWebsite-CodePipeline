variable projectname {
  type        = string
  description = "The name of the project"
}

variable env {
  type        = string
  description = "The name of the environment"
}

variable region {
  type        = string
  description = "The AWS region"
}

variable "s3_bucketname" {
    description = "Name of the S3 bucket"
}

variable "pipeline_artifact_bucket_name" {
    description = "Name of the pipeline artifact S3 bucket"
}

variable "github_oauth_token" {
    description = "Github oauth token"
}

variable "repo_owner" {
    description = "Repository owner"
}

variable "repo_name" {
    description = "Repository name"
}

variable "repo_branch" {
    description = "Repository branch"
}

variable "poll_source_changes" {
    description = "Poll source changes"
}

variable "repo_url" {
    description = "Repository url"
}

variable "code_start_connection_arn" {
    description = "Code start connection arn"
}

variable "repo_id" {
    description = "Repository id"
}