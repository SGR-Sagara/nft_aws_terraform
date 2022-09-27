/*
## Refer main_network Module
module "main_network" {
  source = "../main_network"
}
*/

## Get Private SubnetList
data "aws_subnet_ids" "private_subnets" {
  vpc_id = var.vpc_id
  tags = {
    Access = "PRIVATE"
  }
}

## Create subnet group
resource "aws_db_subnet_group" "db_subnet_group" {
  name       = var.db_subnet_group_name
  subnet_ids = data.aws_subnet_ids.private_subnets.ids
  tags = {
    Name = var.db_subnet_group_name
  }
}

## Create Postgres Database Instance
resource "aws_db_instance" "postgress_database" {
    identifier = var.db_identifier
    allocated_storage = var.db_storage
    max_allocated_storage = var.max_allocated_storage_value
    engine = var.db_engine
    engine_version = var.db_engine_version
    instance_class = var.db_class
    name = var.db_name
    username = var.db_username
    password = var.db_pass
    #password = data.aws_secretsmanager_secret_version.password
    #password = aws_secretsmanager_secret_version.password.secret_string
    #parameter_group_name = var.db_para_group_name
    storage_encrypted = var.is_storage_encrypted
    storage_type = var.db_storage_type
    backup_retention_period = var.db_backup_retention_period
    multi_az = var.muli_az_enable
    db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
    vpc_security_group_ids = var.vpc_security_group_ids
    iam_database_authentication_enabled = true
    final_snapshot_identifier = "final-snap"
    skip_final_snapshot = false
    copy_tags_to_snapshot = true
    monitoring_role_arn = var.monitoring_role
    monitoring_interval = 60
    enabled_cloudwatch_logs_exports = ["postgresql"]
    deletion_protection = var.db_delete_protect
    depends_on = [aws_db_subnet_group.db_subnet_group]
}


## Create RDS Proxy
resource "aws_db_proxy" "example" {
  name = var.db_proxy_name
  debug_logging = var.proxy_debug_login
  engine_family = var.db_engin_family
  idle_client_timeout = var.db_proxy_idle_timeout
  require_tls = var.tls_require
  role_arn = var.db_proxy_role
  vpc_security_group_ids = var.vpc_security_group_ids
  vpc_subnet_ids = data.aws_subnet_ids.private_subnets.ids
  
  depends_on = [aws_db_instance.postgress_database]
  auth {
    auth_scheme = "SECRETS"
    description = "example"
    iam_auth    = "DISABLED"
    secret_arn  = var.db_proxy_secret_arn
  }
  tags = {
    Name = "${var.db_proxy_name}_proxy"
  }
}
