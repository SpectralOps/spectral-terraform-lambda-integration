module "spectral_lambda_integration" {
  source = "github.com/SpectralOps/spectral-terraform-lambda-integration"

  account_id       = 111111111111
  aws_region       = "us-east-1"
  integration_type = "jira"

  env_vars = {
    # Required environment variables
    SPECTRAL_DSN       = "MySpectralDSN"
    JIRA_WEBHOOK_TOKEN = "MyWebhookToken"
    # Optional environment variables
    # EMAIL                   = "my@emailaddress.com"
    # JIRA_API_TOKEN          = "MyJiraApiToken"
    # JIRA_PROJECTS_BLACKLIST = ""
    # JIRA_PROJECTS_WHITELIST = ""
    # REMEDIATION_MODE        = "Redact finding" (Not active / Redact finding)
    # REDACTED_MESSAGE        = "MyRedactedMessage"
    # SPECTRAL_TAGS           = "iac,base,audit"
  }
}