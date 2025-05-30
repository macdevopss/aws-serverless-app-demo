

module "dynamodb" {
  source       = "./modules/dynamodb"
  project_name = var.project_name
  environment  = var.environment
}

module "cognito" {
  source       = "./modules/cognito"
  project_name = var.project_name
  environment  = var.environment
}

module "iam" {
  source       = "./modules/iam"
  project_name = var.project_name
  environment  = var.environment
}

module "lambda" {
  source                  = "./modules/lambda"
  project_name            = var.project_name
  environment             = var.environment
  lambda_exec_role_arn    = module.iam.lambda_exec_role_arn
  cognito_user_pool_id    = module.cognito.user_pool_id
  cognito_app_client_id   = module.cognito.client_id
  aws_region              = var.aws_region
  apigateway_id           = module.apigateway.http_api_id
}

module "apigateway" {
  source             = "./modules/apigateway"
  project_name       = var.project_name
  signup_lambda_arn  = module.lambda.signup_lambda_arn
  login_lambda_arn   = module.lambda.login_lambda_arn
  confirm_lambda_arn = module.lambda.confirm_lambda_arn
}
