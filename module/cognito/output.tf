## App Client ID
output "app_client_clientid" {
    value = aws_cognito_user_pool_client.client.id
}
## User pool id
output "user_pool_id" {
  value = aws_cognito_user_pool.pool.id
}

## Pool ARN
output "pool_arn" {
    value = aws_cognito_user_pool.pool.arn
}