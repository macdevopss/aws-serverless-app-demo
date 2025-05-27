output "user_pool_id" {
  value       = aws_cognito_user_pool.main.id
  description = "ID of the Cognito User Pool"
}

output "client_id" {
  value       = aws_cognito_user_pool_client.main.id
  description = "ID of the Cognito App Client"
}
