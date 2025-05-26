resource "aws_iam_role" "lambda_exec_role" {
  name = "${var.project_name}-lambda-exec-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "lambda_basic_policy" {
  name        = "${var.project_name}-lambda-basic-policy"
  description = "CloudWatch Logs for Lambda"
  
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Effect   = "Allow",
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_logs_attach" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = aws_iam_policy.lambda_basic_policy.arn
}
resource "aws_lambda_permission" "apigw_invoke_confirm" {
  statement_id  = "AllowAPIGatewayInvokeConfirm"
  action        = "lambda:InvokeFunction"
  function_name = module.lambda.aws_lambda_function.confirm.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${module.apigateway.aws_apigatewayv2_api.http_api.execution_arn}/*/*"
}
