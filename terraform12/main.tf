
module "autoscaling" {
  // meta-arguments
  #count   = var.create_lc ? var.count-autoscale : 0 // It will work with terraform version v0.12.6
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "3.5.0"
  // arguments
  create_asg                    = var.autoscaling_create_asg
  name                          = var.autoscaling_name
  image_id                      = var.autoscaling_image_id
  instance_type                 = var.autoscaling_instance_type
  security_groups               = var.autoscaling_security_groups
  ebs_block_device              = var.autoscaling_ebs_block_device
  root_block_device             = var.autoscaling_root_block_device
  asg_name                      = var.autoscaling_asg_name
  vpc_zone_identifier           = var.autoscaling_vpc_zone_identifier
  health_check_type             = var.autoscaling_health_check_type
  min_size                      = var.autoscaling_min_size
  max_size                      = var.autoscaling_max_size
  desired_capacity              = var.autoscaling_desired_capacity
  wait_for_capacity_timeout     = var.autoscaling_wait_for_capacity_timeout
}


// Module for DynamoDB table creation

module "dynamodb-table" {
  // meta-arguments
 #count   = var.create-table ? var.count-table : 0   // Will work in terraform v0.12.6
  source  = "terraform-aws-modules/dynamodb-table/aws"
  version = "0.6.0"
  // arguments
  # insert the 7 required variables here
  name             = var.name
  hash_key         = var.hash_key
  range_key        = var.range_key
  read_capacity    = var.read_capacity
  write_capacity   = var.write_capacity
  server_side_encryption_kms_key_arn = var.server_side_encryption_kms_key_arn
  stream_view_type = var.stream_view_type
  attributes       = var.attributes

  tags = {
    Owner = "TF-Squad"
  }
 }

 //-------------------------------------------


 // CI/CD with AWS Code Pipeline and Code Build
module "cicd" {
  // meta-arguments
  #count   = var.create-cicd ? var.count-cicd : 0   // Works with terraform v0.12.6
  source  = "cloudposse/cicd/aws"
  version = "0.9.0"
  // arguments
  branch                = var.cicd_branch
  github_oauth_token    = var.cicd_github_oauth_token
  name                  = var.cicd_name
  repo_name             = var.cicd_repo_name
  repo_owner            = var.cicd_repo_owner
  codebuild_cache_bucket_suffix_enabled  = var.cicd_codebuild_cache_bucket_suffix_enabled
  namespace             = var.cicd_namespace
  stage                 = var.cicd_stage
}

//---------------------

module "elastic_beanstalk_application" {
  //meta arguements

    source      = "git::https://github.com/cloudposse/terraform-aws-elastic-beanstalk-application.git?ref=tags/0.3.0"
   
  // resource-arguments

    namespace   = var.beanstalk_namespace
    stage       = var.beanstalk_stage
    name        = var.beanstalk_name
    description = "Test elastic_beanstalk_application"
    //count       = var.ebs_create ? var.ebs_count : 0 // Not compatible with terraform 0.13
    
  }

  module "elastic_beanstalk_environment" {
    //meta arguements

    source                             = "git::https://github.com/cloudposse/terraform-aws-elastic-beanstalk-environment.git?ref=master"

    // resource-arguments
    //count       = var.ebs_create ? var.ebs_count : 0 // Not compatible with terraform 0.13
    namespace                          = var.beanstalk_namespace
    stage                              = var.beanstalk_stage
    name                               = var.beanstalk_name
    description                        = "Test elastic_beanstalk_environment"
    region                             = var.beanstalk_region
    elastic_beanstalk_application_name = module.elastic_beanstalk_application.elastic_beanstalk_application_name
    application_subnets                = var.beanstalk_application_subnets
    solution_stack_name                = var.beanstalk_solution_stack_name
    vpc_id                             = var.beanstalk_vpc_id
    instance_type                      = var.beanstalk_instance_type
    loadbalancer_type                  = var.beanstalk_loadbalancer_type
    loadbalancer_subnets               = var.beanstalk_loadbalancer_subnets
    allowed_security_groups            = var.beanstalk_allowed_security_groups   
}	

	  
	
// AWS NLB Module

module "nlb" {
  #counr  = var.create-nlb ? var.count-nlb : 0  // Works with terraform v0.12.6
  // meta-arguments
  source  = "cloudposse/nlb/aws"
  version = "0.3.0"
  // arguments
  # insert the 5 required variables here
  health_check_port             = var.nlb_health_check_port
  health_check_protocol         = var.nlb_health_check_protocol
  name                          = var.nlb_name
  subnet_ids                    = var.nlb_subnet_ids
  vpc_id                        = var.nlb_vpc_id

  tags = {
    Owner = "TF-Squad"
  }
}

//------------------------------------

// Athena Module

module "aws-athena" {
  // meta-arguments
  #count  = var.create-athena ? var.count-athena : 0  // works with terraform v0.12.6
  source  = "Adaptavist/aws-athena/module"
  version = "1.1.0"
  // arguments
  # insert the 6 required variables here
  bucket_name                   = var.athena_bucket_name
  database_name                 = var.athena_database_name
  namespace                     = var.athena_namespace
  queries                       = var.athena_queries
  query_output_locations        = var.athena_query_output_locations
  stage                         = var.athena_stage
}

//-----------------------------

// Terraform module to easily provision CloudFront CDN backed by an S3 origin

module "cloudfront-s3-cdn" {
  // meta-arguments
  #count   = var.create-cf ? var.count-cf : 0
  source  = "cloudposse/cloudfront-s3-cdn/aws"  // works with terraform v0.12.6
  version = "0.27.0"
  // arguments
  # insert the 1 required variable here
  name  = var.cf_name
}

//--------------------

// Terraform module to provision a DocumentDB cluster on AWS 

module "documentdb_cluster" {
// meta-arguments
  source                  = "git::https://github.com/cloudposse/terraform-aws-documentdb-cluster.git?ref=master"
  //count                 = var.create_documentdb ? var.documentdb_count : 0 (It requires terraform 0.12)
// resource-arguments 
  namespace               = var.documentdb_namespace
  stage                   = var.documentdb_stage
  name                    = var.documentdb_name
  cluster_size            = var.documentdb_cluster_size
  master_username         = var.documentdb_master_username
  master_password         = var.documentdb_master_password
  instance_class          = var.documentdb_instance_class
  vpc_id                  = var.documentdb_vpc_id
  subnet_ids              = var.documentdb_subnet_ids
  allowed_security_groups = var.documentdb_allowed_security_groups
  db_port                 = var.documentdb_db_port
}	


//----------------------------------

// AWS Batch Module

data "aws_availability_zones" "available" {
  state = "available"
}
 
    
module "batch_compute_environment" {
  // meta-arguments  
  source = "QuiNovas/batch-compute-environment/aws"
  // resource-arguments
  //count                    = var.batch_create ? var.batch_count : 0 (Not compatible with Terraform 0.13)
  availability_zones       = data.aws_availability_zones.available.names
  compute_resources_type   = var.batch_compute_resources_type
  desired_vcpus            = var.batch_desired_vcpus
  instance_type            = var.batch_instance_type
  max_vcpus                = var.batch_max_vcpus
  min_vcpus                = var.batch_min_vcpus
  name                     = var.batch_name
  type                     = var.batch_type
  tags                     = var.batch_tags
}	
	
//--------------------------------------


// CloudFormation Module

module "cloudformation-stack" {
  // meta-arguments
  #count   = var.create-cft ? var.count-cft : 0 // works with terraform v0.12.0
  source  = "cloudposse/cloudformation-stack/aws"
  version = "0.3.0"
  // arguments
  # insert the 2 required variables here
  name  = var.cft_name
  template_url = var.cft_template_url
}

//-----------------------------------

// AWS Lightsail module 
module "lightsail" {
  // meta-arguments
  source                    = "MagnetarIT/lightsail/aws"
  //count   = var.lightsail_create ? var.lightsail_count : 0 (Works with terraform 12.6)
  version                   = "0.2.0"
  // resource-arguments
  namespace                 = var.lightsail_namespace
  environment               = var.lightsail_environment
  name                      = var.lightsail_name
  customer_business_name    = var.lightsail_customer_business_name
  customer_email            = var.lightsail_customer_email
  blueprint_id              = var.lightsail_blueprint_id 
  availability_zone         = var.lightsail_availability_zone
  enable_email_alarm        = var.lightsail_enable_email_alarm
}
	
	

// AWS MQ

module "mq" {
  // meta-arguments
  source                  = "jungopro/mq/aws"
  version                 = "1.11.0"
  // resource-arguments
 // count                   = var.mq_create ? var.mq_count : 0 (works with terraform 12.6)
  subnet_ids              = var.mq_subnet_ids
  vpc_id                  = var.mq_vpc_id
  security_group_ids      = var.mq_security_group_ids
  broker_name             = var.mq_broker_name
  engine_type             = var.mq_engine_type
  engine_version          = var.mq_engine_version
  host_instance_type      = var.mq_host_instance_type
  mq_password             = var.mq_password
  mq_username             = var.mq_username
  configuration_file      = var.mq_configuration_file
}
	
//---------------------------------------

//  A terraform module to deploy Amazon Inspector 

module "inspector" {
  // meta-arguments 
  source  = "USSBA/inspector/aws"
   // count = var.inspector_create ? var.inspector_count : 0 (This module is  not supported by Terraform 0.13)
  version = "1.0.2"
  # insert the 2 required variable here
  // arguments 
  name_prefix  = var.inspector_name_prefix
  schedule_expression = var.inspector_schedule_expression
}

	
