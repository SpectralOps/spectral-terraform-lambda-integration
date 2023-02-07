module "spectral_lambda_integration" {
  source = "github.com/SpectralOps/spectral-terraform-lambda-integration"

  integration_type = "terraform"

  env_vars = {
    SPECTRAL_DSN       = "MySpectralDSN"
    CHECK_POLICY       = "Fail on any issue" # (Fail on any issue / Fail on warnings and above / Fail on errors only / Always Pass)
    TERRAFORM_USER_KEY = "MY-KEY"
    GITHUB_TOKEN       = "MY-TOKEN"
    # Extra environment variables goes here...
  }
}