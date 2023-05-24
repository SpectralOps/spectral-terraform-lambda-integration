output "rest_api_id" {
  value = module.api_gateway.rest_api_id
}

output "rest_api_url" {
  value = module.api_gateway.rest_api_url
}

output "rest_api_arn" {
  value = module.api_gateway.rest_api_arn
}

output "rest_api_execution_arn" {
  value = module.api_gateway.rest_api_execution_arn
}

output "rest_api_lambda_execution_arn" {
  value = module.api_gateway.rest_api_lambda_execution_arn
}

output "lambda_function_arn" {
  value = module.lambda_function.lambda_function_arn
}

output "lambda_function_name" {
  value = module.lambda_function.lambda_function_name
}

output "lambda_iam_role_arn" {
  value = module.lambda_function.lambda_iam_role_arn
}

output "lambda_iam_role_name" {
  value = module.lambda_function.lambda_iam_role_name
}

output "secrets_arns" {
  value = module.secrets_manager.secrets_arns
}
