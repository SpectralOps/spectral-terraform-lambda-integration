locals {
  resource_name_pattern       = "spectral-${var.integration_type}-integration-${var.environment}"
  single_lambda_integration   = contains(["jira", "terraform"], var.integration_type) ? true : false
  multiple_lambda_integration = contains(["gitlab"], var.integration_type) ? true : false
  api_triggered_function_arn  = local.single_lambda_integration ? local.single_function_arn : local.frontend_function_arn
}