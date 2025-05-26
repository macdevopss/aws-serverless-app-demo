output "aws_region" {
  value = var.aws_region
}

output "project_name" {
  value = var.project_name
}
output "api_endpoint" {
  value = module.apigateway.api_endpoint
}
