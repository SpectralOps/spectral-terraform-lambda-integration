locals {
  gitlab_secrets_arns = var.integration_type == "gitlab" ? [
    aws_secretsmanager_secret.spectral_dsn[0].arn,
    aws_secretsmanager_secret.gitlab_token[0].arn,
    aws_secretsmanager_secret.gitlab_webhook_secret[0].arn
  ] : null
}

resource "aws_secretsmanager_secret" "gitlab_webhook_secret" {
  count                   = var.integration_type == "gitlab" ? 1 : 0
  name                    = "Spectral_GitlabBot_WebhookSecret"
}

resource "aws_secretsmanager_secret" "gitlab_token" {
  count                   = var.integration_type == "gitlab" ? 1 : 0
  name                    = "Spectral_GitlabBot_GitlabToken"
}

resource "aws_secretsmanager_secret" "spectral_dsn" {
  count                   = var.integration_type == "gitlab" ? 1 : 0
  name                    = "Spectral_Dsn"
}