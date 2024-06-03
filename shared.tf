resource "random_string" "random_resource_name_suffix" {
  length  = 10
  special = false
  upper   = false
}

module "api_gateway" {
  source                = "./modules/api_gateway"
  global_tags           = var.global_tags
  tags                  = var.tags
  environment           = var.environment
  integration_type      = var.integration_type
  resource_name_pattern = local.resource_name_pattern
  function_name         = local.api_triggered_function_name
  lambda_function_arn   = local.api_triggered_function_arn
}

module "secrets_manager" {
  count            = var.store_secret_in_secrets_manager ? 1 : 0
  integration_type = var.integration_type
  source           = "./modules/secrets_manager"
  secrets_names    = local.default_secrets_names[var.integration_type]
}

module "lambda_role" {
  source                          = "./modules/role"
  role_name                       = local.api_triggered_function_name
  store_secret_in_secrets_manager = var.store_secret_in_secrets_manager
  secrets_arns                    = var.store_secret_in_secrets_manager ? module.secrets_manager[0].secrets_arns : []
  tags                            = var.tags
  global_tags                     = var.global_tags
  multiple_lambda_integration     = local.multiple_lambda_integration
}