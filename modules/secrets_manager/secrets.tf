locals {
  secrets_arns = concat(
    [for secret in aws_secretsmanager_secret.general_secret : secret.arn],
    [aws_secretsmanager_secret.spectral_dsn.arn]
  )
}

resource "aws_secretsmanager_secret" "spectral_dsn" {
  name = "Spectral_Dsn"
}

resource "aws_secretsmanager_secret" "general_secret" {
  count = length(var.secrets_names)
  name  = var.secrets_names[count.index]
}