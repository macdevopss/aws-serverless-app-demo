output "apigateway_id" {
  description = "API Gateway HTTP API ID"
  value       = module.apigateway.http_api_id
}

output "api_endpoint" {
  description = "Base URL of the API Gateway"
  value       = module.apigateway.http_api_endpoint
}

output "aws_region" {
  description = "AWS region"
  value       = var.aws_region
}

output "project_name" {
  description = "Project name"
  value       = var.project_name
}
