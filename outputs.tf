output "rest_api_id" {
  value       = module.api_gateway.rest_api_id
  description = "The ID of the REST API"
}

output "rest_api_url" {
  value       = module.api_gateway.rest_api_url
  description = "The URL for accessing the lambda through the ApiGateway"
}

output "rest_api_arn" {
  value       = module.api_gateway.rest_api_arn
  description = "Amazon Resource Name (ARN) identifying your Rest API"
}

output "rest_api_execution_arn" {
  value       = module.api_gateway.rest_api_execution_arn
  description = "The execution ARN part to be used in lambda_permission's source_arn, not concatenated to other allowed API resources"
}

output "rest_api_lambda_execution_arn" {
  value       = module.api_gateway.rest_api_lambda_execution_arn
  description = "The execution ARN part to be used in lambda_permission's source_arn, concatenated with allowed API resources (method & path)"
}

output "lambda_function_arn" {
  value       = module.lambda_function[*].lambda_function_arn
  description = "Amazon Resource Name (ARN) identifying your Lambda Function"
}

output "lambda_function_name" {
  value       = module.lambda_function[*].lambda_function_name
  description = "The name of the lambda function"
}

output "lambda_iam_role_arn" {
  value       = module.lambda_role.lambda_role_arn
  description = "Amazon Resource Name (ARN) specifying the role"
}

output "lambda_iam_role_name" {
  value       = module.lambda_role.lambda_role_name
  description = "Name of the role"
}

output "secrets_arns" {
  value       = module.secrets_manager[*].secrets_arns
  description = "Arns of created secrets in secrets manager"
}
