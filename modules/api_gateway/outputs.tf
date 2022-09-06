output "rest_api_url" {
  value = "${aws_api_gateway_deployment.rest_api_deployment.invoke_url}${aws_api_gateway_stage.rest_api_stage.stage_name}${aws_api_gateway_resource.event_resource.path}"
}

output "rest_api_arn" {
  value = aws_api_gateway_rest_api.gateway_rest_api.arn
}

output "rest_api_execution_arn" {
  value = aws_api_gateway_rest_api.gateway_rest_api.execution_arn
}

output "rest_api_lambda_execution_arn" {
  value = local.rest_api_execution_arn
}

output "rest_api_id" {
  value = aws_api_gateway_rest_api.gateway_rest_api.id
}