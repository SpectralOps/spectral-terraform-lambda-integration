module "spectral_lambda_integration" {
  source = "github.com/SpectralOps/spectral-terraform-lambda-integration?ref=v1.0.1"

  account_id       = 111111111111
  aws_region       = "us-east-1"
  integration_type = "terraform"

  tags = {
    iam = {
      Component = "IAM"
    }
    lambda = {
      Component = "Lambda"
    }
    api_gateway = {
      Component = "ApiGateway"
    }
  }

  global_tags = {
    BusinessUnit  = "Spectral"
    SomeGlobalTag = "Value"
  }

  env_vars = {
    SPECTRAL_DSN = "MySpectralDSN"
    CHECK_POLICY = "Always Pass"
  }
}