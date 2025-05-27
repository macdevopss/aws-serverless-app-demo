output "users_table_name" {
  value       = aws_dynamodb_table.users.name
  description = "The name of the DynamoDB users table"
}

output "users_table_arn" {
  value       = aws_dynamodb_table.users.arn
  description = "The ARN of the DynamoDB users table"
}
