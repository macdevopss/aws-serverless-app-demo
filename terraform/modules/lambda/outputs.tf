output "signup_lambda_name" {
  value = aws_lambda_function.signup.function_name
}

output "login_lambda_name" {
  value = aws_lambda_function.login.function_name
}
output "signup_lambda_arn" {
  value = aws_lambda_function.signup.arn
}

output "login_lambda_arn" {
  value = aws_lambda_function.login.arn
}
