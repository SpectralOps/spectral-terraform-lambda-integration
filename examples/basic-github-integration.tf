module "spectral_lambda_integration" {
  source = "github.com/SpectralOps/spectral-terraform-lambda-integration"

  integration_type   = "github"
  lambda_enable_logs = true

  # Use this attributes to deploy specific version of the bot
  frontend_lambda_source_code_path = "./source-code/github/github-frontend.zip"
  backend_lambda_source_code_path  = "./source-code/github/github-backend.zip"

  env_vars = {
    # Required environment variables    
    SPECTRAL_DSN          = "MySpectralDSN"
    CHECK_POLICY          = "Fail on any issue" # (Fail on any issue / Fail on warnings and above / Fail on errors only / Always Pass)
    GITHUB_APP_ID         = "MyGitHubAppId"
    GITHUB_WEBHOOK_SECRET = "MyGitHubWebhookSecret"
    GITHUB_PRIVATE_KEY    = "MyGitHubPrivateKey"
    # Optional environment variables
    SECRETS_VAULT                      = "aws_secrets_manager"
    VAULT_KEY_SPECTRAL_DSN             = "Spectral_Dsn-..."
    VAULT_KEY_GITHUB_WEBHOOK_SECRET    = "Spectral_GithubBot_WebhookSecret-..."
    VAULT_KEY_GITHUB_PRIVATE_KEY       = "Spectral_GithubBot_PrivateKey-..."
    GITHUB_SHOULD_POST_REVIEW_COMMENTS = false
    GITHUB_SHOULD_SKIP_CHECK           = false
    S3_BLACK_LIST_OBJECT_KEY           = "The S3 object key of your blacklist flie"
    S3_BLACK_LIST_BUCKET_NAME          = "The S3 bucket name that holds your blacklist file"
    SHOULD_SKIP_INGEST                 = false
    STRICT_MODE                        = false
    SPECTRAL_TAGS                      = "iac,base,audit"
    HOME                               = "/tmp"
  }
}