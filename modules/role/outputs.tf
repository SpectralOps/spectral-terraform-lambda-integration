output "lambda_role_name" {
  value = aws_iam_role.lambda_execution_role.name
}

output "lambda_role_arn" {
  value = aws_iam_role.lambda_execution_role.arn
}