data "archive_file" "lambda" {
  type        = "zip"
  source_file = "lambda/index.js"
  output_path = "lambda.zip"
}

resource "aws_lambda_function" "integration_erp_mes_lambda" {
  filename      = "lambda.zip"
  function_name = "${var.name}-${var.env}-lambda"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "index.handler"

  source_code_hash = data.archive_file.lambda.output_base64sha256

  runtime = "nodejs18.x"

  environment {
    variables = {
      ENV            = var.env
      SNS_TOPIC      = aws_sns_topic.integration_erp_mes_sns_topic.arn
      DYNAMODB_TABLE = aws_dynamodb_table.integration_erp_mes_dynamodb_table.name
    }
  }

  tags = {
    Name        = "${var.name}-${var.env}-integration_erp_mes_lambda"
    Environment = var.env
  }
}