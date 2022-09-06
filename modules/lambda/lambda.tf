locals {
  runtime                           = "nodejs14.x"
  lambda_handler                    = "handler.app"
  public_spectral_version_layer_arn = "arn:aws:lambda:us-east-1:597416911928:layer:spectral_scanner:21"
  lambda_source_code_zip_path       = "${path.module}/source_code/${var.integration_type}/app.zip"
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

  layers = [local.public_spectral_version_layer_arn]

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

resource "aws_iam_role_policy_attachment" "lambda_execution_role" {
  role       = aws_iam_role.lambda_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}