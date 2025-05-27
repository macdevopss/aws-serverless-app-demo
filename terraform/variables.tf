variable "aws_region" {
  type        = string
  description = "AWS region"
}

variable "project_name" {
  type        = string
  description = "Project name prefix for all resources"
}

variable "environment" {
  type        = string
  description = "Deployment environment (e.g., dev, prod)"
}
