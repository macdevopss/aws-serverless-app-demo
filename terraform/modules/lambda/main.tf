resource "aws_lambda_function" "signup" {
  function_name = "${var.project_name}-signup"
  filename      = abspath("${path.module}/../../../lambda/signup.zip")
  handler       = "signup.lambda_handler"
  runtime       = "python3.9"
  role          = var.lambda_exec_role_arn
  memory_size   = 128
  timeout       = 10

  environment {
    variables = {
      USER_POOL_ID = var.cognito_user_pool_id
      CLIENT_ID    = var.cognito_app_client_id
    }
  }

  source_code_hash = filebase64sha256(abspath("${path.module}/../../../lambda/signup.zip"))
}

resource "aws_lambda_function" "login" {
  function_name = "${var.project_name}-login"
  filename      = abspath("${path.module}/../../../lambda/login.zip")
  handler       = "login.lambda_handler"
  runtime       = "python3.9"
  role          = var.lambda_exec_role_arn
  memory_size   = 128
  timeout       = 10

  environment {
    variables = {
      USER_POOL_ID = var.cognito_user_pool_id
      CLIENT_ID    = var.cognito_app_client_id
    }
  }

  source_code_hash = filebase64sha256(abspath("${path.module}/../../../lambda/login.zip"))
}
resource "aws_lambda_function" "confirm" {
  function_name = "${var.project_name}-confirm"
  filename      = "${path.root}/lambda/confirm.zip"
  handler       = "confirm.lambda_handler"
  runtime       = "python3.9"
  role          = var.lambda_exec_role_arn
  memory_size   = 128
  timeout       = 10

  environment {
    variables = {
      USER_POOL_ID = var.cognito_user_pool_id
      CLIENT_ID    = var.cognito_app_client_id
    }
  }

  source_code_hash = filebase64sha256("${path.root}/lambda/confirm.zip")
}
