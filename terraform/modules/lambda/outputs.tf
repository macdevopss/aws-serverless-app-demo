output "signup_lambda_arn" {
  value = aws_lambda_function.signup.invoke_arn
}

output "login_lambda_arn" {
  value = aws_lambda_function.login.invoke_arn
}

output "confirm_lambda_arn" {
  value = aws_lambda_function.confirm.invoke_arn
}
output "pre_signup_lambda_arn" {
  value = aws_lambda_function.pre_signup.arn
}

output "post_confirmation_lambda_arn" {
  value = aws_lambda_function.post_confirmation.arn
}
