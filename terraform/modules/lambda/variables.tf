variable "project_name" {
  type        = string
  description = "Project name prefix for all Lambda functions"
}

variable "environment" {
  type        = string
  description = "Deployment environment (e.g., dev, staging, prod)"
}

variable "lambda_exec_role_arn" {
  type        = string
  description = "IAM role ARN for Lambda execution"
}

variable "cognito_user_pool_id" {
  type        = string
  description = "Cognito User Pool ID"
}

variable "cognito_app_client_id" {
  type        = string
  description = "Cognito App Client ID"
}

variable "aws_region" {
  type        = string
  description = "AWS region for deployment"
}

variable "apigateway_id" {
  type        = string
  description = "ID of the API Gateway for invoking Lambda"
}
