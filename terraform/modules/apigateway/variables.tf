variable "project_name" {
  type        = string
  description = "Project name used to name API Gateway and logs"
}

variable "signup_lambda_arn" {
  type        = string
  description = "Invoke ARN of the signup Lambda function"
}

variable "login_lambda_arn" {
  type        = string
  description = "Invoke ARN of the login Lambda function"
}

variable "confirm_lambda_arn" {
  type        = string
  description = "Invoke ARN of the confirm Lambda function"
}
