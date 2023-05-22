resource "aws_secretsmanager_secret" "gitlab_webhook_secret" {
  name                    = "SpectralGitlabBot_WebhookSecret"
  recovery_window_in_days = 30
}

resource "aws_secretsmanager_secret" "gitlab_token" {
  name                    = "SpectralGitlabBot_GitlabToken"
  recovery_window_in_days = 30
}

resource "aws_secretsmanager_secret" "spectral_dsn" {
  name                    = "SpectralDsn"
  recovery_window_in_days = 30
}