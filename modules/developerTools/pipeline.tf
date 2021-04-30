resource "aws_codepipeline" "default" {
  depends_on = [ 
    aws_iam_role.default, 
    aws_iam_role_policy_attachment.default,
    aws_codebuild_project.main,
    aws_s3_bucket.codepipeline_bucket ,
    aws_sns_topic.approval_topic
    ]
  name     = "${var.projectname}-${var.env}-pipeline"
  role_arn = aws_iam_role.default.arn

  artifact_store {
    location = aws_s3_bucket.codepipeline_bucket.bucket
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        ConnectionArn    = var.code_start_connection_arn
        FullRepositoryId = var.repo_id
        BranchName       = var.repo_branch
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      version          = "1"

      configuration = {
        ProjectName = aws_codebuild_project.main.name
      }
    }
  }

  stage {
    name = "Approve"

    action {
      name     = "Approval"
      category = "Approval"
      owner    = "AWS"
      provider = "Manual"
      version  = "1"

      configuration = {
        NotificationArn = aws_sns_topic.approval_topic.arn
        CustomData = "${var.projectname} ${var.env} environment pre deployment approval"
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "S3"
      input_artifacts = ["build_output"]
      version         = "1"

      configuration = {
        BucketName = var.s3_bucketname
        Extract    = "true"
        CannedACL  = "public-read"
      }
    }
  }
}