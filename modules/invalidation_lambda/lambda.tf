resource "aws_lambda_function" "main" {
  filename      = data.archive_file.archive_function.output_path
  function_name = "${var.projectname}-${var.env}-invalidation-function"
  role          = aws_iam_role.lambda_default.arn
  handler       = "handler.lambda_handler"

  source_code_hash = data.archive_file.archive_function.output_base64sha256

  runtime = "python3.8"
  timeout = "120"

  environment {
    variables = {
      CLOUDFRONT_DISTRIBUTION_ID = var.aws_cloudfront_distribution_id
    }
  }
}

data "archive_file" "archive_function" {
  type        = "zip"
  source_dir  = dirname("${path.module}/code/")
  output_path = "/${path.module}/code/handler.zip"
}