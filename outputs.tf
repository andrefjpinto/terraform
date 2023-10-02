output "lambda_arn" {
  value       = aws_lambda_function.this.arn
  description = "ARN of the Lambda function"
}

output "sns_arn" {
  value       = aws_sns_topic.this.arn
  description = "ARN of the SNS topic"
}

output "sqs_arn" {
  value       = aws_sqs_queue.this.arn
  description = "ARN of the SQS queue"
}

output "dynamodb_arn" {
  value       = aws_dynamodb_table.this.arn
  description = "ARN of the DynamoDB table"
}

output "secretsmanager_secret" {
  value       = aws_secretsmanager_secret.this.arn
  description = "ARN of the Secrets Manager secret"
}