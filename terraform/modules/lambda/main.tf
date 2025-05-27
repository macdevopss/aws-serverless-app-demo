data "aws_caller_identity" "current" {}

# SIGNUP Lambda
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

# LOGIN Lambda
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

# CONFIRM Lambda
resource "aws_lambda_function" "confirm" {
  function_name = "${var.project_name}-confirm"
  filename      = abspath("${path.module}/../../../lambda/confirm.zip")
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

  source_code_hash = filebase64sha256(abspath("${path.module}/../../../lambda/confirm.zip"))
}

# PRE-SIGNUP Lambda
resource "aws_lambda_function" "pre_signup" {
  function_name = "${var.project_name}-pre-signup"
  filename      = abspath("${path.module}/../../../lambda/pre_signup.zip")
  handler       = "pre_signup.lambda_handler"
  runtime       = "python3.9"
  role          = var.lambda_exec_role_arn
  memory_size   = 128
  timeout       = 10

  environment {
    variables = {
      USER_POOL_ID = var.cognito_user_pool_id
    }
  }

  source_code_hash = filebase64sha256(abspath("${path.module}/../../../lambda/pre_signup.zip"))
}

# POST-CONFIRMATION Lambda
resource "aws_lambda_function" "post_confirmation" {
  function_name = "${var.project_name}-post-confirmation"
  filename      = abspath("${path.module}/../../../lambda/post_confirmation.zip")
  handler       = "post_confirmation.lambda_handler"
  runtime       = "python3.9"
  role          = var.lambda_exec_role_arn
  memory_size   = 128
  timeout       = 10

  environment {
    variables = {
      USER_POOL_ID = var.cognito_user_pool_id
    }
  }

  source_code_hash = filebase64sha256(abspath("${path.module}/../../../lambda/post_confirmation.zip"))
}

# API Gateway permission for signup function
resource "aws_lambda_permission" "allow_apigateway_invoke_signup" {
  statement_id  = "AllowExecutionFromAPIGatewaySignup"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.signup.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "arn:aws:execute-api:${var.aws_region}:${data.aws_caller_identity.current.account_id}:${var.apigateway_id}/*/POST/signup"
}
