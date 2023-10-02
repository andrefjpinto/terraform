resource "aws_lambda_function" "this" {
  filename      = "${path.module}/lambda/dist/index.zip"
  function_name = "${var.name}-${var.env}-lambda"
  handler       = "index.handler"
  role          = aws_iam_role.lambda.arn

  source_code_hash = filebase64sha256("${path.module}/lambda/dist/index.zip")

  runtime = "nodejs18.x"

  environment {
    variables = {
      ENV            = "dev"
      DYNAMODB_TABLE = aws_dynamodb_table.this.name
      SNS_TOPIC      = aws_sns_topic.this.arn
    }
  }
}

resource "aws_iam_role" "lambda" {
  name = "${var.name}-${var.env}-lambda-iam"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
      }
    ]
  })
}

resource "aws_iam_policy" "lambda" {
  name = "${var.name}-${var.env}-lambda-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ]
      Resource = ["arn:aws:logs:*:*:*"]
      },
      {
        Effect = "Allow"
        Action = [
          "sns:Publish",
        ]
        Resource = [
          aws_sns_topic.this.arn
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "dynamodb:PutItem",
        ]
        Resource = [
          aws_dynamodb_table.this.arn
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda" {
  policy_arn = aws_iam_policy.lambda.arn
  role       = aws_iam_role.lambda.name
}

resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.this.function_name
  principal     = "scheduler.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.this.arn
}