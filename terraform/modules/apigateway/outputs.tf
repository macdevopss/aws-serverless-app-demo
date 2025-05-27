output "http_api_id" {
  value       = aws_apigatewayv2_api.http_api.id
  description = "ID of the created HTTP API"
}

output "http_api_endpoint" {
  value       = aws_apigatewayv2_api.http_api.api_endpoint
  description = "Base URL endpoint of the API Gateway"
}
