// AWS VPC module
module "vpc" {
  count  = var.vpc-create ? var.vpc-count : 0
  source = "terraform-aws-modules/vpc/aws"

  name = "yash-vpc"
  cidr = var.cird


  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = var.tags
}

//--------------------------------------------------------------

// AWS Security group Module
module "security-group" {
  count   = var.security-group-create ? var.security-group-count : 0
  source  = "terraform-aws-modules/security-group/aws"
  version = "3.11.0"
  # insert the 2 required variables here
  name   = var.security_group_name
  vpc_id = var.vpc_id
}

//-------------------------------------------------------------------




// EC2 Module
module "ec2-instance" {
  // meta-arguments
  count   = var.ec2_instance_create ? var.ec2_instance_count : 0
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "2.15.0"
  // arguments
  name                        = var.ec2_name
  ami                         = var.ec2_ami
  instance_type               = var.ec2_instance_type
  vpc_security_group_ids      = var.ec2_vpc_security_group_ids
  associate_public_ip_address = var.associate_public_ip_address
  private_ip                  = var.ec2_private_ip
  ipv6_address_count          = var.ec2_ipv6_address_count
  ipv6_addresses              = var.ec2_ipv6_addresses
  user_data                   = var.ec2_user_data
  subnet_id                   = var.ec2_subnet_id

  tags = var.tags
}


//---------------------------------

// Module for EFS
module "efs" {
  // meta-arguments
  count   = var.efs_create ? var.efs-count : 0
  source  = "AustinCloudGuru/efs/aws"
  version = "0.2.3"
  // arguments
  # insert the 3 required variables here

  efs_name   = var.efs_name
  subnet_ids = var.efs_subnet_ids
  vpc_id     = var.efs_vpc_id

  tags = var.tags
}

//-------------------------------------


//Module for S3
module "s3-bucket" {
  // meta-arguments
  count   = var.create_bucket ? var.bucket_count : 0
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "1.9.0"
  // arguments
  # insert the 6 required variables here
  acceleration_status = var.acceleration_status
  bucket              = var.bucket
  bucket_prefix       = var.bucket_prefix
  policy              = var.policy
  region              = var.region
  request_payer       = var.request_payer
  force_destroy       = var.force_destroy
  tags                = var.tags

}

//---------------------------------

// Cloudtrail Module

module "cloudtrail" {
  // meta-arguments
  count   = var.create_ct ? var.count_ct : 0
  source  = "trussworks/cloudtrail/aws"
  version = "2.0.2"
  // arguments
  s3_bucket_name              = var.s3_bucket_name
  cloudwatch_log_group_name   = var.cloudwatch_log_group_name
  encrypt_cloudtrail          = var.encrypt_cloudtrail
  key_deletion_window_in_days = var.key_deletion_window_in_days
  log_retention_days          = var.log_retention_days
  org_trail                   = var.org_trail
}

//-----------------------------------------



// SNS Module
module "sns" {
  // meta-arguments	
  count   = var.create_sns_topic ? var.sns-count : 0
  source  = "terraform-aws-modules/sns/aws"
  version = "2.1.0"
  // arguments	
  # insert the 18 required variables here
  application_failure_feedback_role_arn    = var.application_failure_feedback_role_arn
  application_success_feedback_role_arn    = var.application_success_feedback_role_arn
  application_success_feedback_sample_rate = var.application_success_feedback_sample_rate
  delivery_policy                          = var.delivery_policy
  display_name                             = var.display_name
  http_failure_feedback_role_arn           = var.http_failure_feedback_role_arn
  http_success_feedback_role_arn           = var.http_success_feedback_role_arn
  http_success_feedback_sample_rate        = var.http_success_feedback_sample_rate
  kms_master_key_id                        = var.kms_master_key_id
  lambda_failure_feedback_role_arn         = var.lambda_failure_feedback_role_arn
  lambda_success_feedback_role_arn         = var.lambda_success_feedback_role_arn
  lambda_success_feedback_sample_rate      = var.lambda_success_feedback_sample_rate
  name                                     = var.name
  name_prefix                              = var.name_prefix
  policy                                   = var.sns_policy
  sqs_failure_feedback_role_arn            = var.sqs_failure_feedback_role_arn
  sqs_success_feedback_role_arn            = var.sqs_success_feedback_role_arn
  sqs_success_feedback_sample_rate         = var.sqs_success_feedback_sample_rate
  tags                                     = var.tags
}

//--------------------------------------

// SQS Module
module "sqs" {
  // meta-arguments
  count   = var.sqs-create ? var.sqs-count : 0
  source  = "terraform-aws-modules/sqs/aws"
  version = "2.1.0"
  // arguments
  # insert the 3 required variables here
  kms_master_key_id = var.sqs_kms_master_key_id
  name              = var.sqs_name
  name_prefix       = var.sqs_name_prefix
  tags              = var.tags

}

// -----------------------------

// WAF Module
module "waf" {
  // meta-arguments
  count   = var.create-waf ? var.count-waf : 0
  source  = "trussworks/waf/aws"
  version = "2.1.1"
  // arguments
  alb_arn                = var.alb_arn
  allowed_hosts          = var.allowed_hosts
  web_acl_metric_name    = var.web_acl_metric_name
  web_acl_name           = var.web_acl_name
  associate_alb          = var.associate_alb
  blocked_path_prefixes  = var.blocked_path_prefixes
  ip_sets                = var.ip_sets
  rate_based_rules       = var.rate_based_rules
  rules                  = var.waf_rules
  wafregional_rule_f5_id = var.wafregional_rule_f5_id
}

//------------------------------------------

// Billing_Alarm Module

module "billing-alarm" {
  // meta-arguments
  count   = var.create-BA ? var.count-BA : 0
  source  = "billtrust/billing-alarm/aws"
  version = "1.0.2"
  // arguments
  aws_env                   = var.aws_env
  monthly_billing_threshold = var.monthly_billing_threshold
  currency                  = var.bill_currency
}

// Route53 Module
module "route53" {
  // meta-arguments
  count   = var.create-r53 ? var.count-r53 : 0
  source  = "Aplyca/route53/aws"
  version = "0.2.0"
  // arguments
  # insert the 1 required variable here
  domain      = var.r53_domain
  alias       = var.r53_alias
  description = var.r53_zone_description
  records     = var.r53_records
  zone_id     = var.r53_zone_id
}

//-------------------------

// Terraform module for creating and managing Amazon Aurora clusters

module "aurora" {
  // meta-arguments
  count   = var.create-aurora ? var.count-aurora : 0
  source  = "claranet/aurora/aws"
  version = "4.1.0"
  // arguments
  azs             = var.aurora_azs
  envname         = var.aurora_envname
  envtype         = var.aurora_envtype
  name            = var.aurora_name
  password        = var.aurora_password
  security_groups = var.aurora_security_groups
  subnets         = var.aurora_subnets
  instance_type   = var.aurora_instance_type
  username        = var.aurora_username
  engine          = var.aurora_engine
  engine-version  = var.aurora_engine-version
}


//-------------------------------------------


// Terraform module to creates a KMS Customer Master Key (CMK) and its alias.

module "kms" {
  // meta-arguments
  count   = var.create-kms ? var.count-kms : 0
  source  = "clouddrove/kms/aws"
  version = "0.12.5"
  // arguments
  alias                    = var.kms_alias
  application              = var.kms_application
  attributes               = var.kms_attributes
  customer_master_key_spec = var.kms_customer_master_key_spec
  deletion_window_in_days  = var.kms_deletion_window_in_days
  description              = var.kms_description
  enable_key_rotation      = var.kms_enable_key_rotation
  enabled                  = var.kms_enabled
  environment              = var.kms_environment
  is_enabled               = var.kms_is_enabled
  key_usage                = var.kms_key_usage
  label_order              = var.kms_label_order
  managedby                = var.kms_managedby
  name                     = var.kms_name
  policy                   = var.kms_policy
  tags                     = var.kms_tags
}


//Terraform module which creates AWS ECS resources

module "ecs" {
  // meta-arguments
  count   = var.create_ecs ? var.count_ecs : 0
  source  = "terraform-aws-modules/ecs/aws"
  version = "2.3.0"
  // arguments
  name               = var.ecs_name
  container_insights = var.ecs_container_insights
  create_ecs         = var.create_ecs
  tags               = var.tags

}

//------------------------

// A Terraform module for creating a cross-account-accessible ECR repository.

module "ecr" {
  // meta-arguments
  count   = var.create-ecr ? var.count-ecr : 0
  source  = "telia-oss/ecr/aws"
  version = "2.1.0"
  // arguments
  name_prefix          = var.ecr_name_prefix
  trusted_accounts     = var.trusted_accounts
  enable_scan_on_push  = var.enable_scan_on_push
  image_tag_mutability = var.image_tag_mutability
  max_images_retained  = var.max_images_retained
  tags                 = var.tags

}

//----------------------------

// Terraform module that creates AWS CloudWatch metric filters and alarms

# First execution of terraform apply will fail as Log group requires 10-30 seconds to update. Need to execute terraform apply second time

# We need to create a loggroup before setting up a metric filter alarm, if you have already created log group pass values directly to the module 
#resource "aws_cloudwatch_log_group" "MyLogGroup" {
# name = var.metric_log_group_name
#}

module "metric-filter-alarm" {
  // meta-arguments
  count   = var.create-metric-filter-alarm ? var.count-metric-filter-alarm : 0
  source  = "dwp/metric-filter-alarm/aws"
  version = "1.1.6"
  // arguments
  log_group_name     = var.metric_log_group_name
  metric_namespace   = var.metric_namespace
  pattern            = var.metric_pattern
  alarm_name         = var.metric_alarm_name
  alarm_description  = var.metric_alarm_description
  metric_filter_name = var.metric_filter_name
}

//------------------------


// IAM-ROLE Module

module "iam-user" {
  // meta-arguments
  count   = var.create-iam ? var.count-iam : 0
  source  = "Flaconi/iam-user/aws"
  version = "0.2.1"
  // arguments
  # insert the 1 required variable here
  name = var.iam_name
  tags = var.tags

}

//-----------------------------

module "acm" {
  // meta-arguments
  count   = var.acm_create_certificate ? var.count-acm : 0
  source  = "terraform-aws-modules/acm/aws"
  version = "2.9.0"
  // arguments
  certificate_transparency_logging_preference = var.certificate_transparency_logging_preference
  create_certificate                          = var.acm_create_certificate
  dns_ttl                                     = var.acm_dns_ttl
  domain_name                                 = var.acm_domain_name
  subject_alternative_names                   = var.acm_subject_alternative_names
  tags                                        = var.acm_tags
  validate_certificate                        = var.acm_validate_certificate
  validation_allow_overwrite_records          = var.validation_allow_overwrite_records
  validation_method                           = var.acm_validation_method
  wait_for_validation                         = var.acm_wait_for_validation
  zone_id                                     = var.acm_zone_id
}

//-------------------------


// Module for Oracle RDS
module "oracle" {
  // meta-arguments
  count   = var.create-oracle ? var.count-oracle : 0
  source  = "terraform-aws-modules/rds/aws"
  version = "~> 2.0"
  // arguments
  identifier             = var.oracle_identifier
  engine                 = var.oracle_engine
  engine_version         = var.oracle_engine_version
  instance_class         = var.oracle_instance_class
  allocated_storage      = var.oracle_allocated_storage
  name                   = var.oracle_name
  username               = var.oracle_username
  password               = var.oracle_password
  port                   = var.oracle_port
  deletion_protection    = var.oracle_deletion_protection
  family                 = var.oracle_family
  major_engine_version   = var.oracle_major_engine_version
  maintenance_window     = var.oracle_maintenance_window
  backup_window          = var.oracle_backup_window
  subnet_ids             = var.oracle_subnet_ids
  vpc_security_group_ids = var.oracle_vpc_security_group_ids
  tags                   = var.oracle_tags
}

//--------------------------

// Module for MSSQL RDS

module "mssql" {
  // meta-arguments 
  count   = var.create-mssql ? var.count-mssql : 0
  source  = "terraform-aws-modules/rds/aws"
  version = "~> 2.0"
  // arguments
  identifier             = var.mssql_identifier
  engine                 = var.mssql_engine
  engine_version         = var.mssql_engine_version
  instance_class         = var.mssql_instance_class
  allocated_storage      = var.mssql_allocated_storage
  name                   = var.mssql_name
  username               = var.mssql_username
  password               = var.mssql_password
  port                   = var.mssql_port
  deletion_protection    = var.mssql_deletion_protection
  family                 = var.mssql_family
  major_engine_version   = var.mssql_major_engine_version
  maintenance_window     = var.mssql_maintenance_window
  backup_window          = var.mssql_backup_window
  subnet_ids             = var.mssql_subnet_ids
  vpc_security_group_ids = var.mssql_vpc_security_group_ids
  tags                   = var.mssql_tags
}


//-------------------------


// Module for Postgresql
module "postgresql" {
  // meta-arguments
  count   = var.create-postgresql ? var.count-postgresql : 0
  source  = "terraform-aws-modules/rds/aws"
  version = "~> 2.0"
  // arguments 
  identifier             = var.postgresql_identifier
  engine                 = var.postgresql_engine
  engine_version         = var.postgresql_engine_version
  instance_class         = var.postgresql_instance_class
  allocated_storage      = var.postgresql_allocated_storage
  name                   = var.postgresql_name
  username               = var.postgresql_username
  password               = var.postgresql_password
  port                   = var.postgresql_port
  deletion_protection    = var.postgresql_deletion_protection
  family                 = var.postgresql_family
  major_engine_version   = var.postgresql_major_engine_version
  maintenance_window     = var.postgresql_maintenance_window
  backup_window          = var.postgresql_backup_window
  subnet_ids             = var.postgresql_subnet_ids
  vpc_security_group_ids = var.postgresql_vpc_security_group_ids
  tags                   = var.postgresql_tags
}

// ---------------------


// Module to create a feature branching enabled repo

module "codecommit" {
  // meta-arguments
  count   = var.create-repo ? var.count-repo : 0
  source  = "JamesWoolfenden/codecommit/aws"
  version = "0.3.4"
  // arguments  
  repository_name   = var.cc_repository_name
  default_branch    = var.cc_default_branch
  developer_group   = var.cc_developer_group
  kms_master_key_id = var.cc_kms_master_key_id
}

//-------------------------------


// CodeBuild Module

module "codebuild" {
  // meta-arguments
  count   = var.create-codebuild ? var.count-codebuild : 0
  source  = "lgallard/codebuild/aws"
  version = "0.2.1"
  // arguments
  artifacts_artifact_identifier  = var.cb_artifacts_artifact_identifier
  artifacts_location             = var.cb_artifacts_location
  artifacts_name                 = var.cb_artifacts_name
  artifacts_namespace_type       = var.cb_artifacts_namespace_type
  artifacts_packaging            = var.cb_artifacts_packaging
  cache_location                 = var.cb_cache_location
  cloudwatch_logs_group_name     = var.cb_cloudwatch_logs_group_name
  cloudwatch_logs_stream_name    = var.cb_cloudwatch_logs_stream_name
  codebuild_source_auth_resource = var.cb_codebuild_source_auth_resource
  codebuild_source_buildspec     = var.cb_codebuild_source_buildspec
  codebuild_source_location      = var.cb_codebuild_source_location
  codebuild_source_version       = var.cb_codebuild_source_version
  description                    = var.cb_description
  encryption_key                 = var.cb_encryption_key
  environment_certificate        = var.cb_environment_certificate
  name                           = var.cb_name
  s3_logs_location               = var.cb_s3_logs_location
  vpc_config_vpc_id              = var.cb_vpc_config_vpc_id
}


//-------------------------------


// Terraform module which creates Cognito User Pool resources on AWS

module "cognito-user-pool" {
  // meta-arguments
  count   = var.cognito_create ? var.cognito_count : 0
  source  = "corpit-consulting-public/cognito-user-pool/aws"
  version = "3.0.8"
  // arguments

  name                             = var.cognito_name
  allow_admin_create_user_only     = var.cognito_allow_admin_create_user_only
  temporary_password_validity_days = var.cognito_temporary_password_validity_days
  tags                             = var.cognito_tags
}


//-------------------------------  


// Guardduty Module

module "guardduty" {
  // meta-arguments
  count   = var.create-gd ? var.count-gd : 0
  source  = "QuiNovas/guardduty/aws"
  version = "3.0.0"
  // arguments
  accept_invite              = var.gd_accept_invite
  accepter_master_account_id = var.gd_accepter_master_account_id
  account_name               = var.gd_account_name
  enable                     = var.gd_enable
  ip_set_active              = var.gd_ip_set_active
  ip_set_format              = var.gd_ip_set_format
  ip_set_list_path           = var.gd_ip_set_list_path
  log_bucket                 = var.gd_log_bucket
  member_list                = var.gd_member_list
  threat_intel_list_path     = var.gd_threat_intel_list_path
  threat_intel_set_active    = var.gd_threat_intel_set_active
  threat_intel_set_format    = var.gd_threat_intel_set_format
}


//-------------------------------


//Terraform module to create AWS Backup plans.
module "aws_backup_example" {
  // meta-arguments
  count  = var.create_backup ? var.backup_count : 0
  source = "git::https://github.com/lgallard/terraform-aws-backup.git"
  // arguments

  vault_name                        = var.backup_vault_name
  plan_name                         = var.backup_plan_name
  rule_name                         = var.backup_rule_name
  rule_schedule                     = var.backup_rule_schedule
  rule_start_window                 = var.backup_rule_start_window
  rule_completion_window            = var.backup_rule_completion_window
  rule_lifecycle_cold_storage_after = var.backup_rule_lifecycle_cold_storage_after
  rule_lifecycle_delete_after       = var.backup_rule_lifecycle_delete_after
  selection_name                    = var.backup_selection_name
  selection_resources               = var.backup_selection_resources
  tags                              = var.backup_tags
}

//------------------------


// API-GW Module

module "api-gateway" {
  // meta-arguments
  count   = var.create-apigw ? var.count-apigw : 0
  source  = "rhythmictech/api-gateway/aws"
  version = "1.0.1"
  // arguments
  # insert the 3 required variables here
  domain_name              = var.apigw_domain_name
  name                     = var.apigw_name
  regional_certificate_arn = var.apigw_regional_certificate_arn

  tags = var.tags

}

//------------------------

// Aws StorageGW Module

module "gateway" {
  // meta-arguments
  count   = var.create-sgw ? var.count-sgw : 0
  source  = "robbytaylor/gateway/file"
  version = "1.0.0"
  // arguments
  # insert the 4 required variables here
  bucket_name        = var.gateway_bucket_name
  gateway_ip_address = var.gateway_ip_address
  gateway_name       = var.gateway_name
  gateway_timezone   = var.gateway_timezone
}

//-------------------------------

// secrets-manager module

module "secrets-manager" {
  // meta-arguments
  count   = var.create-secret ? var.count-secret : 0
  source  = "lgallard/secrets-manager/aws"
  version = "0.2.1"
  // arguments
  automatically_after_days = var.secrets_automatically_after_days
  recovery_window_in_days  = var.secrets_recovery_window_in_days
  rotate_secrets           = var.rotate_secrets
  secrets                  = var.secrets
  tags                     = var.secrets_tags
}



// SES Module

module "ses" {
  // meta-arguments
  count   = var.create-ses ? var.count-ses : 0
  source  = "ispec-inc/ses/aws"
  version = "0.1.0"
  // arguments
  # insert the 2 required variables here
  domain_name    = var.ses_domain_name
  from_addresses = var.ses_from_addresses
}

//---------------------------

// AWS Elasticache Module

module "elasticache" {
  // meta-arguments
  count   = var.create-ec ? var.count-ec : 0
  source  = "rhythmictech/elasticache/aws"
  version = "2.1.0"
  // arguments
  # insert the 12 required variables here
  dns_cname_record_name                  = var.ec_dns_cname_record_name
  egress_security_group_rule_description = var.ec_egress_security_group_rule_description
  engine_version                         = var.ec_engine_version
  ingress_cidr_sg_rule_description       = var.ec_ingress_cidr_sg_rule_description
  ingress_sg_sg_rule_description         = var.ec_ingress_sg_sg_rule_description
  name                                   = var.ec_name
  notification_topic_arn                 = var.ec_notification_topic_arn
  parameter_group_name                   = var.ec_parameter_group_name
  port                                   = var.ec_port
  replication_group_description          = var.ec_replication_group_description
  subnet_ids                             = var.ec_subnet_ids
  vpc_id                                 = var.ec_vpc_id

  tags = var.tags

}


//-----------------------


//Terraform module - creates a Budget and a Budget for half as much

module "budget" {
  // meta-arguments  
  count   = var.budget_create ? var.budget_count : 0
  source  = "JamesWoolfenden/budget/aws"
  version = "0.3.32"
  // arguments 
  limit             = var.budget_limit
  time_period_start = var.budget_time_period_start
  budget            = var.budget
  notification      = var.budget_notification
}




// Enables AWS Organizations Service Control Policies (SCP) with good defaults

module "org-scp" {
  // meta-arguments
  count   = var.create-org ? var.count-org : 0
  source  = "trussworks/org-scp/aws"
  version = "1.6.4"
  // arguments
  allowed_regions                          = var.org_allowed_regions
  deny_all_access_target_ids               = var.org_deny_all_access_target_ids
  deny_creating_iam_users_target_ids       = var.org_deny_creating_iam_users_target_ids
  deny_deleting_cloudwatch_logs_target_ids = var.org_deny_deleting_cloudwatch_logs_target_ids
  deny_deleting_kms_keys_target_ids        = var.org_deny_deleting_kms_keys_target_ids
  deny_deleting_route53_zones_target_ids   = var.org_deny_deleting_route53_zones_target_ids
  deny_leaving_orgs_target_ids             = var.org_deny_leaving_orgs_target_ids
  deny_root_account_target_ids             = var.org_deny_root_account_target_ids
  protect_iam_role_resources               = var.org_protect_iam_role_resources
  protect_iam_role_target_ids              = var.org_protect_iam_role_target_ids
  protect_s3_bucket_resources              = var.org_protect_s3_bucket_resources
  protect_s3_bucket_target_ids             = var.org_protect_s3_bucket_target_ids
  require_s3_encryption_target_ids         = var.org_require_s3_encryption_target_ids
  restrict_regions_target_ids              = var.org_restrict_regions_target_ids
}


//----------------------------

//  Neptune Module

module "neptune" {
  // meta-arguments 
  source  = "JamesWoolfenden/neptune/aws"
  count   = var.neptune_create ? var.neptune_count : 0
  version = "0.0.2"
  // arguments 
  # insert the 4 required variables here
  cluster     = var.neptune_cluster
  common_tags = var.neptune_common_tags
  subnet_ids  = var.neptune_subnet_ids
  instance    = var.neptune_instance
}



//----------------------------


// route53-resolver-rule

module "route53-resolver-rule" {
  // meta-arguments
  count   = var.create-resolver ? var.count-resolver : 0
  source  = "rhythmictech/route53-resolver-rule/aws"
  version = "1.0.0"
  // arguments
  # insert the 4 required variables here
  resolver_endpoint = var.resolver_endpoint
  associated_vpcs   = var.associated_vpcs
  forward_domain    = var.forward_domain
  forward_ips       = var.forward_ips

  tags = var.tags
}



//----------------------------


// Resource Group Module 

module "aws_resource_group" {
  // meta-arguments 
  source = "./modules/resource_groups"
  count  = var.create-rg ? var.count-rg : 0
  // arguments 
  name = var.rg_name
}


//-----------------------------


// SimpleDB Module

module "aws_simple_db" {
  // meta-arguments
  source = "./modules/simpledb"
  count  = var.create-simpledb ? var.count-simpledb : 0
  // arguments
  name = var.simpledb_name
}


//-----------------------------


// AWS Cloud9 Module


module "aws_cloud9" {
  // meta-arguments
  source = "./modules/cloud9"
  count  = var.create-cloud9 ? var.count-cloud9 : 0
  // arguments

  name          = var.cloud9_name
  instance_type = var.cloud9_instance_type
}


//-----------------------------


// AWS Data Pipeline Module


module "aws_data_pipeline" {
  // meta-arguments
  source = "./modules/data_pipeline"
  count  = var.create-datapipeline ? var.count-datapipeline : 0
  // arguments

  name = var.datapipeline_name
}


//-----------------------------


// AWS Shield Module

module "aws_shield" {
  // meta-arguments
  source = "./modules/shield"
  count  = var.create-shield ? var.count-shield : 0
  // arguments

  name         = var.shield_name
  resource_arn = var.shield_resource_arn
}


//------------------------------


// AWS IAM Access Analyzer

module "aws_access_analyzer" {
  // meta-arguments
  source = "./modules/access_analyzer"
  count  = var.create-access_analyzer ? var.count-access_analyzer : 0
  // arguments

  analyzer_name = var.analyzer_name
}


//------------------------------


// AWS SWF Module

module "aws_swf" {
  // meta-arguments
  source = "./modules/swf"
  count  = var.create-swf ? var.count-swf : 0
  // arguments

  name                                        = var.swf_name
  description                                 = var.swf_description
  workflow_execution_retention_period_in_days = var.workflow_execution_retention_period_in_days
}



//-------------------------------

// AWS Service Catalog Portfolio 

module "aws_service_catalog" {
  // meta-arguments
  source = "./modules/service_catalog"
  count  = var.create-service_catalog ? var.count-service_catalog : 0
  // arguments

  name          = var.sc_name
  description   = var.sc_description
  provider_name = var.sc_provider_name
}


//-------------------------------



// AWS Service Quota  Module

module "aws_service_quota" {
  // meta-arguments
  source = "./modules/service_quotas"
  count  = var.create-service_quota ? var.count-service_quota : 0
  // arguments

  quota_code   = var.quota_code
  service_code = var.service_code
  value        = var.value

}


//---------------------------------


// AWS Machie Classic Module


module "aws_macie_classic" {
  // meta-arguments
  source = "./modules/macie_classic"
  count  = var.create-macie ? var.count-macie : 0
  // arguments

  member_account_id = var.member_account_id
  bucket_name       = var.macie_bucket_name

}


//---------------------------------


// AWS Directory Service Module


module "aws_dir_service" {
  // meta-arguments
  source = "./modules/directory_service"
  count  = var.create-ds ? var.count-ds : 0
  // arguments
  name             = var.ds_name
  short_name       = var.ds_short_name
  password         = var.ds_password
  size             = var.ds_size
  type             = var.ds_type
  alias            = var.ds_alias
  description      = var.ds_description
  vpc_id           = var.ds_vpc_id
  subnet_ids       = var.ds_subnet_ids
  connect_settings = var.ds_connect_settings
  edition          = var.ds_edition
  tags             = var.ds_tags
}


//--------------------------------

// AWS Media Convert,Package,Store Module


module "aws_media_service" {
  // meta-arguments
  source = "./modules/media"
  count  = var.create-media ? var.count-media : 0
  // arguments

  name       = var.media_queue_name
  channel_id = var.channel_id
  store_name = var.store_name
}

//--------------------------------

// License_manager Module for AWS	

module "license_manager" {
  // meta-arguments
  source = "./modules/License_manager"
  count  = var.create_license_manager ? var.count_license_manager : 0
  // arguments
  name                     = var.license_name
  license_counting_type    = var.license_counting_type
  tags                     = var.license_tags
  license_count_hard_limit = var.license_count_hard_limit
  license_count            = var.license_count
  description              = var.license_description

}

//-------------------------------

// Workspace Module for AWS

module "workspace" {
  // meta-arguments
  source = "./modules/Workspace"
  count  = var.create_workspace ? var.count_workspace : 0
  // arguments
  directory_id = var.workspace_directory_id
  bundle_id    = var.workspace_directory_bundle_id
  user_name    = var.workspace_username
  tags         = var.workspace_tags
}

// Elasticsearch Module
module "aws_es" {
  count  = var.aws-es-create ? var.aws-es-count : 0
  source = "lgallard/elasticsearch/aws"

  domain_name           = var.es_domain_name
  elasticsearch_version = var.es_version

  cluster_config = {
    dedicated_master_enabled = "true"
    instance_count           = var.instance_count
    instance_type            = var.instance_type
    zone_awareness_enabled   = "true"
    availability_zone_count  = "3"
  }

  ebs_options = {
    ebs_enabled = "true"
    volume_size = "25"
  }

  encrypt_at_rest = {
    enabled    = "true"
    kms_key_id = "alias/aws/es"
  }

  vpc_options_subnet_ids         = var.subnet_ids
  vpc_options_security_group_ids = var.security_id

  node_to_node_encryption_enabled                = true
  snapshot_options_automated_snapshot_start_hour = 23

  timeouts_update = "60m"

  tags = var.tags

}
//----------------------------------------

// ALB Module
module "alb" {
  count   = var.alb-create ? var.alb-count : 0
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 5.0"

  name = "yash-alb"

  load_balancer_type = "application"

  vpc_id          = var.vpc_id
  subnets         = var.subnet_ids
  security_groups = var.security_id

  access_logs = {
    bucket = "yash-alb-logs"
  }

  target_groups = [
    {
      name_prefix      = "pref-"
      backend_protocol = "HTTPS"
      backend_port     = 443
      target_type      = "instance"
    }
  ]

  https_listeners = [
    {
      port               = 443
      protocol           = "HTTPS"
      certificate_arn    = "Add Certificate ARN"
      action_type        = "authenticate-cognito"
      target_group_index = 0
      authenticate_cognito = {
        user_pool_arn       = "arn:aws:cognito-idp::66666666666:userpool/test-pool"
        user_pool_client_id = var.user_pool_client
        user_pool_domain    = var.user_pool_domain
      }
    }
  ]

  http_tcp_listeners = [
    {
      port        = 80
      protocol    = "HTTP"
      action_type = "redirect"
      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    }
  ]

  tags = var.tags
}

//ELB Module
module "elb_http" {
  count   = var.elb_http-create ? var.elb_http-count : 0
  source  = "terraform-aws-modules/elb/aws"
  version = "~> 2.0"

  name = "yash-elb"

  subnets         = var.subnet_ids
  security_groups = var.security_id
  internal        = false

  listener = [
    {
      instance_port     = "80"
      instance_protocol = "HTTP"
      lb_port           = "80"
      lb_protocol       = "HTTP"
    },
    {
      instance_port     = "8080"
      instance_protocol = "http"
      lb_port           = "8080"
      lb_protocol       = "http"
      #ssl_certificate_id = "ADD ARM for SSL certificate"
    },
  ]
  health_check = {
    target              = "HTTP:80/"
    interval            = 30
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
  }
  access_logs = {
    bucket = "yash-elb-access-log-bucket"
  }
}
