// VPC variables
variable "vpc-create" {
  type    = bool
  default = false
}

variable "vpc-count" {
  type    = number
  default = 1
}

variable "cird" {
  type    = string
  default = "10.0.0.0/16"
}

variable "private_subnets" {
  type        = list(string)
  description = "List of private_subnets to use"
  default     = []
}

variable "public_subnets" {
  type        = list(string)
  description = "List of public_subnets to use"
  default     = []
}

//----------------------------------------


// "security-group" Module Variables
variable "security-group-create" {
  type    = bool
  default = false
}

variable "security-group-count" {
  type    = number
  default = 1
}

variable "security_group_name" {
  type    = string
  default = "yash-sg"
}

variable "vpc_id" {
  type    = string
  default = "yash-vpc"
}

//----------------------------------------


// EC2 Module Variables
variable "ec2_instance_create" {
  description = "decide whether to create instance"
  type        = bool
  default     = false
}

variable "ec2_name" {
  description = "Name to be used on all resources as prefix"
  type        = string
  default     = "yash"
}

variable "ec2_instance_count" {
  description = "Number of instances to launch"
  type        = number
  default     = 1
}

variable "ec2_ami" {
  description = "ID of AMI to use for the instance"
  type        = string
  default     = "ami-0e9089763828757e1"
}

variable "associate_public_ip_address" {
  description = "If true, the EC2 instance will have associated public IP address"
  type        = bool
  default     = false
}

variable "ec2_instance_type" {
  description = "The type of instance to start"
  type        = string
  default     = "t2.micro"
}

variable "ec2_private_ip" {
  description = "Private IP address to associate with the instance in a VPC"
  type        = string
  default     = null
}

variable "ec2_vpc_security_group_ids" {
  description = "A list of security group IDs to associate with"
  type        = list(string)
  default     = ["sg-06907219790ffa9fa"]
}

variable "ec2_ipv6_addresses" {
  description = "Specify one or more IPv6 addresses from the range of the subnet to associate with the primary network interface"
  type        = list(string)
  default     = null
}

variable "ec2_ipv6_address_count" {
  description = "A number of IPv6 addresses to associate with the primary network interface. Amazon EC2 chooses the IPv6 addresses from the range of your subnet."
  type        = number
  default     = null
}

variable "ec2_user_data" {
  description = "The user data to provide when launching the instance. Do not pass gzip-compressed data via this argument; see user_data_base64 instead."
  type        = string
  default     = null
}

variable "ec2_subnet_id" {
  description = "The VPC Subnet ID to launch in"
  type        = string
  default     = "subnet-00bfce3248ac9c3d3"
}

//----------------------------------------


// EFS  Variables
variable "efs_create" {
  description = "Create EFS"
  type        = bool
  default     = false
}

variable "efs_name" {
  description = "The name of the VPC that EFS will be deployed to"
  type        = string
  default     = "yash"
}

variable "efs_vpc_id" {
  description = "The name of the VPC that EFS will be deployed to"
  type        = string
  default     = "vpc-05a494be3f6f5e8f8"
}

variable "efs_subnet_ids" {
  description = "Subnet IDs for Mount Targets"
  type        = list(string)
  default     = ["subnet-0249a59a018c30b36", "subnet-03e0e190abcd5fa83"]
}

variable "efs-count" {
  description = "Count of EFS"
  type        = number
  default     = 1
}

//-------------------------------------


// S3 Bucket Variables
variable "create_bucket" {
  description = "Controls if S3 bucket should be created"
  type        = bool
  default     = false
}

variable "bucket_count" {
  description = "bucket count"
  type        = number
  default     = 1
}

variable "attach_policy" {
  description = "Controls if S3 bucket should have bucket policy attached (set to `true` to use value of `policy` as bucket policy)"
  type        = bool
  default     = false
}

variable "attach_public_policy" {
  description = "Controls if a user defined public bucket policy will be attached (set to `false` to allow upstream to apply defaults to the bucket)"
  type        = bool
  default     = false
}

variable "bucket" {
  description = "(Optional, Forces new resource) The name of the bucket. If omitted, Terraform will assign a random, unique name."
  type        = string
  default     = "yash"
}

variable "bucket_prefix" {
  description = "(Optional, Forces new resource) Creates a unique bucket name beginning with the specified prefix. Conflicts with bucket."
  type        = string
  default     = null
}

variable "policy" {
  description = "(Optional) A valid bucket policy JSON document. Note that if the policy document is not specific enough (but still valid), Terraform may view the policy as constantly changing in a terraform plan. In this case, please make sure you use the verbose/specific version of the policy. For more information about building AWS IAM policy documents with Terraform, see the AWS IAM Policy Document Guide."
  type        = string
  default     = null
}

variable "tags" {
  description = "(Optional) A mapping of tags to assign to the bucket."
  type        = map(string)
  default = {
    Terraform = "true"
    Owner     = "TF-Squad"
  }
}

variable "force_destroy" {
  description = "(Optional, Default:false ) A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable."
  type        = bool
  default     = false
}

variable "acceleration_status" {
  description = "(Optional) Sets the accelerate configuration of an existing bucket. Can be Enabled or Suspended."
  type        = string
  default     = "Enabled"
}

variable "region" {
  description = "(Optional) If specified, the AWS region this bucket should reside in. Otherwise, the region used by the callee."
  type        = string
  default     = "us-east-1"
}

variable "request_payer" {
  description = "(Optional) Specifies who should bear the cost of Amazon S3 data transfer. Can be either BucketOwner or Requester. By default, the owner of the S3 bucket would incur the costs of any data transfer. See Requester Pays Buckets developer guide for more information."
  type        = string
  default     = null
}

//-----------------------------------------

// Cloudtrail Variables

variable "create_ct" {
  description = "decide whether to create cloudtrail."
  type        = bool
  default     = false
}

variable "count_ct" {
  description = "count cloudtrail."
  type        = number
  default     = 1
}

variable "cloudwatch_log_group_name" {
  description = "The name of the CloudWatch Log Group that receives CloudTrail events."
  type        = string
  default     = "cloudtrail-events"
}

variable "enabled" {
  description = "Enables logging for the trail. Defaults to true. Setting this to false will pause logging."
  type        = bool
  default     = false
}

variable "log_retention_days" {
  description = "Number of days to keep AWS logs around in specific log group."
  type        = string
  default     = 90
}

variable "s3_bucket_name" {
  description = "The name of the AWS S3 bucket."
  type        = string
  default     = "yashs3bucket"
}

variable "org_trail" {
  description = "Whether or not this is an organization trail. Only valid in master account."
  type        = string
  default     = "false"
}

variable "encrypt_cloudtrail" {
  description = "Whether or not to use a custom KMS key to encrypt CloudTrail logs."
  type        = string
  default     = "false"
}

variable "key_deletion_window_in_days" {
  description = "Duration in days after which the key is deleted after destruction of the resource, must be 7-30 days.  Default 30 days."
  type        = string
  default     = 30
}

variable "trail_name" {
  description = "Name for the Cloudtrail"
  type        = string
  default     = "cloudtrail"
}

variable "s3_key_prefix" {
  description = "S3 key prefix for CloudTrail logs"
  type        = string
  default     = "cloudtrail"
}


//----------------------------------



// SNS Variables
variable "create_sns_topic" {
  description = "Whether to create the SNS topic"
  type        = bool
  default     = false
}

variable "sns-count" {
  description = "count of sns"
  type        = number
  default     = 1
}

variable "name" {
  description = "The name of the SNS topic to create"
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "The prefix name of the SNS topic to create"
  type        = string
  default     = null
}

variable "display_name" {
  description = "The display name for the SNS topic"
  type        = string
  default     = null
}

variable "sns_policy" {
  description = "The fully-formed AWS policy as JSON"
  type        = string
  default     = null
}

variable "delivery_policy" {
  description = "The SNS delivery policy"
  type        = string
  default     = null
}

variable "application_success_feedback_role_arn" {
  description = "The IAM role permitted to receive success feedback for this topic"
  type        = string
  default     = null
}

variable "application_success_feedback_sample_rate" {
  description = "Percentage of success to sample"
  type        = string
  default     = null
}

variable "application_failure_feedback_role_arn" {
  description = "IAM role for failure feedback"
  type        = string
  default     = null
}

variable "http_success_feedback_role_arn" {
  description = "The IAM role permitted to receive success feedback for this topic"
  type        = string
  default     = null
}

variable "http_success_feedback_sample_rate" {
  description = "Percentage of success to sample"
  type        = string
  default     = null
}

variable "http_failure_feedback_role_arn" {
  description = "IAM role for failure feedback"
  type        = string
  default     = null
}

variable "lambda_success_feedback_role_arn" {
  description = "The IAM role permitted to receive success feedback for this topic"
  type        = string
  default     = null
}

variable "lambda_success_feedback_sample_rate" {
  description = "Percentage of success to sample"
  type        = string
  default     = null
}

variable "lambda_failure_feedback_role_arn" {
  description = "IAM role for failure feedback"
  type        = string
  default     = null
}

variable "sqs_success_feedback_role_arn" {
  description = "The IAM role permitted to receive success feedback for this topic"
  type        = string
  default     = null
}

variable "sqs_success_feedback_sample_rate" {
  description = "Percentage of success to sample"
  type        = string
  default     = null
}

variable "sqs_failure_feedback_role_arn" {
  description = "IAM role for failure feedback"
  type        = string
  default     = null
}

variable "kms_master_key_id" {
  description = "The ID of an AWS-managed customer master key (CMK) for Amazon SNS or a custom CMK"
  type        = string
  default     = null
}

//------------------------------------

// SQS Variables
variable "sqs-create" {
  description = "Whether to create SQS queue"
  type        = bool
  default     = false
}

variable "sqs-count" {
  description = "sqs count"
  type        = number
  default     = 1
}

variable "sqs_name" {
  description = "This is the human-readable name of the queue. If omitted, Terraform will assign a random name."
  type        = string
  default     = "yash"
}

variable "sqs_name_prefix" {
  description = "A unique name beginning with the specified prefix."
  type        = string
  default     = null
}

variable "sqs_kms_master_key_id" {
  description = "The ID of an AWS-managed customer master key (CMK) for Amazon SQS or a custom CMK"
  type        = string
  default     = null
}


//-------------------------

// WAF Variables

variable "create-waf" {
  description = "Control of creating the AWF"
  type        = bool
  default     = false
}

variable "count-waf" {
  description = "count of waf"
  type        = number
  default     = 1
}

variable "alb_arn" {
  description = "ARN of the Application Load Balancer (ALB) to be associated with the Web Application Firewall (WAF) Access Control List (ACL)."
  type        = string
  default     = "yash_ALB"
}

variable "allowed_hosts" {
  description = "The list of allowed host names as specified in HOST header."
  type        = list(string)
  default     = []
}

variable "associate_alb" {
  description = "Whether to associate an Application Load Balancer (ALB) with an Web Application Firewall (WAF) Access Control List (ACL)."
  type        = bool
  default     = false
}

variable "blocked_path_prefixes" {
  description = "The list of URI path prefixes to block using the WAF."
  type        = list(string)
  default     = []
}

variable "ip_sets" {
  description = "List of sets of IP addresses to block."
  type        = list(string)
  default     = []
}

variable "web_acl_name" {
  description = "Name of the Web ACL"
  type        = string
  default     = "yash_acl"
}

variable "web_acl_metric_name" {
  description = "Metric name of the Web ACL"
  type        = string
  default     = "yash_metric"
}

variable "wafregional_rule_f5_id" {
  description = "The ID of the F5 Rule Group to use for the WAF for the ALB.  Find the id with \"aws waf-regional list-subscribed-rule-groups\"."
  type        = string
  default     = ""
}

variable "rate_based_rules" {
  description = "List of IDs of Rate-Based Rules to add to this WAF.  Only use this variable for rate-based rules.  Use the \"rules\" variable for regular rules."
  type        = list(string)
  default     = []
}

variable "waf_rules" {
  description = "List of IDs of Rules to add to this WAF.  Only use this variable for regular rules.  Use the \"rate_based_rules\" variable for rate-based rules."
  type        = list(string)
  default     = []
}


//----------------------------------


// Billing-Alarm Variables

variable "create-BA" {
  description = "Control the creation of Billing Alarm"
  type        = bool
  default     = false
}

variable "count-BA" {
  description = "Count of billing alarm"
  type        = number
  default     = 1
}

variable "aws_env" {
  description = "AWS environment you are deploying to. Will be appended to SNS topic and alarm name. (e.g. dev, stage, prod)"
  type        = string
  default     = "DEV"
}

variable "monthly_billing_threshold" {
  description = "The threshold for which estimated monthly charges will trigger the metric alarm."
  type        = number
  default     = 1000
}

variable "bill_currency" {
  description = "Short notation for currency type (e.g. USD, CAD, EUR)"
  type        = string
  default     = "USD"
}

//---------------------



// Route53 Variables

variable "create-r53" {
  description = "control the route53 creation"
  type        = bool
  default     = false
}

variable "count-r53" {
  description = "Count of route53"
  type        = number
  default     = 1
}

variable "r53_zone_description" {
  description = "Description of the DNS Zone"
  default     = ""
}

variable "r53_domain" {
  description = "DNS domain zone"
  type        = string
  default     = "yash.com"
}

variable "r53_zone_id" {
  description = "Imported Zone ID when Available"
  default     = "false"
}

variable "r53_records" {
  type        = any
  description = "List of DNS Records to add to the DNS zone"
  default = {
    names  = ["www."]
    types  = ["A"]
    ttls   = ["300"]
    values = ["192.0.2.235"]
  }
}

variable "r53_alias" {
  type        = any
  description = "List of DNS Aliases to add to the DNS zone"
  default = {
    names    = []
    values   = []
    zones_id = []
  }
}

//--------------------------------------


// Amazon Aurora Variables

variable "create-aurora" {
  type        = bool
  description = "Whether the database resources should be created"
  default     = false
}

variable "count-aurora" {
  type        = number
  description = "count of aurora-db"
  default     = 1
}

variable "aurora_name" {
  type        = string
  description = "Name given to DB subnet group"
  default     = "yash"
}

variable "aurora_subnets" {
  type        = list(string)
  description = "List of subnet IDs to use"
  default     = ["subnet-05ea9f0cc7df4ac99", "subnet-0219235f606ba8555"]
}

variable "aurora_envname" {
  type        = string
  description = "Environment name (eg,test, stage or prod)"
  default     = "prod"
}

variable "aurora_envtype" {
  type        = string
  description = "Environment type (eg,prod or nonprod)"
  default     = "nonprod"
}

variable "aurora_azs" {
  type        = list(string)
  description = "List of AZs to use"
  default     = []
}

variable "aurora_security_groups" {
  type        = list(string)
  description = "VPC Security Group IDs"
  default     = ["sg-00cfab952b739326d"]
}

variable "aurora_instance_type" {
  type        = string
  default     = "db.t2.small"
  description = "Instance type to use"
}

variable "aurora_username" {
  default     = "root"
  description = "Master DB username"
}

variable "aurora_password" {
  type        = string
  description = "Master DB password"
  default     = "yashD%23"
}

variable "aurora_engine" {
  type        = string
  default     = "aurora"
  description = "Aurora database engine type, currently aurora, aurora-mysql or aurora-postgresql"
}

variable "aurora_engine-version" {
  type        = string
  default     = "5.6.10a"
  description = "Aurora database engine version."
}

//--------------------------------



// KMS Variables

variable "create-kms" {
  type        = bool
  description = "Control the creation of key"
  default     = false
}

variable "count-kms" {
  type        = number
  description = "Count of key"
  default     = 1
}

variable "kms_name" {
  type        = string
  description = "Name  (e.g. `app` or `cluster`)."
  default     = "yash"
}

variable "kms_application" {
  type        = string
  description = "Application (e.g. `cd` or `clouddrove`)."
  default     = "cloudyash"
}

variable "kms_environment" {
  type        = string
  description = "Environment (e.g. `prod`, `dev`, `staging`)."
  default     = "prod"
}

variable "kms_label_order" {
  type        = list
  description = "label order, e.g. `name`,`application`."
  default     = []
}

variable "kms_attributes" {
  type        = list(string)
  description = "Additional attributes (e.g. `1`)."
  default     = []
}

variable "kms_tags" {
  type        = map(string)
  description = "Additional tags (e.g. map(`BusinessUnit`,`XYZ`)."
  default     = {}
}

variable "kms_managedby" {
  type        = string
  description = "ManagedBy, eg 'CloudDrove' or 'AnmolNagpal'."
  default     = "rahul@yash.com"
}

variable "kms_deletion_window_in_days" {
  type        = number
  description = "Duration in days after which the key is deleted after destruction of the resource."
  default     = 7
}

variable "kms_enable_key_rotation" {
  type        = bool
  description = "Specifies whether key rotation is enabled."
  default     = false
}

variable "kms_description" {
  type        = string
  description = "The description of the key as viewed in AWS console."
  default     = "Parmeter Store KMS master key"
}

variable "kms_is_enabled" {
  type        = bool
  description = "Specifies whether the key is enabled."
  default     = true
}

variable "kms_enabled" {
  type        = bool
  description = "Specifies whether the kms is enabled or disabled."
  default     = true
}

variable "kms_key_usage" {
  type        = string
  default     = "ENCRYPT_DECRYPT"
  description = "Specifies the intended use of the key. Defaults to ENCRYPT_DECRYPT, and only symmetric encryption and decryption are supported."
}

variable "kms_alias" {
  type        = string
  description = "The display name of the alias. The name must start with the word `alias` followed by a forward slash."
  default     = "alias/yash1"
}

variable "kms_policy" {
  type        = string
  description = "A valid policy JSON document. For more information about building AWS IAM policy documents with Terraform."
  default     = ""
}

variable "kms_customer_master_key_spec" {
  type        = string
  description = "Specifies whether the key contains a symmetric key or an asymmetric key pair and the encryption algorithms or signing algorithms that the key supports. Valid values: SYMMETRIC_DEFAULT, RSA_2048, RSA_3072, RSA_4096, ECC_NIST_P256, ECC_NIST_P384, ECC_NIST_P521, or ECC_SECG_P256K1. Defaults to SYMMETRIC_DEFAULT."
  default     = "SYMMETRIC_DEFAULT"
}


// ECS Module Variables

variable "create_ecs" {
  description = "Controls if ECS should be created"
  type        = bool
  default     = false
}

variable "count_ecs" {
  description = "count of ecs"
  type        = number
  default     = 1
}

variable "ecs_name" {
  description = "Name to be used on all the resources as identifier, also the name of the ECS cluster"
  type        = string
  default     = "yashq"
}

variable "ecs_container_insights" {
  description = "Controls if ECS Cluster has container insights enabled"
  type        = bool
  default     = false
}
//------------------------------


// ECR Variables

variable "create-ecr" {
  description = "control the creation of ECR"
  type        = bool
  default     = false
}

variable "count-ecr" {
  description = "count of ECR"
  type        = number
  default     = 1
}

variable "ecr_name_prefix" {
  description = "A prefix used for naming resources."
  type        = string
  default     = "yash"
}

variable "max_images_retained" {
  description = "The max number of images to keep in the repository before expiring the oldest"
  type        = number
  default     = 100
}

variable "trusted_accounts" {
  description = "IDs of other accounts that are trusted to pull and push to this repostitory"
  type        = list
  default     = ["969754113309"]
}

variable "image_tag_mutability" {
  description = "The tag mutability setting for the repository"
  type        = bool
  default     = true
}

variable "enable_scan_on_push" {
  description = "Enable vulnarability scanning on image push"
  type        = bool
  default     = true
}


// metric-filter-alarm module variables

variable "create-metric-filter-alarm" {
  description = "Control the creation of metric alarm"
  type        = bool
  default     = false
}

variable "count-metric-filter-alarm" {
  description = "count of filter alarm"
  type        = number
  default     = 1
}

variable "metric_log_group_name" {
  type        = string
  description = "The name of the log group to associate the metric filter with"
  default     = "yash"
}

variable "metric_namespace" {
  type        = string
  description = "The destination namespace of the CloudWatch metric"
  default     = "YeshTFSquad"
}

variable "metric_value" {
  type        = string
  description = "The value of the CloudWatch metric"
  default     = "1"
}

variable "metric_pattern" {
  type        = string
  description = "A valid CloudWatch Logs filter pattern for extracting metric data out of ingested log events"
  default     = "ERROR"
}

variable "metric_alarm_name" {
  type        = string
  description = "The descriptive name for the alarm. This name must be unique within the user's AWS account"
  default     = "yash"
}

variable "metric_alarm_description" {
  type        = string
  description = "The description for the alarm"
  default     = "Alert for TFsquad"
}

variable "metric_filter_name" {
  type        = string
  description = "A name for the metric filter"
  default     = "tfsquad"
}

variable "alarm_action_arns" {
  type        = list(string)
  description = "The list of actions to execute when this alarm transitions into an ALARM state from any other state. Each action is specified as an Amazon Resource Number (ARN)"
  default     = []
}

variable "comparison_operator" {
  type        = string
  description = "The arithmetic operation to use when comparing the specified Statistic and Threshold. The specified Statistic value is used as the first operand. Either of the following is supported: GreaterThanOrEqualToThreshold, GreaterThanThreshold, LessThanThreshold, LessThanOrEqualToThreshold"
  default     = "GreaterThanThreshold"
}

variable "evaluation_periods" {
  type        = string
  description = "The number of periods over which data is compared to the specified threshold"
  default     = "1"
}

variable "period" {
  type        = string
  description = "The period in seconds over which the specified statistic is applied"
  default     = "60"
}

variable "threshold" {
  type        = string
  description = "The value against which the specified statistic is compared"
  default     = "0"
}

variable "statistic" {
  type        = string
  description = "The statistic to apply to the alarm's associated metric. Either of the following is supported: SampleCount, Average, Sum, Minimum, Maximum"
  default     = "Sum"
}


// ------------------------

// IAM-ROLE Module Variables

variable "create-iam" {
  description = "Control the creation of resource"
  type        = bool
  default     = false
}

variable "count-iam" {
  description = "Count of iam"
  type        = number
  default     = 1
}

variable "iam_name" {
  description = "Name of the IAM user"
  type        = string
  default     = "yashtechsd"
}

variable "iam_path" {
  description = "Path of the IAM user"
  default     = "/"
}

variable "iam_inline_policies" {
  description = "Inline defined policies to attach to the IAM user"
  default     = []
  type = list(object({
    name = string
    statements = list(object({
      actions   = list(string)
      resources = list(string)
    }))
  }))
}

variable "iam_custom_policies" {
  description = "Custom policies to create and attach to the IAM user"
  default     = []
}

variable "iam_attach_policy_arns" {
  description = "Existing policy ARNs to attach to the IAM user"
  type        = list(string)
  default     = []
}

variable "iam_tags" {
  description = "Tags applied to all resources"
  type        = map(string)
  default     = {}
}

//------------------------------

// ACM Module Variables

variable "acm_create_certificate" {
  description = "Whether to create ACM certificate"
  type        = bool
  default     = false
}

variable "count-acm" {
  description = "Count ACM"
  type        = number
  default     = 1
}

variable "acm_validate_certificate" {
  description = "Whether to validate certificate by creating Route53 record"
  type        = bool
  default     = true
}

variable "validation_allow_overwrite_records" {
  description = "Whether to allow overwrite of Route53 records"
  type        = bool
  default     = true
}

variable "acm_wait_for_validation" {
  description = "Whether to wait for the validation to complete"
  type        = bool
  default     = true
}

variable "certificate_transparency_logging_preference" {
  description = "Specifies whether certificate details should be added to a certificate transparency log"
  type        = bool
  default     = true
}

variable "acm_domain_name" {
  description = "A domain name for which the certificate should be issued"
  type        = string
  default     = "yash.com"
}

variable "acm_subject_alternative_names" {
  description = "A list of domains that should be SANs in the issued certificate"
  type        = list(string)
  default     = []
}

variable "acm_validation_method" {
  description = "Which method to use for validation. DNS or EMAIL are valid, NONE can be used for certificates that were imported into ACM and then into Terraform."
  type        = string
  default     = "DNS"
}

variable "acm_zone_id" {
  description = "The ID of the hosted zone to contain this record."
  type        = string
  default     = "Z08799781BUW8XCDAYY03"
}

variable "acm_tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "acm_dns_ttl" {
  description = "The TTL of DNS recursive resolvers to cache information about this record."
  type        = number
  default     = 60
}

//----------------------------

// Oracle RDS Variables

variable "create-oracle" {
  description = "Control the creation of Oracle RDS"
  type        = bool
  default     = false
}

variable "count-oracle" {
  description = "Count Oracle RDS"
  type        = number
  default     = 1
}

variable "oracle_identifier" {
  description = "The name of the RDS instance, if omitted, Terraform will assign a random, unique identifier"
  type        = string
  default     = "tfsquad"
}

variable "oracle_engine" {
  description = "The database engine to use"
  type        = string
  default     = "oracle-se"
}

variable "oracle_engine_version" {
  description = "The engine version to use"
  type        = string
  default     = "11.2.0.4.v24"
}

variable "oracle_allocated_storage" {
  description = "The allocated storage in gigabytes"
  type        = string
  default     = "20"
}

variable "oracle_name" {
  description = "The DB name to create. If omitted, no database is created initially"
  type        = string
  default     = "tfsquad-oracle"
}

variable "oracle_username" {
  description = "Username for the master DB user"
  type        = string
  default     = "TFsquad"
}

variable "oracle_password" {
  description = "Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file"
  type        = string
  default     = "YourPwdShouldBeLongAndSecure!"
}

variable "oracle_port" {
  description = "The port on which the DB accepts connections"
  type        = string
  default     = "5432"
}

variable "oracle_vpc_security_group_ids" {
  description = "List of VPC security groups to associate"
  type        = list(string)
  default     = ["sg-0646f073f8818020a"]
}

variable "oracle_instance_class" {
  description = "The instance type of the RDS instance"
  type        = string
  default     = "db.m5.large"
}

variable "oracle_storage_type" {
  description = "One of 'standard' (magnetic), 'gp2' (general purpose SSD), or 'io1' (provisioned IOPS SSD). The default is 'io1' if iops is specified, 'standard' if not. Note that this behaviour is different from the AWS web console, where the default is 'gp2'."
  type        = string
  default     = "gp2"
}


variable "oracle_db_subnet_group_name" {
  description = "Name of DB subnet group. DB instance will be created in the VPC associated with the DB subnet group. If unspecified, will be created in the default VPC"
  type        = string
  default     = "Tfsquad"
}

variable "oracle_parameter_group_description" {
  description = "Description of the DB parameter group to create"
  type        = string
  default     = ""
}

variable "oracle_parameter_group_name" {
  description = "Name of the DB parameter group to associate or create"
  type        = string
  default     = "Tfsquad"
}

variable "oracle_availability_zone" {
  description = "The Availability Zone of the RDS instance"
  type        = string
  default     = ""
}

variable "oracle_multi_az" {
  description = "Specifies if the RDS instance is multi-AZ"
  type        = bool
  default     = false
}

variable "oracle_ops" {
  description = "The amount of provisioned IOPS. Setting this implies a storage_type of 'io1'"
  type        = number
  default     = 0
}

variable "oracle_publicly_accessible" {
  description = "Bool to control if instance is publicly accessible"
  type        = bool
  default     = false
}

variable "oracle_monitoring_interval" {
  description = "The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. To disable collecting Enhanced Monitoring metrics, specify 0. The default is 0. Valid Values: 0, 1, 5, 10, 15, 30, 60."
  type        = number
  default     = 0
}

variable "oracle_monitoring_role_arn" {
  description = "The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch Logs. Must be specified if monitoring_interval is non-zero."
  type        = string
  default     = ""
}

variable "oracle_monitoring_role_name" {
  description = "Name of the IAM role which will be created when create_monitoring_role is enabled."
  type        = string
  default     = "rds-monitoring-role"
}

variable "oracle_create_monitoring_role" {
  description = "Create IAM role with a defined name that permits RDS to send enhanced monitoring metrics to CloudWatch Logs."
  type        = bool
  default     = false
}

variable "oracle_maintenance_window" {
  description = "The window to perform maintenance in. Syntax: 'ddd:hh24:mi-ddd:hh24:mi'. Eg: 'Mon:00:00-Mon:03:00'"
  type        = string
  default     = "Mon:00:00-Mon:03:00"
}


variable "oracle_backup_window" {
  description = "The daily time range (in UTC) during which automated backups are created if they are enabled. Example: '09:46-10:16'. Must not overlap with maintenance_window"
  type        = string
  default     = "03:00-06:00"
}

variable "oracle_tags" {
  description = "A mapping of tags to assign to all resources"
  type        = map(string)
  default = {
    Owner       = "user"
    Environment = "dev"
  }
}

# DB subnet group
variable "oracle_subnet_ids" {
  description = "A list of VPC subnet IDs"
  type        = list(string)
  default     = ["subnet-04651cc352afe286f", "subnet-074c0b2900fb4415e"]
}

# DB parameter group
variable "oracle_family" {
  description = "The family of the DB parameter group"
  type        = string
  default     = "oracle-ee-11.2"
}

variable "oracle_parameters" {
  description = "A list of DB parameters (map) to apply"
  type        = list(map(string))
  default     = []
}


variable "oracle_major_engine_version" {
  description = "Specifies the major version of the engine that this option group should be associated with"
  type        = string
  default     = "11.2"
}


variable "oracle_create_db_subnet_group" {
  description = "Whether to create a database subnet group"
  type        = bool
  default     = true
}

variable "oracle_create_db_parameter_group" {
  description = "Whether to create a database parameter group"
  type        = bool
  default     = true
}

variable "oracle_deletion_protection" {
  description = "The database can't be deleted when this value is set to true."
  type        = bool
  default     = true
}
variable "oracle_create_db_option_group" {
  description = "(Optional) Create a database option group"
  type        = bool
  default     = true
}

variable "oracle_create_db_instance" {
  description = "Whether to create a database instance"
  type        = bool
  default     = true
}



// MSSQL Module Variables 

variable "create-mssql" {
  description = "Control the creation of mssql"
  type        = bool
  default     = false
}

variable "count-mssql" {
  description = "Coount of mssql"
  type        = number
  default     = 1
}

variable "mssql_identifier" {
  description = "The name of the RDS instance, if omitted, Terraform will assign a random, unique identifier"
  type        = string
  default     = "tfsquad"
}

variable "mssql_engine" {
  description = "The database engine to use"
  type        = string
  default     = "sqlserver-ex"
}

variable "mssql_engine_version" {
  description = "The engine version to use"
  type        = string
  default     = "14.00.1000.169.v1"
}

variable "mssql_allocated_storage" {
  description = "The allocated storage in gigabytes"
  type        = string
  default     = "20"
}

variable "mssql_name" {
  description = "The DB name to create. If omitted, no database is created initially"
  type        = string
  default     = "tfsquad"
}

variable "mssql_username" {
  description = "Username for the master DB user"
  type        = string
  default     = "TFsquad"
}

variable "mssql_password" {
  description = "Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file"
  type        = string
  default     = "YourPwdShouldBeLongAndSecure!"
}

variable "mssql_port" {
  description = "The port on which the DB accepts connections"
  type        = string
  default     = "5432"
}

variable "mssql_vpc_security_group_ids" {
  description = "List of VPC security groups to associate"
  type        = list(string)
  default     = ["sg-0646f073f8818020a"]
}

variable "mssql_instance_class" {
  description = "The instance type of the RDS instance"
  type        = string
  default     = "db.t2.micro"
}

variable "mssql_storage_type" {
  description = "One of 'standard' (magnetic), 'gp2' (general purpose SSD), or 'io1' (provisioned IOPS SSD). The default is 'io1' if iops is specified, 'standard' if not. Note that this behaviour is different from the AWS web console, where the default is 'gp2'."
  type        = string
  default     = "gp2"
}

variable "mssql_db_subnet_group_name" {
  description = "Name of DB subnet group. DB instance will be created in the VPC associated with the DB subnet group. If unspecified, will be created in the default VPC"
  type        = string
  default     = "Tfsquad"
}

variable "mssql_parameter_group_description" {
  description = "Description of the DB parameter group to create"
  type        = string
  default     = ""
}

variable "mssql_parameter_group_name" {
  description = "Name of the DB parameter group to associate or create"
  type        = string
  default     = "Tfsquad"
}

variable "mssql_option_group_name" {
  description = "Name of the DB option group to associate"
  type        = string
  default     = ""
}

variable "mssql_availability_zone" {
  description = "The Availability Zone of the RDS instance"
  type        = string
  default     = ""
}

variable "mssql_multi_az" {
  description = "Specifies if the RDS instance is multi-AZ"
  type        = bool
  default     = false
}

variable "mssql_iops" {
  description = "The amount of provisioned IOPS. Setting this implies a storage_type of 'io1'"
  type        = number
  default     = 0
}

variable "mssql_publicly_accessible" {
  description = "Bool to control if instance is publicly accessible"
  type        = bool
  default     = false
}


variable "mssql_maintenance_window" {
  description = "The window to perform maintenance in. Syntax: 'ddd:hh24:mi-ddd:hh24:mi'. Eg: 'Mon:00:00-Mon:03:00'"
  type        = string
  default     = "Mon:00:00-Mon:03:00"
}

variable "mssql_backup_window" {
  description = "The daily time range (in UTC) during which automated backups are created if they are enabled. Example: '09:46-10:16'. Must not overlap with maintenance_window"
  type        = string
  default     = "03:00-06:00"
}

variable "mssql_tags" {
  description = "A mapping of tags to assign to all resources"
  type        = map(string)
  default = {
    Owner       = "user"
    Environment = "dev"
  }
}

# DB subnet group
variable "mssql_subnet_ids" {
  description = "A list of VPC subnet IDs"
  type        = list(string)
  default     = ["subnet-04651cc352afe286f", "subnet-074c0b2900fb4415e"]
}

# DB parameter group
variable "mssql_family" {
  description = "The family of the DB parameter group"
  type        = string
  default     = "sqlserver-ex-14.0"
}

variable "mssql_parameters" {
  description = "A list of DB parameters (map) to apply"
  type        = list(map(string))
  default     = []
}

# DB option group

variable "mssql_major_engine_version" {
  description = "Specifies the major version of the engine that this option group should be associated with"
  type        = string
  default     = "14.00"
}


variable "mssql_create_db_subnet_group" {
  description = "Whether to create a database subnet group"
  type        = bool
  default     = true
}

variable "mssql_create_db_parameter_group" {
  description = "Whether to create a database parameter group"
  type        = bool
  default     = true
}

variable "mssql_deletion_protection" {
  description = "The database can't be deleted when this value is set to true."
  type        = bool
  default     = true
}
variable "mssql_create_db_option_group" {
  description = "(Optional) Create a database option group"
  type        = bool
  default     = true
}

variable "mssql_create_db_instance" {
  description = "Whether to create a database instance"
  type        = bool
  default     = true
}

variable "mssql_max_allocated_storage" {
  description = "Specifies the value for Storage Autoscaling"
  type        = number
  default     = 0
}

variable "mssql_delete_automated_backups" {
  description = "Specifies whether to remove automated backups immediately after the DB instance is deleted"
  type        = bool
  default     = true
}


// Postgresql Module Variables 

variable "create-postgresql" {
  description = "Control the creation of postgresql"
  type        = bool
  default     = false
}

variable "count-postgresql" {
  description = "count of postgresql"
  type        = number
  default     = 1
}

variable "postgresql_identifier" {
  description = "The name of the RDS instance, if omitted, Terraform will assign a random, unique identifier"
  type        = string
  default     = "tfsquad"
}

variable "postgresql_engine" {
  description = "The database engine to use"
  type        = string
  default     = "postgres"
}

variable "postgresql_engine_version" {
  description = "The engine version to use"
  type        = string
  default     = "9.6.9"
}

variable "postgresql_allocated_storage" {
  description = "The allocated storage in gigabytes"
  type        = string
  default     = "5"
}

variable "postgresql_name" {
  description = "The DB name to create. If omitted, no database is created initially"
  type        = string
  default     = "tfsquad"
}

variable "postgresql_username" {
  description = "Username for the master DB user"
  type        = string
  default     = "TFsquad"
}

variable "postgresql_password" {
  description = "Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file"
  type        = string
  default     = "YourPwdShouldBeLongAndSecure!"
}

variable "postgresql_port" {
  description = "The port on which the DB accepts connections"
  type        = string
  default     = "5432"
}

variable "postgresql_vpc_security_group_ids" {
  description = "List of VPC security groups to associate"
  type        = list(string)
  default     = ["sg-068a7c2adf553d556"]
}

variable "postgresql_instance_class" {
  description = "The instance type of the RDS instance"
  type        = string
  default     = "db.t2.micro"
}

variable "postgresql_storage_type" {
  description = "One of 'standard' (magnetic), 'gp2' (general purpose SSD), or 'io1' (provisioned IOPS SSD). The default is 'io1' if iops is specified, 'standard' if not. Note that this behaviour is different from the AWS web console, where the default is 'gp2'."
  type        = string
  default     = "gp2"
}

variable "postgresql_storage_encrypted" {
  description = "Specifies whether the DB instance is encrypted"
  type        = bool
  default     = false
}

variable "postgresql_db_subnet_group_name" {
  description = "Name of DB subnet group. DB instance will be created in the VPC associated with the DB subnet group. If unspecified, will be created in the default VPC"
  type        = string
  default     = "Tfsquad"
}

variable "postgresql_parameter_group_description" {
  description = "Description of the DB parameter group to create"
  type        = string
  default     = ""
}

variable "postgresql_parameter_group_name" {
  description = "Name of the DB parameter group to associate or create"
  type        = string
  default     = "Tfsquad"
}

variable "postgresql_option_group_name" {
  description = "Name of the DB option group to associate"
  type        = string
  default     = ""
}

variable "postgresql_availability_zone" {
  description = "The Availability Zone of the RDS instance"
  type        = string
  default     = ""
}

variable "postgresql_multi_az" {
  description = "Specifies if the RDS instance is multi-AZ"
  type        = bool
  default     = false
}

variable "postgresql_iops" {
  description = "The amount of provisioned IOPS. Setting this implies a storage_type of 'io1'"
  type        = number
  default     = 0
}

variable "postgresql_publicly_accessible" {
  description = "Bool to control if instance is publicly accessible"
  type        = bool
  default     = false
}

variable "postgresql_maintenance_window" {
  description = "The window to perform maintenance in. Syntax: 'ddd:hh24:mi-ddd:hh24:mi'. Eg: 'Mon:00:00-Mon:03:00'"
  type        = string
  default     = "Mon:00:00-Mon:03:00"
}

variable "postgresql_backup_window" {
  description = "The daily time range (in UTC) during which automated backups are created if they are enabled. Example: '09:46-10:16'. Must not overlap with maintenance_window"
  type        = string
  default     = "03:00-06:00"
}

variable "postgresql_tags" {
  description = "A mapping of tags to assign to all resources"
  type        = map(string)
  default = {
    Owner       = "user"
    Environment = "dev"
  }
}

# DB subnet group
variable "postgresql_subnet_ids" {
  description = "A list of VPC subnet IDs"
  type        = list(string)
  default     = ["subnet-03fa4c345a9bf3d67", "subnet-04f7551634a4b56f6"]
}

# DB parameter group
variable "postgresql_family" {
  description = "The family of the DB parameter group"
  type        = string
  default     = "postgres9.6"
}

variable "postgresql_parameters" {
  description = "A list of DB parameters (map) to apply"
  type        = list(map(string))
  default     = []
}

# DB option group

variable "postgresql_major_engine_version" {
  description = "Specifies the major version of the engine that this option group should be associated with"
  type        = string
  default     = "9.6"
}

variable "postgresql_create_db_subnet_group" {
  description = "Whether to create a database subnet group"
  type        = bool
  default     = true
}

variable "postgresql_create_db_parameter_group" {
  description = "Whether to create a database parameter group"
  type        = bool
  default     = true
}

variable "postgresql_deletion_protection" {
  description = "The database can't be deleted when this value is set to true."
  type        = bool
  default     = true
}
variable "postgresql_create_db_option_group" {
  description = "(Optional) Create a database option group"
  type        = bool
  default     = true
}

variable "postgresql_create_db_instance" {
  description = "Whether to create a database instance"
  type        = bool
  default     = true
}

variable "postgresql_use_parameter_group_name_prefix" {
  description = "Whether to use the parameter group name prefix or not"
  type        = bool
  default     = true
}

variable "postgresql_max_allocated_storage" {
  description = "Specifies the value for Storage Autoscaling"
  type        = number
  default     = 0
}



//---------------------------------
// CodeCommit Module Variables

variable "create-repo" {
  type        = bool
  description = "control the creation"
  default     = false
}

variable "count-repo" {
  type        = number
  description = "count of repo"
  default     = 1
}

variable "cc_repository_name" {
  type        = string
  description = "The name of your GIT repository"
  default     = "yash"
}

variable "cc_default_branch" {
  type        = string
  description = "The name of the default repository branch"
  default     = "master"
}

variable "cc_developer_group" {
  description = "An existing Iam Group to attach the policy permissions to"
  type        = string
  default     = ""
}

variable "cc_kms_master_key_id" {
  type        = string
  description = "The kms key to use"
  default     = "alias/aws/sns"
}


//---------------------------------

// CodeBuild Module Variables

variable "create-codebuild" {
  description = "control the creation"
  type        = bool
  default     = false
}

variable "count-codebuild" {
  description = "Count"
  type        = number
  default     = 1
}

variable "cb_name" {
  description = "The projects name."
  type        = string
  default     = "yash"
}

variable "cb_description" {
  description = "A short description of the project."
  type        = string
  default     = null
}

variable "cb_encryption_key" {
  description = "The AWS Key Management Service (AWS KMS) customer master key (CMK) to be used for encrypting the build project's build output artifacts."
  type        = string
  default     = null
}

variable "cb_codebuild_source_version" {
  description = "A version of the build input to be built for this project. If not specified, the latest version is used."
  type        = string
  default     = null
}

variable "cb_artifacts_artifact_identifier" {
  description = "The artifact identifier. Must be the same specified inside AWS CodeBuild buildspec."
  type        = string
  default     = null
}

variable "cb_artifacts_location" {
  description = "Information about the build output artifact location. If `type` is set to `CODEPIPELINE` or `NO_ARTIFACTS` then this value will be ignored. If `type` is set to `S3`, this is the name of the output bucket."
  type        = string
  default     = null
}

variable "cb_artifacts_name" {
  description = "The name of the project. If `type` is set to `S3`, this is the name of the output artifact object."
  type        = string
  default     = null
}

variable "cb_artifacts_namespace_type" {
  description = "The namespace to use in storing build artifacts. If `type` is set to `S3`, then valid values for this parameter are: `BUILD_ID` or `NONE`."
  type        = string
  default     = null
}

variable "cb_artifacts_packaging" {
  description = "The type of build output artifact to create. If `type` is set to `S3`, valid values for this parameter are: `NONE` or `ZIP`"
  type        = string
  default     = null
}

variable "cb_artifacts_path" {
  description = "If `type` is set to `S3`, this is the path to the output artifact"
  type        = string
  default     = ""
}

variable "cb_environment_certificate" {
  description = "The ARN of the S3 bucket, path prefix and object key that contains the PEM-encoded certificate."
  type        = string
  default     = null
}

variable "cb_cloudwatch_logs_group_name" {
  description = "The group name of the logs in CloudWatch Logs."
  type        = string
  default     = null
}

variable "cb_cloudwatch_logs_stream_name" {
  description = "The stream name of the logs in CloudWatch Logs."
  type        = string
  default     = null
}

variable "cb_s3_logs_location" {
  description = "The name of the S3 bucket and the path prefix for S3 logs. Must be set if status is ENABLED, otherwise it must be empty."
  type        = string
  default     = null
}

variable "cb_codebuild_source_buildspec" {
  description = "The build spec declaration to use for this build project's related builds. This must be set when type is iNO_SOURCE`"
  type        = string
  default     = null
}

variable "cb_codebuild_source_location" {
  description = "The location of the source code from git or s3."
  type        = string
  default     = null
}

variable "cb_codebuild_source_auth_type" {
  description = "The authorization type to use. The only valid value is OAUTH"
  type        = string
  default     = "OAUTH"
}

variable "cb_codebuild_source_auth_resource" {
  description = "The resource value that applies to the specified authorization type."
  type        = string
  default     = null
}

variable "cb_vpc_config_vpc_id" {
  description = "The ID of the VPC within which to run builds."
  type        = string
  default     = null
}

variable "cb_cache_location" {
  description = "The location where the AWS CodeBuild project stores cached resources. For type S3 the value must be a valid S3 bucket name/prefix. (Required when cache `type` is `S3`)"
  type        = string
  default     = null
}

//-------------------------------


// Variables for Cognito-user-pool

variable "cognito_create" {
  type    = bool
  default = false
}

variable "cognito_count" {
  type    = number
  default = 1
}

variable "cognito_name" {
  type        = string
  description = "The name of the user pool"
  default     = "Tfsquad"
}

variable "cognito_allow_admin_create_user_only" {
  type        = string
  description = "Set to true if only the administrator is allowed to create user profiles."
  default     = "true"
}

variable "cognito_temporary_password_validity_days" {
  type        = string
  description = "The user account expiration limit, in days, after which the account is no longer usable"
  default     = 7
}
variable "cognito_tags" {
  type        = map
  description = "A mapping of tags to assign to User Pool"
  default = {
    owner = "tfsquad"
  }
}

//---------------------------------------


// Guardduty Module Variables

variable "create-gd" {
  description = "control the creation of guardduty"
  type        = bool
  default     = false
}

variable "count-gd" {
  type    = number
  default = 1
}

variable "gd_accept_invite" {
  description = "Accept invitation from a master account."
  default     = false
}

variable "gd_accepter_master_account_id" {
  description = "Account ID for Guard Duty Master. Required if accept_invite = true"
  default     = ""
}

variable "gd_account_name" {
  description = "The account name. Used as a prefix to name resources."
  type        = string
  default     = "yash"
}

variable "gd_enable" {
  description = "Enable/Disable guardduty.You can set the enable attribute to false for suspend monitoring and feedback reporting while keeping existing data."
  default     = true
  type        = bool
}

variable "gd_member_list" {
  default     = []
  description = "The list of member accounts to be added. Each member list need to have values of account_id, member_email and invite boolean"
  type = list(object({
    account_id   = string
    member_email = string
    invite       = bool
  }))
}

variable "gd_ip_set_active" {
  description = "Specifies whether GuardDuty is to start using the uploaded IPSet"
  default     = false
  type        = bool
}

variable "gd_ip_set_format" {
  description = "The format of the file that contains the IPSet. Valid values: TXT | STIX | OTX_CSV | ALIEN_VAULT | PROOF_POINT | FIRE_EYE"
  default     = "TXT"
  type        = string
}

variable "gd_ip_set_list_path" {
  description = "The path of the IP safe list file"
  default     = ""
  type        = string
}

variable "gd_log_bucket" {
  description = "Account level Log bucket id"
  type        = string
  default     = ""
}

variable "gd_threat_intel_set_active" {
  description = "Specifies whether GuardDuty is to start using the uploaded ThreatIntelSet"
  default     = false
  type        = bool
}

variable "gd_threat_intel_set_format" {
  description = "The format of the file that contains the ThreatIntelSet. Valid values: TXT | STIX | OTX_CSV | ALIEN_VAULT | PROOF_POINT | FIRE_EYE"
  default     = "TXT"
  type        = string
}

variable "gd_threat_intel_list_path" {
  description = "The path of the Threat intel file"
  default     = ""
  type        = string
}


//--------------------------------------------------------  


# AWS Backup Module variables 

variable "create_backup" {
  description = "Name of the backup vault to create. If not given, AWS use default"
  type        = bool
  default     = false
}

variable "backup_count" {
  type    = number
  default = 1
}

variable "backup_vault_name" {
  description = "Name of the backup vault to create. If not given, AWS use default"
  type        = string
  default     = "tfsquad"
}

variable "backup_tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default = {

    owner = "tfsquad"
  }
}

variable "backup_plan_name" {
  description = "The display name of a backup plan"
  type        = string
  default     = "yashtfsquad"
}

variable "backup_rule_name" {
  description = "An display name for a backup rule"
  type        = string
  default     = "tfsquad1"
}

variable "backup_rule_schedule" {
  description = "A CRON expression specifying when AWS Backup initiates a backup job"
  type        = string
  default     = "cron(0 12 * * ? *)"
}

variable "backup_rule_start_window" {
  description = "The amount of time in minutes before beginning a backup"
  type        = number
  default     = 120
}

variable "backup_rule_completion_window" {
  description = "The amount of time AWS Backup attempts a backup before canceling the job and returning an error"
  type        = number
  default     = 360
}

variable "backup_rule_recovery_point_tags" {
  description = "Metadata that you can assign to help organize the resources that you create"
  type        = map(string)
  default     = {}
}

# Rule lifecycle
variable "backup_rule_lifecycle_cold_storage_after" {
  description = "Specifies the number of days after creation that a recovery point is moved to cold storage"
  type        = number
  default     = 30
}

variable "backup_rule_lifecycle_delete_after" {
  description = "Specifies the number of days after creation that a recovery point is deleted. Must be 90 days greater than `cold_storage_after`"
  type        = number
  default     = 90
}

variable "backup_selection_name" {
  description = "The display name of a resource selection document"
  type        = string
  default     = "tfsquad"
}

variable "backup_selection_resources" {
  description = "An array of strings that either contain Amazon Resource Names (ARNs) or match patterns of resources to assign to a backup plan"
  type        = list
  default     = ["arn:aws:dynamodb:us-east-1:123456789101:table/mydynamodb-table"]
}


variable "backup_enabled" {
  description = "Change to false to avoid deploying any AWS Backup resources"
  type        = bool
  default     = true
}

//---------------------


// API-GW Module Variables

variable "create-apigw" {
  type    = bool
  default = false
}

variable "count-apigw" {
  type    = number
  default = 1
}

variable "apigw_domain_name" {
  description = "The fully-qualified domain name to register"
  type        = string
  default     = "tfsquad.tk"
}

variable "apigw_name" {
  description = "Moniker to apply to all resources in the module"
  type        = string
  default     = "test"
}

variable "apigw_regional_certificate_arn" {
  description = "The ARN for an AWS-managed certificate. AWS Certificate Manager is the only supported source."
  type        = string
  default     = "arn:aws:acm:us-east-1:591914441303:certificate/8d1b9d64-3b28-4ec2-95b6-a2a69d1e9911"
}

//-----------------------------

// StorageGW Variables

variable "create-sgw" {
  type    = bool
  default = false
}

variable "count-sgw" {
  type    = number
  default = 1
}

variable "gateway_bucket_name" {
  type    = string
  default = "yash"
}

variable "gateway_ip_address" {
  type    = string
  default = "192.168.1.85"
}

variable "gateway_name" {
  type    = string
  default = "yashgw"
}

variable "gateway_timezone" {
  type    = string
  default = "GMT"
}

variable "nfs_client_list" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

//------------------------------


// Secret-Manager Module Variables

variable "create-secret" {
  type    = bool
  default = false
}

variable "count-secret" {
  type    = number
  default = 1
}

variable "secrets_recovery_window_in_days" {
  description = "Specifies the number of days that AWS Secrets Manager waits before it can delete the secret. This value can be 0 to force deletion without recovery or range from 7 to 30 days."
  type        = number
  default     = 30
}

# Secrets
variable "rotate_secrets" {
  description = "List of secrets to keep and rotate in AWS Secrets Manager"
  type        = any
  default     = []
}

variable "secrets" {
  description = "List of secrets to keep in AWS Secrets Manager"
  type        = any
  default = [
    {
      name                    = "secret-1"
      description             = "test secret 1"
      recovery_window_in_days = 7
      secret_string           = "This is an example"
    },
    {
      name                    = "secret-1"
      description             = "test secret 1"
      recovery_window_in_days = 7
      secret_string           = "This is another example"
    }
  ]
}

variable "secrets_automatically_after_days" {
  description = "Specifies the number of days between automatic scheduled rotations of the secret."
  type        = number
  default     = 30
}

# Tags
variable "secrets_tags" {
  description = "Specifies a key-value map of user-defined tags that are attached to the secret."
  type        = any
  default = {
    Owner = "TFSquad"
  }
}



// SES Module Variables

variable "create-ses" {
  type    = bool
  default = false
}

variable "count-ses" {
  type    = number
  default = 1
}

variable "ses_domain_name" {
  description = "The domain name to configure SES."
  type        = string
  default     = "yash.com"
}

variable "ses_from_addresses" {
  description = "List of email addresses to catch bounces and rejections."
  type        = list(string)
  default     = ["ragalcha27@gmail.com"]
}

variable "enable_verification" {
  description = "Control whether or not to verify SES DNS records."
  type        = bool
  default     = true
}

variable "enable_incoming_email" {
  description = "Control whether or not to handle incoming emails."
  type        = bool
  default     = true
}


//------------------------------


// Elasticache Module Variables

variable "create-ec" {
  type    = bool
  default = false
}

variable "count-ec" {
  type    = number
  default = 1
}

variable "ec_dns_cname_record_name" {
  default     = null
  description = " The name of the record, eg test.example.com. Must be specified with `route53_zone_id`"
  type        = string
}

variable "ec_egress_security_group_rule_description" {
  default     = null
  description = "Description for Egress rule"
  type        = string
}

variable "ec_engine" {
  description = "memcached or redis"
  default     = "redis"
  type        = string
}

variable "ec_engine_version" {
  default     = null
  description = "Elasticache engine version"
  type        = string
}

variable "ec_ingress_cidr_sg_rule_description" {
  default     = null
  description = "Description for CIDR-block Ingress rule"
  type        = string
}

variable "ec_ingress_sg_sg_rule_description" {
  default     = null
  description = "Description for Security Group Ingress rule"
  type        = string
}

variable "ec_name" {
  description = "Moniker to apply to all resources in the module"
  type        = string
  default     = "yash"
}

variable "ec_notification_topic_arn" {
  default     = null
  description = "An Amazon Resource Name (ARN) of an SNS topic to send ElastiCache notifications to. Example: arn:aws:sns:us-east-1:012345678999:my_sns_topic"
  type        = string
}

variable "ec_parameter_group_name" {
  default     = null
  description = "Elasticache parameter group name"
  type        = string
}

variable "ec_port" {
  default     = null
  description = "Elasticache port"
  type        = number
}

variable "ec_replication_group_description" {
  default     = null
  description = "Description for ElastiCache Replication Group"
  type        = string
}

variable "ec_subnet_ids" {
  description = "List of subnet IDs to make Elasticache available on"
  type        = list(string)
  default     = ["subnet-00f57def0151efe95", "subnet-061e6e905b73917fb"]
}

variable "ec_vpc_id" {
  description = "VPC ID to create cluster in"
  type        = string
  default     = "vpc-0a670759d3c6b4024"
}

//--------------------------------


// Budget module variables

variable "budget_create" {
  type    = bool
  default = false
}

variable "budget_count" {
  type    = number
  default = 1
}

variable "budget_limit" {
  description = "Budget alarm limit"
  type        = number
  default     = 100
}

variable "budget_time_period_start" {
  description = "Time to start"
  type        = string
  default     = "2020-07-25_00:00"

}

variable "budget" {
  description = "Basic Budget Properties"
  type        = map
  default = {
    name        = "budget-ec2-monthly"
    budget_type = "COST"
    time_unit   = "MONTHLY"
    limit_unit  = "USD"
  }
}

variable "budget_notification" {
  description = "Budget notification properties"
  default = {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 100
    threshold_type             = "PERCENTAGE"
    notification_type          = "FORECASTED"
    subscriber_email_addresses = ["test@example.com"]
  }
}

variable "budget_cost_filters" {
  description = "The Budget filters to use"
  type        = map
  default = {
    "Service" = "Amazon Elastic Compute Cloud - Compute"

  }
}

//-------------------------------


// Organizations Service Control Policies Module Variables

variable "create-org" {
  description = "control the creation"
  type        = bool
  default     = false
}

variable "count-org" {
  type    = number
  default = 1
}

variable "org_deny_root_account_target_ids" {
  description = "Target ids (AWS Account or Organizational Unit) to attach an SCP denying the root user from taking any action"
  type        = list(string)
  default     = []
}

variable "org_deny_leaving_orgs_target_ids" {
  description = "Target ids (AWS Account or Organizational Unit) to attach an SCP denying the ability to leave the AWS Organization"
  type        = list(string)
  default     = []
}

variable "org_deny_creating_iam_users_target_ids" {
  description = "Target ids (AWS Account or Organizational Unit) to attach an SCP denying the ability to create IAM users or Access Keys"
  type        = list(string)
  default     = []
}

variable "org_deny_deleting_kms_keys_target_ids" {
  description = "Target ids (AWS Account or Organizational Unit) to attach an SCP denying deleting KMS keys"
  type        = list(string)
  default     = []
}

variable "org_deny_deleting_route53_zones_target_ids" {
  description = "Target ids (AWS Account or Organizational Unit) to attach an SCP denying deleting Route53 Hosted Zones"
  type        = list(string)
  default     = []
}

variable "org_deny_all_access_target_ids" {
  description = "Target ids (AWS Account or Organizational Unit) to attach an SCP dening all access"
  type        = list(string)
  default     = []
}

variable "org_require_s3_encryption_target_ids" {
  description = "Target ids (AWS Account or Organizational Unit) to attach an SCP requiring S3 encryption"
  type        = list(string)
  default     = []
}

variable "org_deny_deleting_cloudwatch_logs_target_ids" {
  description = "Target ids (AWS Account or Organizational Unit) to attach an SCP denying deletion of CloudWatch, flowlogs,  log groups, or log streams"
  type        = list(string)
  default     = []
}

variable "org_protect_s3_bucket_target_ids" {
  description = "Target ids (AWS Account or Organizational Unit) to attach an SCP protecting S3 buckets and objects"
  type        = list(string)
  default     = []
}

variable "org_protect_s3_bucket_resources" {
  description = "S3 bucket resource ARNs to protect from bucket and object deletion"
  type        = list(string)
  default     = [""]
}

variable "org_protect_iam_role_target_ids" {
  description = "Target ids (AWS Account or Organizational Unit) to attach an SCP protecting IAM roles"
  type        = list(string)
  default     = []
}

variable "org_protect_iam_role_resources" {
  description = "IAM role resource ARNs to protect from modification and deletion"
  type        = list(string)
  default     = []
}

variable "org_restrict_regions_target_ids" {
  description = "Target ids (AWS Account or Organizational Unit) to attach an SCP restricting regions."
  type        = list(string)
  default     = []
}

variable "org_allowed_regions" {
  description = "AWS Regions allowed for use (for use with the restrict regions SCP)"
  type        = list(string)
  default     = [""]
}

//--------------

// neptune Module Variables

variable "neptune_count" {
  type    = number
  default = 1
}

variable "neptune_create" {
  type    = bool
  default = false
}

variable "neptune_common_tags" {
  description = "This is to help you add tags to your cloud objects"
  type        = map
  default = {
    owner = "mayur"
  }
}

variable "neptune_cluster" {
  description = "Neptune Cluster data"
  type        = map
  default = {
    cluster_identifier                  = "neptune-cluster-demo"
    engine                              = "neptune"
    backup_retention_period             = 5
    preferred_backup_window             = "07:00-09:00"
    skip_final_snapshot                 = true
    iam_database_authentication_enabled = true
    apply_immediately                   = true
  }
}

variable "neptune_instance" {
  type = map
  default = {
    count             = 2
    engine            = "neptune"
    instance_class    = "db.t3.medium"
    apply_immediately = true
  }
}

variable "neptune_subnet_group_name" {
  default = "main"
}

variable "neptune_subnet_ids" {
  type    = list
  default = ["subnet-0120fbee846db103a", "subnet-0491fc3df4765df0f"]
}


//---------------------------------------------------------------------------



// Route53 Resolver Module Variables

variable "create-resolver" {
  type    = bool
  default = false
}

variable "count-resolver" {
  type    = number
  default = 1
}

variable "associated_vpcs" {
  description = "List of VPC IDs to associate rule to"
  type        = list(string)
  default     = ["vpc-0ffa6cade53afc32f"]
}

variable "forward_domain" {
  description = "Domain name to forward requests for"
  type        = string
  default     = "ind.yash.com"
}

variable "forward_ips" {
  description = "List of IPs to forward DNS requests to"
  type        = list(string)
  default     = ["192.168.100.10", "192.168.100.11"]
}

variable "resolver_endpoint" {
  description = "Resolver Endpoint ID"
  type        = string
  default     = "module.route53-outbound.endpoint_id"
}



//----------------------------------------------------------------------------------



// Resource Group Module Variables 

variable "create-rg" {
  description = "control the service creation"
  type        = bool
  default     = false
}

variable "count-rg" {
  type    = number
  default = 1
}


variable "rg_name" {
  description = "resource group name"
  type        = string
  default     = "yash"
}


//-------------------------------------------------------------------------



// SimpleDB Module Variables

variable "create-simpledb" {
  description = "control the service creation"
  type        = bool
  default     = false
}

variable "count-simpledb" {
  type    = number
  default = 1
}


variable "simpledb_name" {
  description = "The name of the SimpleDB domain"
  type        = string
  default     = "yash"
}


//-------------------------------------------------------------------------


// Cloud9 Module Variables 


variable "create-cloud9" {
  type    = bool
  default = false
}

variable "count-cloud9" {
  type    = number
  default = 1
}

variable "cloud9_name" {
  description = "The name of the environment"
  type        = string
  default     = "yash"
}

variable "cloud9_instance_type" {
  description = "The type of instance to connect to the environment"
  type        = string
  default     = "t2.micro"
}


//--------------------------------------------------------------------------



// DataPipeline Module Variables 


variable "create-datapipeline" {
  type    = bool
  default = false
}

variable "count-datapipeline" {
  type    = number
  default = 1
}

variable "datapipeline_name" {
  description = "The name of Pipeline"
  type        = string
  default     = "yash"
}


//-------------------------------------------------------------------------


// Shield Module Variables 


variable "create-shield" {
  type    = bool
  default = false
}

variable "count-shield" {
  type    = number
  default = 1
}

variable "shield_name" {
  description = " (Required) A friendly name for the Protection you are creating"
  type        = string
  default     = "yash"
}

variable "shield_resource_arn" {
  description = "(Required) The ARN (Amazon Resource Name) of the resource to be protected"
  type        = string
  default     = "arn:aws:------"
}


//--------------------------------------------------------------------------



// Access Analyzer Module Variables


variable "create-access_analyzer" {
  type    = bool
  default = false
}

variable "count-access_analyzer" {
  type    = number
  default = 1
}

variable "analyzer_name" {
  description = "Name of the analyzer"
  type        = string
  default     = "yash"
}


//----------------------------------------------------------------------------


// SWF Module Variables


variable "create-swf" {
  type    = bool
  default = false
}

variable "count-swf" {
  type    = number
  default = 1
}

variable "swf_name" {
  description = "The name of the domain"
  type        = string
  default     = "yash"
}

variable "swf_description" {
  description = "The domain description"
  type        = string
  default     = ""
}

variable "workflow_execution_retention_period_in_days" {
  description = "(Required, Forces new resource) Length of time that SWF will continue to retain information about the workflow execution after the workflow execution is complete, must be between 0 and 90 days"
  type        = string
  default     = "10"
}

//-----------------------------------------------------------------------------


// AWS Service Catalog Module Variables 


variable "create-service_catalog" {
  type    = bool
  default = false
}

variable "count-service_catalog" {
  type    = number
  default = 1
}

variable "sc_name" {
  description = "name of the portfolio"
  type        = string
  default     = "yash"
}

variable "sc_description" {
  description = "Description of the portfolio"
  type        = string
  default     = "Portfolio des.."
}

variable "sc_provider_name" {
  description = "name of the person or organization who owns the portfolio"
  type        = string
  default     = "yash"
}


//--------------------------------------------------------------------------------


// AWS Service Quota Module Variables 

variable "create-service_quota" {
  type    = bool
  default = false
}

variable "count-service_quota" {
  type    = number
  default = 1
}

variable "quota_code" {
  description = "Code of the service quota to track. For example: L-F678F1CE"
  type        = string
  default     = "L-F678F1CE"
}

variable "service_code" {
  description = "Code of the service to track. For example: vpc"
  type        = string
  default     = "vpc"
}

variable "value" {
  description = "Float specifying the desired value for the service quota"
  type        = string
  default     = "75"
}


//-------------------------------------------------------------------------------



// AWS Machie Classic Module Variables 

variable "create-macie" {
  type    = bool
  default = false
}

variable "count-macie" {
  type    = number
  default = 1
}

variable "member_account_id" {
  description = "The ID of the AWS account that you want to associate with Amazon Macie as a member account"
  type        = string
  default     = "317207139874"
}

variable "macie_bucket_name" {
  description = "he name of the S3 bucket that you want to associate with Amazon Macie"
  type        = string
  default     = "yash"
}


//---------------------------------------------------------------------------------


// AWS Directory Service Module Variables 


// Directory Service Module Variables

variable "create-ds" {
  description = "Controls whether to create the directory service"
  type        = bool
  default     = false
}

variable "count-ds" {
  type    = number
  default = 1
}

variable "ds_name" {
  description = "The fully qualified name for the directory, such as corp.example.com"
  type        = string
  default     = "yash.com"
}

variable "ds_password" {
  description = "The password for the directory administrator or connector user"
  type        = string
  default     = "yash@321"
}

variable "ds_size" {
  description = "(Required for SimpleAD and ADConnector) The size of the directory (Small or Large)"
  type        = string
  default     = "Small"
}

variable "ds_vpc_id" {
  description = "The identifier of the VPC that the directory is in"
  type        = string
  default     = "vpc-8e5a68f4"
}

variable "ds_subnet_ids" {
  description = "The identifiers of the subnets for the directory servers (2 subnets in 2 different AZs)"
  type        = list(string)
  default     = ["subnet-3762d47a", "subnet-42d9f37c"]
}

variable "ds_alias" {
  description = "The alias for the directory, unique amongst all aliases in AWS (required for enable_sso)"
  type        = string
  default     = null
}

variable "ds_description" {
  description = "A textual description for the directory"
  type        = string
  default     = null
}

variable "ds_short_name" {
  description = "The short name of the directory, such as CORP"
  type        = string
  default     = "ind"
}

variable "ds_type" {
  description = "Either SimpleAD, ADConnector or MicrosoftAD"
  type        = string
  default     = "SimpleAD"
}

variable "ds_edition" {
  description = "(Required for the MicrosoftAD type only) The MicrosoftAD edition (Standard or Enterprise)."
  type        = string
  default     = null
}

variable "ds_tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "ds_connect_settings" {
  description = "Connector related information about the directory (required for ADConnector)"
  type        = list(string)
  default     = []
}


//----------------------------------------------------------------------------------


// AWS Media Convert,Package, Store Variables 

variable "create-media" {
  type    = bool
  default = false
}

variable "count-media" {
  type    = number
  default = 1
}

variable "media_queue_name" {
  description = "A unique identifier describing the queue"
  type        = string
  default     = "yash"
}

variable "channel_id" {
  description = "A unique identifier describing the channel"
  type        = string
  default     = "yash_channel"
}

variable "store_name" {
  description = "The name of the container. Must contain alphanumeric characters or underscores"
  type        = string
  default     = "yash"
}


//-----------------------

// License Manager Variables 

variable "create_license_manager" {
  type    = bool
  default = false
}

variable "count_license_manager" {
  type    = number
  default = 1
}

variable "license_name" {
  type        = string
  description = "Name of the license configuration."
  default     = "tfsquad"
}

variable "license_description" {
  type        = string
  description = "Name of the license configuration."
  default     = "Tfsquad test license"
}

variable "license_counting_type" {
  type        = string
  description = "Dimension to use to track license inventory. "
  default     = "Socket"
}

variable "license_count" {
  type        = number
  description = "Number of licenses managed by the license configuration."
  default     = 10
}

variable "license_count_hard_limit" {
  type        = bool
  description = "Sets the number of available licenses as a hard limit."
  default     = true
}

variable "license_tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default = {
    owner = "tfsquad"
  }
}

//---------------------------------

// Workspace Module variables

variable "create_workspace" {
  type    = bool
  default = false
}

variable "count_workspace" {
  type    = number
  default = 1
}

variable "workspace_directory_id" {
  type        = string
  description = "(Required) The ID of the directory for the WorkSpace."
  default     = "d-90677fd6ee"
}

variable "workspace_directory_bundle_id" {
  type        = string
  description = "(Required) The ID of the bundle for the WorkSpace."
  default     = "wsb-bh8rsxt14"
}

variable "workspace_username" {
  type        = string
  description = " (Required) The user name of the user for the WorkSpace."
  default     = "tfsquad.tk"
}

variable "workspace_tags" {
  description = "(Optional) A mapping of tags to assign to the bucket."
  type        = map(string)
  default     = {}
}

//--------------------------------

// Elasticsearch Modules

variable "aws-es-create" {
  type    = bool
  default = false
}

variable "aws-es-count" {
  type    = number
  default = 1
}

variable "profile" {
  type    = string
  default = "yash_profile"
}
variable "es_domain_name" {
  type    = string
  default = "yash_domain"
}
variable "es_version" {
  type    = string
  default = "7.2"
}

variable "instance_count" {
  type    = number
  default = 3
}

variable "instance_type" {
  type    = string
  default = "r5.large.elasticsearch"
}

variable "subnet_ids" {
  type        = list(string)
  description = "VPC Subnet IDs"
  default     = []
}

variable "security_id" {
  type        = list(string)
  description = "VPC Security Group"
  default     = []
}

//---------------------------------

// EKS Module variables

variable "eks-create" {
  type    = bool
  default = false
}

variable "eks-count" {
  type    = number
  default = 1
}

variable "eks_instance_type" {
  description = "The type of instance to start"
  type        = string
  default     = "t2.micro"
}

variable "eks_cluster_name" {
  description = "The type of instance to start"
  type        = string
  default     = "yash_cluster"
}

variable "map_accounts" {
  description = "Additional AWS account numbers to add to the aws-auth configmap."
  type        = list(string)
  default     = []
}

variable "map_roles" {
  description = "Additional IAM roles to add to the aws-auth configmap."
  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))

  default = [
    {
      rolearn  = "arn:aws:iam::66666666666:role/role1"
      username = "role1"
      groups   = ["system:masters"]
    },
  ]
}

variable "map_users" {
  description = "Additional IAM users to add to the aws-auth configmap."
  type = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))

  default = [
    {
      userarn  = "arn:aws:iam::66666666666:user/user1"
      username = "user1"
      groups   = ["system:masters"]
    },
    {
      userarn  = "arn:aws:iam::66666666666:user/user2"
      username = "user2"
      groups   = ["system:masters"]
    },
  ]
}

//-------------------------------

// ALB variables

variable "alb-create" {
  type    = bool
  default = false
}

variable "alb-count" {
  type    = number
  default = 1
}

variable "user_pool_client" {
  description = "The VPC Subnet ID to launch in"
  type        = string
  default     = null
}

variable "user_pool_domain" {
  description = "The VPC Subnet ID to launch in"
  type        = string
  default     = null
}

// EBL Varibles
variable "elb_http-create" {
  type    = bool
  default = false
}

variable "elb_http-count" {
  type    = number
  default = 1
}

// AWS Redshift variables
variable "redshift-create" {
  description = "Control the creation of metric alarm"
  type        = bool
  default     = true
}

variable "redshift-count" {
  description = "count of filter alarm"
  type        = number
  default     = 1
}

variable "redshift_DB" {
  description = "redshift_DB."
  type        = string
  default     = "redshift_DB"
}

variable "redshift_DB_USER" {
  description = "redshift_DB_USER"
  type        = string
  default     = "redshift"
}

variable "redshift_DB_PASSWD" {
  description = "redshift_DB_PASSWD"
  type        = string
  default     = "password"
}




