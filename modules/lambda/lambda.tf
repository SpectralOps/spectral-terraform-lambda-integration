locals {
  runtime                     = "nodejs14.x"
  lambda_handler              = "handler.app"
  lambda_source_code_zip_path = "${path.module}/source_code/${var.integration_type}/app.zip"
}

resource "aws_lambda_function" "spectral_scanner_lambda" {
  runtime       = local.runtime
  role          = aws_iam_role.lambda_execution_role.arn
  function_name = var.resource_name_pattern
  filename      = local.lambda_source_code_zip_path
  handler       = local.lambda_handler
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
}

resource "aws_cloudwatch_log_group" "lambda_log_group" {
  count             = var.should_write_logs ? 1 : 0
  name              = var.resource_name_pattern
  retention_in_days = var.logs_retention_in_days

  tags = merge(
    var.global_tags,
    lookup(var.tags, "lambda", {}),
  )
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    sid    = ""
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "lambda_execution_role" {
  name               = var.resource_name_pattern
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json

  tags = merge(
    var.global_tags,
    lookup(var.tags, "iam", {}),
  )
}

data "aws_iam_policy_document" "secrets_policy_document" {
  statement {
    sid       = ""
    effect    = "Allow"
    actions   = ["secretsmanager:GetSecretValue"]
    resources = var.secrets_arns
  }
}

resource "aws_iam_policy" "secrets_iam_policy" {
  count  = var.store_secret_in_secrets_manager ? 1 : 0
  policy = data.aws_iam_policy_document.secrets_policy_document.json

  tags = merge(
    var.global_tags,
    lookup(var.tags, "iam", {}),
  )
}

resource "aws_iam_role_policy_attachment" "lambda_execution_role_attachment" {
  role       = aws_iam_role.lambda_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "lambda_secrets_role_attachment" {
  count      = var.store_secret_in_secrets_manager ? 1 : 0
  role       = aws_iam_role.lambda_execution_role.name
  policy_arn = aws_iam_policy.secrets_iam_policy[count.index].arn
}