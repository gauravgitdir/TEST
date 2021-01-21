// CICD Module Output

output "cicd_codebuild_project_name" {
  description = "CodeBuild project name"
  value       = module.cicd[*].codebuild_project_name
}

output "cicd_codebuild_project_id" {
  description = "CodeBuild project ID"
  value       = module.cicd[*].codebuild_project_id
}

output "cicd_codebuild_role_id" {
  description = "CodeBuild IAM Role ID"
  value       = module.cicd[*].codebuild_role_id
}

output "cicd_codebuild_role_arn" {
  description = "CodeBuild IAM Role ARN"
  value       = module.cicd[*].codebuild_role_arn
}

output "cicd_codebuild_cache_bucket_name" {
  description = "CodeBuild cache S3 bucket name"
  value       = module.cicd[*].codebuild_cache_bucket_name
}

output "cicd_codebuild_cache_bucket_arn" {
  description = "CodeBuild cache S3 bucket ARN"
  value       = module.cicd[*].codebuild_cache_bucket_arn
}

output "cicd_codebuild_badge_url" {
  description = "The URL of the build badge when badge_enabled is enabled"
  value       = module.cicd[*].codebuild_badge_url
}

output "cicd_codepipeline_id" {
  description = "CodePipeline ID"
  value       = module.cicd[*].codepipeline_id
}

output "cicd_codepipeline_arn" {
  description = "CodePipeline ARN"
  value       = module.cicd[*].codepipeline_arn
}

//----------------------

// Elastic Beanstalk Module Output 

output "beanstalk_id" {
  description = "ID of the Elastic Beanstalk environment"
  value       = module.elastic_beanstalk_environment[*].id
}

output "beanstalk_name" {
  value       = module.elastic_beanstalk_environment[*].name
  description = "Name"
}

output "beanstalk_tier" {
  description = "The environment tier"
  value       = module.elastic_beanstalk_environment[*].tier
}

output "beanstalk_application" {
  description = "The Elastic Beanstalk Application specified for this environment"
  value       = module.elastic_beanstalk_environment[*].application
}

output "beanstalk_setting" {
  description = "Settings specifically set for this environment"
  value       = module.elastic_beanstalk_environment[*].setting
}

output "beanstalk_all_settings" {
  description = "List of all option settings configured in the environment. These are a combination of default settings and their overrides from setting in the configuration"
  value       = module.elastic_beanstalk_environment[*].all_settings
}

output "beanstalk_instances" {
  description = "Instances used by this environment"
  value       = module.elastic_beanstalk_environment[*].instances
}

output "beanstalk_launch_configurations" {
  description = "Launch configurations in use by this environment"
  value       = module.elastic_beanstalk_environment[*].launch_configurations
}

output "beanstalk_load_balancers" {
  description = "Elastic Load Balancers in use by this environment"
  value       = module.elastic_beanstalk_environment[*].load_balancers
}  


//-----------------------------


// NLB Module Output

output "nlb_name" {
  description = "The ARN suffix of the NLB"
  value       = module.nlb[*].nlb_name
}

output "nlb_arn" {
  description = "The ARN of the NLB"
  value       = module.nlb[*].nlb_arn
}

output "nlb_arn_suffix" {
  description = "The ARN suffix of the NLB"
  value       = module.nlb[*].nlb_arn_suffix
}

output "nlb_dns_name" {
  description = "DNS name of NLB"
  value       = module.nlb[*].nlb_dns_name
}

output "nlb_zone_id" {
  description = "The ID of the zone which NLB is provisioned"
  value       = module.nlb[*].nlb_zone_id
}

//-------------------------------------


// Athena Module Output

output "athena_database_name" {
  description = "Name of the Athena database"
  value       = module.aws-athena[*].database_name
}
  
  
//--------------------------------


// Cloudfront Module Output

output "cf_id" {
  value       = module.cloudfront-s3-cdn[*].cf_id
  description = "ID of AWS CloudFront distribution"
}

output "cf_arn" {
  value       = module.cloudfront-s3-cdn[*].cf_arn
  description = "ARN of AWS CloudFront distribution"
}

output "cf_status" {
  value       = module.cloudfront-s3-cdn[*].cf_status
  description = "Current status of the distribution"
}

output "cf_domain_name" {
  value       = module.cloudfront-s3-cdn[*].cf_domain_name
  description = "Domain name corresponding to the distribution"
}

output "cf_hosted_zone_id" {
  value       = module.cloudfront-s3-cdn[*].cf_hosted_zone_id
  description = "CloudFront Route 53 zone ID"
}

output "s3_bucket" {
  value       = module.cloudfront-s3-cdn[*].s3_bucket
  description = "Name of S3 bucket"
}


//-------------------------------------

// DocumentDB Module Output

output "documentdb_master_username" {
  value       = module.documentdb_cluster[*].master_username
  description = "Username for the master DB user"
}

output "documentdb_cluster_name" {
  value       = module.documentdb_cluster[*].cluster_name
  description = "Cluster Identifier"
}

output "documentdb_arn" {
  value       = module.documentdb_cluster[*].arn
  description = "Amazon Resource Name (ARN) of the cluster"
}

output "documentdb_endpoint" {
  value       = module.documentdb_cluster[*].endpoint
  description = "Endpoint of the DocumentDB cluster"
}

//-------------------------

// Batch Module Output 

output "batch_arn" {
  description = "The arn of the batch compute environment"
  value       = module.batch_compute_environment[*].arn
}

output "batch_ecs_cluster_arn" {
  description = "The arn of the ecs cluster"
  value = module.batch_compute_environment[*].ecs_cluster_arn
}

output "batch_ecs_instance_profile_arn" {
  description = "The arn of the ecs instance profile"
  value = module.batch_compute_environment[*].ecs_instance_profile_arn
}

output "batch_ecs_instance_role_arn" {
  description = "The arn of the ecs instance role"  
  value = module.batch_compute_environment[*].ecs_instance_role_arn
}

output "batch_public_subnet_ids" {
  value = module.batch_compute_environment[*].public_subnet_ids
}

output "batch_private_subnet_ids" {
  value = module.batch_compute_environment[*].private_subnet_ids
}

output "batch_security_group_id" {
  value = module.batch_compute_environment[*].security_group_id
}

output "batch_spot_fleet_role_arn" {
  value = module.batch_compute_environment[*].spot_fleet_role_arn
}

output "batch_vpc_id" {
  value = module.batch_compute_environment[*].vpc_id
}  


//---------------------------


// CFT Module Output

output "cft_name" {
  value       = module.cloudformation-stack[*].name
  description = "Name of the CloudFormation Stack"
}

output "cft_id" {
  value       =  module.cloudformation-stack[*].id
  description = "ID of the CloudFormation Stack"
}

output "cft_outputs" {
  value       =  module.cloudformation-stack[*].outputs
  description = "Outputs of the CloudFormation Stack"
}

//---------------------------------------

// Lightsail Module Output

output "lightsail_arn" {
  value = module.lightsail[*].arn
}

output "lightsail_id" {
  value = module.lightsail[*].id
}

output "lightsail_created_at" {
  value = module.lightsail[*].created_at
}

output "lightsail_availability_zone" {
  value = module.lightsail[*].availability_zone
}

output "lightsail_blueprint_id" {
  value = module.lightsail[*].blueprint_id
}

output "lightsail_bundle_id" {
  value = module.lightsail[*].bundle_id
}

output "lightsail_key_pair_name" {
  value = module.lightsail[*].key_pair_name
}

output "lightsail_user_data" {
  value = module.lightsail[*].user_data
}

output "lightsail_staticip_arn" {
  value = module.lightsail[*].staticip_arn
}

output "lightsail_ip_address" {
  value = module.lightsail[*].ip_address
}

output "lightsail_key_id" {
  value = module.lightsail[*].key_id
}

output "lightsail_key_arn" {
  value = module.lightsail[*].key_arn
}

output "lightsail_public_key" {
  value = module.lightsail[*].public_key
}

output "lightsail_private_key" {
  value = module.lightsail[*].private_key
}

//----------------------------------------
  
// MQ Module Output

output "aws_mq_broker" {
  value = module.mq.aws_mq_broker
}  
  
