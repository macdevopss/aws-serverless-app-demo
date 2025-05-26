output "users_table_name" {
  description = "Users tablosunun adı"
  value       = aws_dynamodb_table.users.name
}
