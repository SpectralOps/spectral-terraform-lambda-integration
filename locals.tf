locals {
  resource_name_pattern       = "spectral-${var.integration_type}-integration-${var.environment}"
  single_lambda_integration   = contains(["jira", "terraform"], var.integration_type) ? true : false
  multiple_lambda_integration = contains(["gitlab"], var.integration_type) ? true : false
  single_function_arn         = local.single_lambda_integration ? module.lambda_function[0].lambda_function_arn : null
  frontend_function_arn       = local.multiple_lambda_integration ? module.frontend_lambda_function[0].lambda_function_arn : null
  api_triggered_function_arn  = coalesce(local.single_function_arn, local.frontend_function_arn)
}