locals {
  resource_name_pattern       = "spectral-${var.integration_type}-integration-${var.environment}"
  single_lambda_integration   = contains(["jira", "terraform"], var.integration_type) ? 1 : 0
  multuple_lambda_integration = contains(["gitlab"], var.integration_type) ? 1 : 0
}