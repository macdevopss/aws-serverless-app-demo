variable "project_name" {
  description = "Proje adı prefix"
  type        = string
}

variable "pre_signup_lambda_arn" {
  description = "Pre SignUp trigger için Lambda ARN"
  type        = string
}

variable "post_confirmation_lambda_arn" {
  description = "Post Confirmation trigger için Lambda ARN"
  type        = string
}
