locals {
  should_create_s3_policy = var.blacklist_object_arn != null ? 1 : 0
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
  name               = var.role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json

  tags = merge(
    var.global_tags,
    lookup(var.tags, "iam", {}),
  )
}

data "aws_iam_policy_document" "s3_policy_document" {
  count = local.should_create_s3_policy
  statement {
    sid       = ""
    effect    = "Allow"
    actions   = ["s3:GetObject"]
    resources = [var.blacklist_object_arn]
  }
}

resource "aws_iam_policy" "s3_iam_policy" {
  count  = local.should_create_s3_policy
  policy = data.aws_iam_policy_document.s3_policy_document[count.index].json

  tags = merge(
    var.global_tags,
    lookup(var.tags, "iam", {}),
  )
}

resource "aws_iam_role_policy_attachment" "s3_policy_attachment" {
  count      = local.should_create_s3_policy
  role       = aws_iam_role.lambda_execution_role.name
  policy_arn = aws_iam_policy.s3_iam_policy[count.index].arn
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

resource "aws_iam_role_policy_attachment" "lambda_execution_role" {
  role       = aws_iam_role.lambda_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "lambda_secrets_policy_attachment" {
  count      = var.store_secret_in_secrets_manager ? 1 : 0
  role       = aws_iam_role.lambda_execution_role.name
  policy_arn = aws_iam_policy.secrets_iam_policy[count.index].arn
}