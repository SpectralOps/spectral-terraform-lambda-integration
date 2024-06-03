locals {
  resource_name_pattern        = coalesce(var.resource_name_common_part, "spectral-${var.integration_type}-integration-${var.environment}-${random_string.random_resource_name_suffix.id}")
  single_lambda_integration    = contains(["jira", "terraform"], var.integration_type) ? true : false
  multiple_lambda_integration  = contains(["gitlab", "github"], var.integration_type) ? true : false
  api_triggered_function_arn   = local.single_lambda_integration ? module.lambda_function[0].lambda_function_arn : module.frontend_lambda_function[0].lambda_function_arn
  frontend_lambda_handler      = contains(["github"], var.integration_type) ? "index.handler" : "frontend.app"
  backend_lambda_handler       = contains(["github"], var.integration_type) ? "index.handler" : "backend.app"
  shared_default_secrets_names = ["Spectral_Dsn"]
  default_secrets_names = {
    "github" = coalesce(var.secrets_names, concat(local.shared_default_secrets_names, ["Spectral_GithubBot_PrivateKey", "Spectral_GithubBot_WebhookSecret"])),
    "gitlab" = coalesce(var.secrets_names, concat(local.shared_default_secrets_names, ["Spectral_GitlabBot_GitlabToken", "Spectral_GitlabBot_WebhookSecret"]))
  }
  # Please do not change or replace the 'frontend' suffix since there a logic in the bot based in it
  api_integrated_function_name = local.single_lambda_integration ? local.resource_name_pattern : "${local.resource_name_pattern}-frontend"
}