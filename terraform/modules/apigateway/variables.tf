variable "project_name" {
  description = "Proje adı prefix"
  type        = string
}

variable "signup_lambda_arn" {
  description = "Signup Lambda fonksiyonunun ARN değeri"
  type        = string
}

variable "login_lambda_arn" {
  description = "Login Lambda fonksiyonunun ARN değeri"
  type        = string
}

variable "confirm_lambda_arn" {
  description = "Confirm Lambda fonksiyonunun ARN değeri"
  type        = string
  default     = null
}
