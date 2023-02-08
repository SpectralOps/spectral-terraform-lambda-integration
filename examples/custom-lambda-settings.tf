module "spectral_lambda_integration" {
  source = "github.com/SpectralOps/spectral-terraform-lambda-integration"

  integration_type = "terraform"

  lambda_function_timeout     = 320
  lambda_function_memory_size = 1024
  lambda_publsh               = true

  env_vars = {
    SPECTRAL_DSN = "MySpectralDSN"
    CHECK_POLICY = "Fail on any issue" # (Fail on any issue / Fail on warnings and above / Fail on errors only / Always Pass)
  }
}