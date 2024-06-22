locals {
  runtime                     = "nodejs20.x"
  lambda_source_code_zip_path = coalesce(var.lambda_source_code_path, "${path.module}/source_code/${var.integration_type}/${var.lambda_source_code_filename}")
}

resource "aws_lambda_function" "spectral_scanner_lambda" {
  runtime       = local.runtime
  filename      = local.lambda_source_code_zip_path
  handler       = var.lambda_handler
  function_name = var.resource_name_pattern
  role          = var.role_arn
  timeout       = var.timeout
  memory_size   = var.memory_size
  publish       = var.publish

  tags = merge(
    var.global_tags,
    lookup(var.tags, "lambda", {}),
  )

  environment {
    variables = local.env_vars
  }
}

resource "aws_cloudwatch_log_group" "lambda_log_group" {
  count             = var.should_write_logs ? 1 : 0
  name              = "/aws/lambda/${var.resource_name_pattern}"
  retention_in_days = var.logs_retention_in_days

  tags = merge(
    var.global_tags,
    lookup(var.tags, "lambda", {}),
  )
}