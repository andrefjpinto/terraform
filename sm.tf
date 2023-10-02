resource "aws_secretsmanager_secret" "this" {
  name                    = "${var.name}-${var.env}-sap-api-password"
  description             = "SAP API password for ${var.name}-${var.env}"
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "example" {
  secret_id     = aws_secretsmanager_secret.this.id
  secret_string = "example-string-to-protect"
}
