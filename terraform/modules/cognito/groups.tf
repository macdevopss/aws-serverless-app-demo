resource "aws_cognito_user_group" "admin_group" {
  user_pool_id = var.user_pool_id
  name         = "admin"
  description  = "Admin group"
}

resource "aws_cognito_user_group" "vendor_group" {
  user_pool_id = var.user_pool_id
  name         = "vendor"
  description  = "Vendor group"
}

resource "aws_cognito_user_group" "customer_group" {
  user_pool_id = var.user_pool_id
  name         = "customer"
  description  = "Customer group"
}

resource "aws_cognito_user_group" "driver_group" {
  user_pool_id = var.user_pool_id
  name         = "driver"
  description  = "Driver group"
}
