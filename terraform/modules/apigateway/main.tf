output "api_endpoint" {
  value = aws_apigatewayv2_api.http_api.api_endpoint
}
resource "aws_apigatewayv2_integration" "confirm_lambda" {
  api_id             = aws_apigatewayv2_api.http_api.id
  integration_type   = "AWS_PROXY"
  integration_uri    = aws_lambda_function.confirm.invoke_arn
  integration_method = "POST"
  payload_format_version = "2.0"
  connection_type    = "INTERNET"
}
resource "aws_apigatewayv2_route" "confirm_route" {
  api_id             = aws_apigatewayv2_api.http_api.id
  route_key          = "POST /confirm"
  target             = "integrations/${aws_apigatewayv2_integration.confirm_lambda.id}"
  authorization_type = "NONE"
}
