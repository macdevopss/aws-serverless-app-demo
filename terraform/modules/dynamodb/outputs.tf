output "dynamodb_table_name" {
  description = "DynamoDB tablo adı"
  value       = aws_dynamodb_table.users.name
}

output "dynamodb_table_arn" {
  description = "DynamoDB tablo ARN değeri"
  value       = aws_dynamodb_table.users.arn
}
