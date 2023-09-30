output "lambda_arn" {
  value = aws_lambda_function.this.arn
}

output "sns_arn" {
  value = aws_sns_topic.this.arn
}

output "sqs_arn" {
  value = aws_sqs_queue.this.arn
}

output "lambda_policy_arn" {
  value = aws_iam_policy.lambda.arn
}

output "lambda_role_arn" {
  value = aws_iam_role.lambda.arn
}