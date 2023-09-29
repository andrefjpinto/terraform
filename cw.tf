resource "aws_cloudwatch_event_rule" "integration_erp_mes_rule" {
  name                = "${var.name}-${var.env}-rule"
  description         = "Trigger the integration lambda every minute"
  schedule_expression = "rate(1 minute)"
}

resource "aws_cloudwatch_event_target" "event_target" {
  rule      = aws_cloudwatch_event_rule.integration_erp_mes_rule.name
  target_id = "event_target"
  arn       = aws_lambda_function.integration_erp_mes_lambda.arn
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_rw_fallout_retry_step_deletion_lambda" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.integration_erp_mes_lambda.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.integration_erp_mes_rule.arn
}