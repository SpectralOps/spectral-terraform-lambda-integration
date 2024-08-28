module "spectral_lambda_integration" {
  source = "github.com/SpectralOps/spectral-terraform-lambda-integration"

  integration_type = "gitlab"

  env_vars = {
    # Required environment variables 
    SPECTRAL_DSN          = "MySpectralDSN"
    CHECK_POLICY          = "Fail on any issue" # (Fail on any issue / Fail on warnings and above / Fail on errors only / Always Pass)
    GITLAB_ACCESS_TOKEN   = "MyGitlabToken"
    GITLAB_WEBHOOK_SECRET = "MyGitlabWebhookSecret"
    # Optional environment variables
    # STRICT_MODE   = false / true
    # SPECTRAL_TAGS = "iac,base,audit"
  }
}