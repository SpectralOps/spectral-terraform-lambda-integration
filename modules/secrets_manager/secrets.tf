locals {
  secrets_arns = [for secret in aws_secretsmanager_secret.general_secret : secret.arn]
}

resource "aws_secretsmanager_secret" "general_secret" {
  count = length(var.secrets_names)
  name  = var.secrets_names[count.index]
}