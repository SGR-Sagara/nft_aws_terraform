######### RDS Secret setup ##################
/*
######## Database secret 
resource "random_password" "master"{
  length           = 16
  special          = true
  override_special = "_!%^"
}

resource "aws_secretsmanager_secret" "password" {
  name = "db-password"
}

resource "aws_secretsmanager_secret_version" "password" {
  secret_id = aws_secretsmanager_secret.password.id
  secret_string = random_password.master.result
}

######## Proxy secret
resource "random_password" "proxy"{
  length           = 16
  special          = true
  override_special = "_!%^"
}
resource "aws_secretsmanager_secret" "proxy_password" {
  name = "proxy-password"
}
resource "aws_secretsmanager_secret_version" "proxy_password" {
  secret_id = aws_secretsmanager_secret.proxy_password.id
  secret_string = random_password.proxy.result
}
*/