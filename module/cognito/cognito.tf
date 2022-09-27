### AWS Cognito User Pool
resource "aws_cognito_user_pool" "pool" {
  name = "${var.pool_name}_user_pool"
  alias_attributes = [ "email" , "phone_number" , "preferred_username" ] ## Conflicts with username_attributes
  username_configuration {
    case_sensitive = "false"
  }
  password_policy {
      minimum_length = 8
      require_lowercase = "true"
      require_uppercase = "true"
      require_numbers = "true"
      require_symbols = "true"
      temporary_password_validity_days = 7
  }
  mfa_configuration = "OFF"
  auto_verified_attributes = [ "email" ]
  account_recovery_setting {
    recovery_mechanism {
      name = "verified_email"
      priority = 1
    }
    recovery_mechanism {
      name = "verified_phone_number"
      priority = 2
    }
  }

  verification_message_template {
    default_email_option = "CONFIRM_WITH_CODE"
    email_subject = "Your verification code"
    email_message = "Your verification code is {####}. "
  }
  schema {
    name = "email"
    attribute_data_type = "String"
    mutable = false
    required = true
    string_attribute_constraints {
      max_length = "2048"
      min_length = "0"
    }
  }
  user_pool_add_ons {
    advanced_security_mode = "OFF"
  }
  tags = {
    "Name" = "Cognito_user_Pool"
    "Type" = "Cognito_user_Pool"
  }
}



## Create App_Client
resource "aws_cognito_user_pool_client" "client" {
  name = "${var.client_name}_client"
  user_pool_id = aws_cognito_user_pool.pool.id
  generate_secret = "false"
  token_validity_units {
    access_token = "minutes"
    refresh_token = "days"
    id_token = "minutes"
  }
  access_token_validity = 60
  id_token_validity = 60
  refresh_token_validity = 30
  explicit_auth_flows = [ "ALLOW_CUSTOM_AUTH", "ALLOW_USER_SRP_AUTH", "ALLOW_REFRESH_TOKEN_AUTH" ]
  enable_token_revocation = "true"
  prevent_user_existence_errors = "ENABLED"
  supported_identity_providers = [ "COGNITO" ]
  callback_urls = [ "https://openidconnect.net/callback" ]
  allowed_oauth_flows = [ "code" ]
  allowed_oauth_scopes = [ "email", "openid", "profile" ]
  depends_on = [ aws_cognito_user_pool.pool ]
}

## Add domain prefix
resource "aws_cognito_user_pool_domain" "user_pool_domain" {
  domain          = var.d_prefix
  user_pool_id    = "${aws_cognito_user_pool.pool.id}"
}
