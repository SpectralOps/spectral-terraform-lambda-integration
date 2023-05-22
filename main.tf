locals {
  resource_name_pattern = "spectral-${var.integration_type}-integration-${var.environment}"
  gitlab_secrets = var.store_secret_in_secrets_manager && var.integration_type == "gitlab" ? [
    module.secrets_manager.spectral_dsn_secret_arn,
    module.secrets_manager.gitlab_token_secret_arn,
    module.secrets_manager.gitlab_webhook_secret_arn,
  ] : null
}

module "lambda_function" {
  source                 = "./modules/lambda"
  global_tags            = var.global_tags
  tags                   = var.tags
  environment            = var.environment
  integration_type       = var.integration_type
  resource_name_pattern  = local.resource_name_pattern
  env_vars               = var.env_vars
  logs_retention_in_days = var.lambda_logs_retention_in_days
  should_write_logs      = var.lambda_enable_logs
  timeout                = var.lambda_function_timeout
  memory_size            = var.lambda_function_memory_size
  publish                = var.lambda_publish
  secrets_arns           = var.store_secret_in_secrets_manager ? coalesce(local.gitlab_secrets, []) : []
}

module "api_gateway" {
  source                = "./modules/api_gateway"
  global_tags           = var.global_tags
  tags                  = var.tags
  environment           = var.environment
  integration_type      = var.integration_type
  resource_name_pattern = local.resource_name_pattern
  lambda_function_arn   = module.lambda_function.lambda_function_arn
}

module "secrets_manager" {
  count  = var.store_secret_in_secrets_manager ? 1 : 0
  source = "./modules/secrets_manager"
}