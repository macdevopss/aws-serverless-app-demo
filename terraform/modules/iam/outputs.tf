output "lambda_exec_role_arn" {
  value       = aws_iam_role.lambda_exec.arn
  description = "IAM role ARN for Lambda execution"
}

output "lambda_exec_role_name" {
  value       = aws_iam_role.lambda_exec.name
  description = "IAM role name for Lambda execution"
}
