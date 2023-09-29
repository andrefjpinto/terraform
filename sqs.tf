resource "aws_sqs_queue" "this" {
  name                      = "${var.name}-${var.env}-dlq"
  receive_wait_time_seconds = 20
  message_retention_seconds = 18400

  tags = {
    name = "${var.name}-${var.env}-dlq"
  }
}

resource "aws_sns_topic_subscription" "this" {
  protocol             = "sqs"
  raw_message_delivery = true
  topic_arn            = aws_sns_topic.this.arn
  endpoint             = aws_sqs_queue.this.arn
}