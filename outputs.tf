output "lambda_arn" {
  value = aws_lambda_function.integration_erp_mes_lambda.arn
}

output "sns_arn" {
  value = aws_sns_topic.integration_erp_mes_sns_topic.arn
}