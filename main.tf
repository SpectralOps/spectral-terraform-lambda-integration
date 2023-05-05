locals {
  resource_name_pattern = "spectral-${var.integration_type}-integration-${var.environment}"
}

module "lambda_function" {
  source                 = "./modules/lambda"
  global_tags            = var.global_tags
  tags                   = var.tags
  environment            = var.environment
  integration_type       = var.terraform
  resource_name_pattern  = local.resource_name_pattern
  env_vars               = var.env_vars
  logs_retention_in_days = var.lambda_logs_retention_in_days
  should_write_logs      = var.lambda_enable_logs
  timeout                = var.lambda_function_timeout
  memory_size            = var.lambda_function_memory_size
  publish                = var.lambda_publish
}

module "api_gateway" {
  source                = "./modules/api_gateway"
  global_tags           = var.global_tags
  tags                  = var.tags
  environment           = var.environment
  integration_type      = var.terraform
  resource_name_pattern = local.resource_name_pattern
  lambda_function_arn   = module.lambda_function.lambda_function_arn
}
