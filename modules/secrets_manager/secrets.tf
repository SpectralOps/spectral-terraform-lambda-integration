locals {
  secrets_arns = concat(
    try(module.gitlab[0].secrets_arns, []),
    [aws_secretsmanager_secret.spectral_dsn.arn]
  )
}

resource "aws_secretsmanager_secret" "spectral_dsn" {
  name = "Spectral_Dsn"
}

module "gitlab" {
  count  = var.integration_type == "gitlab" ? 1 : 0
  source = "./gitlab"
}