output "signup_lambda_arn" {
  value = aws_lambda_function.signup.invoke_arn
}

output "login_lambda_arn" {
  value = aws_lambda_function.login.invoke_arn
}

output "confirm_lambda_arn" {
  value = aws_lambda_function.confirm.invoke_arn
}
