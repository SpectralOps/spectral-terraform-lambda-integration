module "lambda_function" {
  count                       = local.single_lambda_integration ? 1 : 0
  source                      = "./modules/lambda"
  global_tags                 = var.global_tags
  tags                        = var.tags
  environment                 = var.environment
  integration_type            = var.integration_type
  resource_name_pattern       = local.api_triggered_function_name
  env_vars                    = local.env_vars
  logs_retention_in_days      = var.lambda_logs_retention_in_days
  should_write_logs           = var.lambda_enable_logs
  timeout                     = var.lambda_function_timeout
  memory_size                 = var.lambda_function_memory_size
  publish                     = var.lambda_publish
  secrets_arns                = var.store_secret_in_secrets_manager ? module.secrets_manager[0].secrets_arns : []
  lambda_source_code_filename = "app.zip"
  lambda_source_code_path     = var.lambda_source_code_path
  role_arn                    = module.lambda_role.lambda_role_arn
  vpc_config                  = var.vpc_config
  lambda_role_id              = module.lambda_role.lambda_role_id
}