resource "aws_secretsmanager_secret" "gitlab_webhook_secret" {
  name = "Spectral_GitlabBot_WebhookSecret"
}

resource "aws_secretsmanager_secret" "gitlab_token" {
  name = "Spectral_GitlabBot_GitlabToken"
}