module "frontend_lambda_function" {
  count                       = local.multiple_lambda_integration ? 1 : 0
  source                      = "./modules/lambda"
  global_tags                 = var.global_tags
  tags                        = var.tags
  environment                 = var.environment
  integration_type            = var.integration_type
  # Please do not change or replace the 'frontend' suffix since there a logic in the bot based in it
  resource_name_pattern       = "${local.resource_name_pattern}-frontend"
  env_vars                    = var.env_vars
  logs_retention_in_days      = var.lambda_logs_retention_in_days
  should_write_logs           = var.lambda_enable_logs
  lambda_handler              = local.frontend_lambda_handler
  timeout                     = var.lambda_function_timeout
  memory_size                 = var.lambda_function_memory_size
  publish                     = var.lambda_publish
  secrets_arns                = var.store_secret_in_secrets_manager ? module.secrets_manager[0].secrets_arns : []
  lambda_source_code_filename = "frontend.zip"
  lambda_source_code_path     = var.frontend_lambda_source_code_path
  role_arn                    = module.lambda_role.lambda_role_arn
}

module "backend_lambda_function" {
  count                       = local.multiple_lambda_integration ? 1 : 0
  source                      = "./modules/lambda"
  global_tags                 = var.global_tags
  tags                        = var.tags
  environment                 = var.environment
  integration_type            = var.integration_type
  # Please do not change or replace the 'backend' suffix since there a logic in the bot based in it
  resource_name_pattern       = "${local.resource_name_pattern}-backend"
  env_vars                    = var.env_vars
  logs_retention_in_days      = var.lambda_logs_retention_in_days
  should_write_logs           = var.lambda_enable_logs
  lambda_handler              = local.backend_lambda_handler
  timeout                     = var.lambda_function_timeout
  memory_size                 = var.lambda_function_memory_size
  publish                     = var.lambda_publish
  secrets_arns                = var.store_secret_in_secrets_manager ? module.secrets_manager[0].secrets_arns : []
  lambda_source_code_filename = "backend.zip"
  lambda_source_code_path     = var.backend_lambda_source_code_path
  role_arn                    = module.lambda_role.lambda_role_arn
}

data "aws_iam_policy_document" "lambda_invoke_policy_document" {
  statement {
    sid       = ""
    effect    = "Allow"
    actions   = ["lambda:InvokeFunction", "lambda:InvokeAsync"]
    resources = local.multiple_lambda_integration ? [module.backend_lambda_function[0].lambda_arn] : []
  }
}

resource "aws_iam_policy" "lambda_invoke_iam_policy" {
  count  = local.multiple_lambda_integration ? 1 : 0
  policy = data.aws_iam_policy_document.lambda_invoke_policy_document.json

  tags = merge(
    var.global_tags,
    lookup(var.tags, "iam", {}),
  )
}

resource "aws_iam_role_policy_attachment" "lambda_invoke_policy_attachment" {
  count      = local.multiple_lambda_integration ? 1 : 0
  role       = module.lambda_role.lambda_role_name
  policy_arn = aws_iam_policy.lambda_invoke_iam_policy[count.index].arn
}