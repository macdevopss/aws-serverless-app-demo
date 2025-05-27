variable "project_name" {
  type        = string
  description = "Project name used as prefix for the DynamoDB table"
}

variable "environment" {
  type        = string
  description = "Deployment environment (e.g., dev, prod)"
}
