resource "aws_iam_role" "default" {
  name               = "${var.projectname}-${var.env}-pipeline-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    sid = ""

    actions = [
      "sts:AssumeRole"
    ]

    principals {
      type        = "Service"
      identifiers = ["codepipeline.amazonaws.com"]
    }

    effect = "Allow"
  }
}

resource "aws_iam_role_policy_attachment" "default" {
  depends_on = [ aws_iam_role.default, aws_iam_policy.default ]
  role       = aws_iam_role.default.id
  policy_arn = aws_iam_policy.default.arn
}

resource "aws_iam_policy" "default" {
  name   = "${var.projectname}-${var.env}-pipeline-policy"
  policy = data.aws_iam_policy_document.default.json
}

data "aws_iam_policy_document" "default" {
  statement {
    sid = ""

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "s3:*",
      "iam:PassRole",
      "codebuild:BatchGetBuilds",
      "codebuild:StartBuild",
      "codestar-connections:UseConnection",
      "sns:*"
    ]

    resources = ["*"]
    effect    = "Allow"
  }
}

resource "aws_iam_role" "build" {
  name = "${var.projectname}-${var.env}-build-role"
  assume_role_policy = data.aws_iam_policy_document.assume_build_role.json
}

data "aws_iam_policy_document" "assume_build_role" {
  statement {
    sid = ""

    actions = [
      "sts:AssumeRole"
    ]

    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }

    effect = "Allow"
  }
}

resource "aws_iam_role_policy_attachment" "build" {
  depends_on = [ aws_iam_role.build, aws_iam_policy.build ]
  role       = aws_iam_role.build.id
  policy_arn = aws_iam_policy.build.arn
}

resource "aws_iam_policy" "build" {
  name   = "${var.projectname}-${var.env}-build-policy"
  policy = data.aws_iam_policy_document.build.json
}

data "aws_iam_policy_document" "build" {
  statement {
    sid = ""

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "ec2:CreateNetworkInterface",
      "ec2:DescribeDhcpOptions",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DeleteNetworkInterface",
      "ec2:DescribeSubnets",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeVpcs",
      "s3:*",
      "codepipeline:*"
    ]

    resources = ["*"]
    effect    = "Allow"
  }
}
