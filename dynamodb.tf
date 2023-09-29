resource "aws_dynamodb_table" "integration_erp_mes_dynamodb_table" {
  name           = "${var.name}-${var.env}-processed-records"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "PK"
  range_key      = "SK"

  attribute {
    name = "PK"
    type = "S"
  }

  attribute {
    name = "SK"
    type = "S"
  }

  tags = {
    Name        = var.name
    Environment = var.env
  }
}
