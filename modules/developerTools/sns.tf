resource "aws_sns_topic" "approval_topic" {
  name = "${var.projectname}-${var.env}-approval-topic"
}