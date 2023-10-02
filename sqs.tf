resource "aws_sqs_queue" "this" {
  name                      = "${var.name}-${var.env}-queue"
  delay_seconds             = 90
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10
  #   redrive_policy = jsonencode({
  #     deadLetterTargetArn = aws_sqs_queue.terraform_queue_deadletter.arn
  #     maxReceiveCount     = 4
  #   })
  tags = {
    name = "${var.name}-${var.env}-queue"
  }
}

data "aws_iam_policy_document" "this" {
  statement {
    effect = "Allow"
    actions = [
      "sqs:SendMessage",
    ]
    principals {
      type        = "Service"
      identifiers = ["sns.amazonaws.com"]
    }
    resources = [
      aws_sqs_queue.this.arn,
    ]
    condition {
      test     = "ArnEquals"
      variable = "aws:SourceArn"
      values = [
        aws_sns_topic.this.arn
      ]
    }
  }
}

resource "aws_sqs_queue_policy" "this" {
  queue_url = aws_sqs_queue.this.id
  policy    = data.aws_iam_policy_document.this.json
}
