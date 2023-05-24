locals {
  resource_name_pattern = "spectral-${var.integration_type}-integration-${var.environment}"
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
  secrets_arns           = var.store_secret_in_secrets_manager ? module.secrets_manager.secrets_arns : []
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
  count            = var.store_secret_in_secrets_manager ? 1 : 0
  integration_type = var.integration_type
  source           = "./modules/secrets_manager"
}