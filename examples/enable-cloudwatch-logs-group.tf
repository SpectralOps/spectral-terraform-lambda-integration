module "spectral_lambda_integration" {
  source = "github.com/SpectralOps/spectral-terraform-lambda-integration?ref=v1.0.1"

  account_id                    = 111111111111
  aws_region                    = "us-east-1"
  integration_type              = "terraform"
  lambda_enable_logs            = true
  lambda_logs_retention_in_days = 10

  env_vars = {
    SPECTRAL_DSN = "MySpectralDSN"
    CHECK_POLICY = "Always Pass"
  }
}