output "lambda_arn" {
  value = aws_lambda_function.this.arn
}

output "sns_arn" {
  value = aws_sns_topic.this.arn
}

output "lambda_policy_arn" {
  value = aws_iam_policy.this.arn
}

output "lambda_role_arn" {
  value = aws_iam_role.this.arn
}