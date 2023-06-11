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

module "lambda_role" {
  source = "./modules/role"
}