output "signup_lambda_arn" {
  value       = aws_lambda_function.signup.invoke_arn
  description = "Invoke ARN for the signup Lambda function"
}

output "login_lambda_arn" {
  value       = aws_lambda_function.login.invoke_arn
  description = "Invoke ARN for the login Lambda function"
}

output "confirm_lambda_arn" {
  value       = aws_lambda_function.confirm.invoke_arn
  description = "Invoke ARN for the confirm Lambda function"
}

output "pre_signup_lambda_name" {
  value       = aws_lambda_function.pre_signup.function_name
  description = "Function name for the PreSignUp Lambda trigger"
}

output "post_confirmation_lambda_name" {
  value       = aws_lambda_function.post_confirmation.function_name
  description = "Function name for the PostConfirmation Lambda trigger"
}
