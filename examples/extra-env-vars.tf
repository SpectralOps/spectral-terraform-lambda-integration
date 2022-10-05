module "spectral_lambda_integration" {
  source = "github.com/SpectralOps/spectral-terraform-lambda-integration?ref=v1.0.1"

  account_id       = 111111111111
  aws_region       = "us-east-1"
  integration_type = "terraform"

  env_vars = {
    SPECTRAL_DSN       = "MySpectralDSN"
    CHECK_POLICY       = "Always Pass"
    TERRAFORM_USER_KEY = "MY-KEY"
    GITHUB_TOKEN       = "MY-TOKEN"
    # Extra environment variables goes here...
  }
}