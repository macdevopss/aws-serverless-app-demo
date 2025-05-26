output "lambda_role_arn" {
  description = "Lambda'nın kullanacağı rol ARN'si"
  value       = aws_iam_role.lambda_exec_role.arn
}
