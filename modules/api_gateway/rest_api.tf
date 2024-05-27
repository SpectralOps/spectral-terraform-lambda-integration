locals {
  rest_api_execution_arn = "${aws_api_gateway_rest_api.gateway_rest_api.execution_arn}/*/${aws_api_gateway_method.get_method.http_method}${aws_api_gateway_resource.event_resource.path}"
}

resource "aws_api_gateway_rest_api" "gateway_rest_api" {
  name = var.resource_name_pattern

  tags = merge(
    var.global_tags,
    lookup(var.tags, "api_gateway", {}),
  )
}

resource "aws_api_gateway_resource" "event_resource" {
  rest_api_id = aws_api_gateway_rest_api.gateway_rest_api.id
  parent_id   = aws_api_gateway_rest_api.gateway_rest_api.root_resource_id
  path_part   = "spectral_${var.integration_type}_event"
}

resource "aws_api_gateway_method" "get_method" {
  rest_api_id   = aws_api_gateway_rest_api.gateway_rest_api.id
  resource_id   = aws_api_gateway_resource.event_resource.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "api_proxy_integration" {
  rest_api_id             = aws_api_gateway_rest_api.gateway_rest_api.id
  resource_id             = aws_api_gateway_resource.event_resource.id
  http_method             = aws_api_gateway_method.get_method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.lambda_function_arn
}

resource "aws_api_gateway_method_response" "response_200" {
  rest_api_id = aws_api_gateway_rest_api.gateway_rest_api.id
  resource_id = aws_api_gateway_resource.event_resource.id
  http_method = aws_api_gateway_method.get_method.http_method
  status_code = "200"
}

resource "aws_lambda_permission" "lambda_permission" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = var.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = local.rest_api_execution_arn
}

resource "aws_api_gateway_deployment" "rest_api_deployment" {
  rest_api_id = aws_api_gateway_rest_api.gateway_rest_api.id

  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_resource.event_resource.id,
      aws_api_gateway_method.get_method.id,
      aws_api_gateway_integration.api_proxy_integration.id
    ]))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "rest_api_stage" {
  deployment_id = aws_api_gateway_deployment.rest_api_deployment.id
  rest_api_id   = aws_api_gateway_rest_api.gateway_rest_api.id
  stage_name    = var.environment

  tags = merge(
    var.global_tags,
    lookup(var.tags, "api_gateway", {}),
  )
}