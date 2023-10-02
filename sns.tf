resource "aws_sns_topic" "this" {
  name = "${var.name}-${var.env}-topic"
}

resource "aws_sns_topic_subscription" "this" {
  topic_arn = aws_sns_topic.this.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.this.arn
}