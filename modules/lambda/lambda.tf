data "aws_partition" "current" {}

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
    variables = var.env_vars
  }

  dynamic "vpc_config" {
    for_each = var.vpc_config != null ? [var.vpc_config] : []
    content {
      subnet_ids         = vpc_config.value.subnet_ids
      security_group_ids = vpc_config.value.security_group_ids
    }
  }

  depends_on = [
    aws_iam_role_policy.lambda_vpc_policy,
  ]
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

data "aws_iam_policy" "lambda_vpc_policy" {
  count = var.vpc_config != null ? 1 : 0
  arn   = "arn:${data.aws_partition.current.partition}:iam::aws:policy/service-role/AWSLambdaENIManagementAccess"
}

resource "aws_iam_role_policy" "lambda_vpc_policy" {
  count  = var.vpc_config != null ? 1 : 0
  name   = "lambda-vpc-policy"
  role   = var.lambda_role_id
  policy = data.aws_iam_policy.lambda_vpc_policy[0].policy
}