resource "aws_sns_topic" "integration_erp_mes_sns_topic" {
  name = "${var.name}-${var.env}-retry-topic"
}
