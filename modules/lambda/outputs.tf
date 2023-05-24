output "lambda_function_arn" {
  value = aws_lambda_function.spectral_scanner_lambda.invoke_arn
}

output "lambda_function_name" {
  value = aws_lambda_function.spectral_scanner_lambda.function_name
}

output "lambda_iam_role_arn" {
  value = aws_iam_role.lambda_role.arn
}

output "lambda_iam_role_name" {
  value = aws_iam_role.lambda_role.name
}