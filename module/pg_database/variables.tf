#### VPC Variables ####
variable "vpc_id" {
    type = string  
}
######################### RDS variables #################
## DB Identifier
variable "db_identifier" {
    type = string
    default = "new-db"
}
## Alocated storage
variable "db_storage" {
    type = number
    default = 50
}
## MaX alocate
variable "max_allocated_storage_value" {
    type = number
    default = 500  
}
## DB engine
variable "db_engine" {
    type = string
    default = "postgres"
}

## DB engine version
variable "db_engine_version" {
    type = string
    default = "12.9"
}

## Instance Class
variable "db_class" {
    type = string
    default = "db.t3.micro"
}

## DB name
variable "db_name" {
    type = string
    default = "mydb"
}

## DB username
variable "db_username" {
    type = string
    default = "myuser"
}
## DB Password
variable "db_pass" {
    type = string
    default = "myDbPass"
}
## DB Parameter group
variable "db_para_group_name" {
    type = string
    default = "default.postgres12"
}

## DB storeage type
variable "db_storage_type" {
    type = string
    default = "gp2"
}
## Backup retention period
variable "db_backup_retention_period" {
    type = number
    default = 7
}
## Multi AZ ?
variable "muli_az_enable" {
    type = string
    default = "true"
}
## storage_encrypted ?
variable "is_storage_encrypted" {
    type = string
    default = "true"
}
## DB deletion protection
variable "db_delete_protect" {
    type = string
    default = "true"
}
## Database subnet group name
variable "db_subnet_group_name" {
    type = string
    default = "default_sg"
}
## DB Security Grpup IDs
variable "vpc_sg_ids" {
    type = list(string)
    default = [ "sg-123yo42342iu" ]
}
## Monitoring Role ARN
variable "monitoring_role" {
    type = string
    default = "arn:aws:iam::285308278095:role/rds-monitoring-role"
}
################ Database Proxy #########
## Proxy name
variable "db_proxy_name" {
    type = string
    default = "euroleague-db-proxy" 
}
## Proxy debug_logging
variable "proxy_debug_login" {
    type = string
    default = "false"
}
## Engine Family
variable "db_engin_family" {
    type = string
    default = "POSTGRESQL"
}
## Idel Timeout
variable "db_proxy_idle_timeout" {
    type = number
    default = 1800
}
## proxy tls enable
variable "tls_require" {
    type = string
    default = "false"  
}
## proxy security group
variable "db_proxy_secret_arn" {
    type = string
    default = "arn:aws:secretsmanager:ca-central-1:285308278095:secret:euroleague/db/cred-JWAyzF"
  
}
## Proxy IAM role ARV
variable "db_proxy_role" {
    type = string
    default = "arn:aws:iam::285308278095:role/rds-proxy-role"
}
## DB Proxy vpc_security_group_ids
variable "vpc_security_group_ids" {
    type = list(string)
}
/*
## DB Proxy private_subnet_list
variable "private_subnet_list" {
    type = list(string)
}
*/