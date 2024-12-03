module "spectral_lambda_integration" {
  source = "github.com/SpectralOps/spectral-terraform-lambda-integration"

  integration_type = "gitlab"

  env_vars = {
    # Required environment variables 
    SPECTRAL_DSN          = "MySpectralDSN"
    CHECK_POLICY          = "Fail on any issue" # (Fail on any issue / Fail on warnings and above / Fail on errors only / Always Pass)
    GITLAB_ACCESS_TOKEN   = "MyGitlabToken"
    GITLAB_WEBHOOK_SECRET = "MyGitlabWebhookSecret"
  }
  
  # With VPC configuration
  vpc_config = {
    subnet_ids         = ["subnet-12345678", "subnet-87654321"]
    security_group_ids = ["sg-12345678"]
  }
}