locals {
  cognito_groups = {
    admin    = { description = "Administratoren", precedence = 1 }
    vendor   = { description = "Lieferanten",    precedence = 2 }
    customer = { description = "Kunden",         precedence = 3 }
    driver   = { description = "Fahrer",         precedence = 4 }
  }
}

resource "aws_cognito_user_group" "groups" {
  for_each     = local.cognito_groups
  user_pool_id = aws_cognito_user_pool.main.id
  name         = each.key
  description  = each.value.description
  precedence   = each.value.precedence
}
