## Calling the relevant modules for execution
/*
# 0. Call utility for basic set up
module "basic_utility" {
  source = "./module/basic_utility"
}
*/

# 1. Call the main network module
module "main_network" {
  source = "./module/main_network"
  vpc_name = var.vpc_name
  vpc_cidr = var.vpc_cidr
  public_source_cidr = var.public_source_cidr
  public_source_cidr_v6 = var.public_source_cidr_v6
  ig_name = var.ig_name

  public_subnets = var.public_subnets
  private_subnets = var.private_subnets
  public_access_sg_ingress_rules = var.public_access_sg_ingress_rules
  public_rt = var.public_rt
  private_rt = var.private_rt
}


# 2. Call Databse creation module
module "pg_database" {
  source = "./module/pg_database"
  db_identifier = var.db_identifier
  vpc_id = module.main_network.vpc_id
  vpc_security_group_ids = [module.main_network.private_security_group]
  #vpc_subnet_ids = module.main_network.private_subnet_list
  db_name = var.db_name
  #allocated_storage = var.db_storage
  #max_allocated_storage = var.max_allocated_storage_value
  #engine = var.db_engine
  #engine_version = var.db_engine_version
  #instance_class = var.db_class
  #username = var.db_username
  #password = var.db_pass
  #parameter_group_name = var.db_para_group_name
  #storage_encrypted = var.is_storage_encrypted
  #storage_type = var.db_storage_type
  #backup_retention_period = var.db_backup_retention_period
  #multi_az = var.muli_az_enable
  #deletion_protection = var.db_delete_protect
  depends_on = [module.main_network] 
}


## Create Cognito UserPool
module "cognito" {
  source = "./module/cognito"
}


# Create EC2 utility node
module "ec2_instances" {
  source = "./module/ec2_instance"
  vpc_id = module.main_network.vpc_id
  ec2_node_cnt = var.ec2_node_cnt
  instance_type = var.instance_type
  ami_id = var.ami_id
  #iam_instance_profile = var.role_name
  vpc_security_group_ids = [module.main_network.public_security_group]
  #user_data = file(var.user_data_file)
  depends_on = [module.main_network] 
}

