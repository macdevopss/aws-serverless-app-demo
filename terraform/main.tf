module "iam" {
  source       = "./modules/iam"
  project_name = var.project_name
}

module "dynamodb" {
  source       = "./modules/dynamodb"
  project_name = var.project_name
}



module "lambda" {
  source                = "./modules/lambda"
  project_name          = var.project_name
  lambda_exec_role_arn  = module.iam.lambda_role_arn
  cognito_user_pool_id  = module.cognito.user_pool_id
  cognito_app_client_id = module.cognito.app_client_id
}

module "apigateway" {
  source            = "./modules/apigateway"
  project_name      = var.project_name
  signup_lambda_arn = module.lambda.signup_lambda_arn
  login_lambda_arn  = module.lambda.login_lambda_arn
  confirm_lambda_arn = module.lambda.confirm_lambda_arn
}
module "cognito" {
  source                       = "./modules/cognito"
  project_name                 = var.project_name
  pre_signup_lambda_arn       = module.lambda.pre_signup_lambda_arn
  post_confirmation_lambda_arn = module.lambda.post_confirmation_lambda_arn
}
