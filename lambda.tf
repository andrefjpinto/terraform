data "archive_file" "lambda" {
  type        = "zip"
  source_file = "lambda/index.js"
  output_path = "lambda.zip"
}

resource "aws_lambda_function" "this" {
  filename      = "lambda.zip"
  function_name = "${var.name}-${var.env}-lambda"
  role          = aws_iam_role.lambda.arn
  handler       = "index.handler"

  source_code_hash = data.archive_file.lambda.output_base64sha256

  runtime = "nodejs18.x"

  environment {
    variables = {
      ENV            = var.env
      SNS_TOPIC      = aws_sns_topic.this.arn
      DYNAMODB_TABLE = aws_dynamodb_table.this.name
    }
  }

  tags = {
    name = "${var.name}-${var.env}-this"
  }
}