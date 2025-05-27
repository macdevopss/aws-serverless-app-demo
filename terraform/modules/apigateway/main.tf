data "aws_caller_identity" "current" {}

# Create HTTP API
resource "aws_apigatewayv2_api" "http_api" {
  name          = "${var.project_name}-api"
  protocol_type = "HTTP"
}

# Lambda integrations
resource "aws_apigatewayv2_integration" "signup_lambda" {
  api_id                 = aws_apigatewayv2_api.http_api.id
  integration_type       = "AWS_PROXY"
  integration_uri        = var.signup_lambda_arn
  integration_method     = "POST"
  payload_format_version = "2.0"
  connection_type        = "INTERNET"
}

resource "aws_apigatewayv2_integration" "login_lambda" {
  api_id                 = aws_apigatewayv2_api.http_api.id
  integration_type       = "AWS_PROXY"
  integration_uri        = var.login_lambda_arn
  integration_method     = "POST"
  payload_format_version = "2.0"
  connection_type        = "INTERNET"
}

resource "aws_apigatewayv2_integration" "confirm_lambda" {
  api_id                 = aws_apigatewayv2_api.http_api.id
  integration_type       = "AWS_PROXY"
  integration_uri        = var.confirm_lambda_arn
  integration_method     = "POST"
  payload_format_version = "2.0"
  connection_type        = "INTERNET"
}

# Routes
resource "aws_apigatewayv2_route" "signup_route" {
  api_id             = aws_apigatewayv2_api.http_api.id
  route_key          = "POST /signup"
  target             = "integrations/${aws_apigatewayv2_integration.signup_lambda.id}"
  authorization_type = "NONE"
}

resource "aws_apigatewayv2_route" "login_route" {
  api_id             = aws_apigatewayv2_api.http_api.id
  route_key          = "POST /login"
  target             = "integrations/${aws_apigatewayv2_integration.login_lambda.id}"
  authorization_type = "NONE"
}

resource "aws_apigatewayv2_route" "confirm_route" {
  api_id             = aws_apigatewayv2_api.http_api.id
  route_key          = "POST /confirm"
  target             = "integrations/${aws_apigatewayv2_integration.confirm_lambda.id}"
  authorization_type = "NONE"
}

# CloudWatch log group
resource "aws_cloudwatch_log_group" "api_logs" {
  name              = "/aws/apigateway/${var.project_name}-logs"
  retention_in_days = 7
}

# Default stage with logging
resource "aws_apigatewayv2_stage" "default" {
  api_id      = aws_apigatewayv2_api.http_api.id
  name        = "$default"
  auto_deploy = true

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.api_logs.arn
    format = jsonencode({
      requestId        = "$context.requestId"
      sourceIp         = "$context.identity.sourceIp"
      requestTime      = "$context.requestTime"
      httpMethod       = "$context.httpMethod"
      routeKey         = "$context.routeKey"
      status           = "$context.status"
      protocol         = "$context.protocol"
      responseLength   = "$context.responseLength"
      integrationError = "$context.integrationErrorMessage"
    })
  }
}
