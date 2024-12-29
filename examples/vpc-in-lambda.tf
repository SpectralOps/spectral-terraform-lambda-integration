module "spectral_lambda_integration" {
  source = "github.com/SpectralOps/spectral-terraform-lambda-integration"

  integration_type = "gitlab"

  env_vars = {
    # Required environment variables for GitLab integration
  }
  
  # With VPC configuration
  vpc_config = {
    subnet_ids         = ["subnet-12345678", "subnet-87654321"]
    security_group_ids = ["sg-12345678"]
  }
}