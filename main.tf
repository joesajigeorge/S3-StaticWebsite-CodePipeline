terraform {

  backend "s3" {
    bucket  = "tf-statefile-store"
    key     = "s3developertools/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
    profile = "myaccount"
  }
}

provider "aws" {
  profile = var.awsprofile
  region  = var.region
}

module "s3" {
  source         = "./modules/s3"
  env            = var.env
  region         = var.region
  projectname    = var.projectname
  s3_bucketname = var.s3_bucketname
}

module "lambda_trigger" {
  depends_on = [ module.s3 ]
  source         = "./modules/invalidation_lambda"
  env            = var.env
  region         = var.region
  projectname    = var.projectname
  s3_bucket_id = module.s3.s3_bucket_id
  s3_bucket_arn = module.s3.s3_bucket_arn
  aws_cloudfront_distribution_id = module.s3.aws_cloudfront_distribution_id
}

module "developerTools" {
  depends_on = [module.lambda_trigger]
  source         = "./modules/developerTools"
  env            = var.env
  region         = var.region
  projectname    = var.projectname
  s3_bucketname = var.s3_bucketname
  pipeline_artifact_bucket_name = var.pipeline_artifact_bucket_name
  github_oauth_token = var.github_oauth_token
  repo_owner = var.repo_owner
  repo_name = var.repo_name
  repo_branch = var.repo_branch
  poll_source_changes = var.poll_source_changes
  repo_url = var.repo_url
  code_start_connection_arn = var.code_start_connection_arn
  repo_id = var.repo_id
}