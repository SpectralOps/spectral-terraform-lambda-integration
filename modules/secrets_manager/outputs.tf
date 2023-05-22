output "spectral_dsn_secret_arn" {
  value = aws_secretsmanager_secret.spectral_dsn.arn
}

output "gitlab_token_secret_arn" {
  value = aws_secretsmanager_secret.gitlab_token.arn
}

output "gitlab_webhook_secret_arn" {
  value = aws_secretsmanager_secret.gitlab_webhook_secret
}