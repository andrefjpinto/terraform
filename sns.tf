resource "aws_sns_topic" "this" {
  name = "${var.name}-${var.env}-error-topic"
}
