output "secrets_arns" {
  value = [
    aws_secretsmanager_secret.gitlab_token.arn,
    aws_secretsmanager_secret.gitlab_webhook_secret.arn
  ]
}
