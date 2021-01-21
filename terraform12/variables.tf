// Autoscalling Variables

variable "create_lc" {
  description = "Whether to create launch configuration"
  type        = bool
  default     = false
}

variable "count-autoscale" {
  description = "count of autoscale grp"
  type        = number
  default     = 1
}

variable "autoscaling_create_asg" {
  description = "Whether to create autoscaling group"
  type        = bool
  default     = true
}

 
variable "autoscaling_name" {
  description = "Creates a unique name beginning with the specified prefix"
  type        = string
  default     = "yash"
}

variable "autoscaling_lc_name" {
  description = "Creates a unique name for launch configuration beginning with the specified prefix"
  type        = string
  default     = "yashindore"
}

variable "autoscaling_asg_name" {
  description = "Creates a unique name for autoscaling group beginning with the specified prefix"
  type        = string
  default     = "yashind"
}


# Launch configuration
variable "autoscaling_image_id" {
  description = "The EC2 image ID to launch"
  type        = string
  default     = "ami-0ac80df6eff0e70b5"
}

variable "autoscaling_instance_type" {
  description = "The size of instance to launch"
  type        = string
  default     = "t2.micro"
}

variable "autoscaling_key_name" {
  description = "The key name that should be used for the instance"
  type        = string
  default     = "terra.pem"
}

variable "autoscaling_security_groups" {
  description = "A list of security group IDs to assign to the launch configuration"
  type        = list(string)
  default     = ["sg-07b8ddfcca4f5932e"]
}

variable "autoscaling_associate_public_ip_address" {
  description = "Associate a public ip address with an instance in a VPC"
  type        = bool
  default     = false
}


variable "autoscaling_ebs_optimized" {
  description = "If true, the launched EC2 instance will be EBS-optimized"
  type        = bool
  default     = false
}

variable "autoscaling_root_block_device" {
  description = "Customize details about the root block device of the instance"
  type        = list(map(string))
  default     = [
    {
      volume_size = "50"
      volume_type = "gp2"
    },
  ]
}

variable "autoscaling_ebs_block_device" {
  description = "Additional EBS block devices to attach to the instance"
  type        = list(map(string))
  default     =  [
    {
      device_name           = "/dev/xvdz"
      volume_type           = "gp2"
      volume_size           = "50"
      delete_on_termination = true
    },
  ]
}

variable "autoscaling_ephemeral_block_device" {
  description = "Customize Ephemeral (also known as 'Instance Store') volumes on the instance"
  type        = list(map(string))
  default     = []
}

variable "autoscaling_spot_price" {
  description = "The price to use for reserving spot instances"
  type        = string
  default     = ""
}

variable "autoscaling_placement_tenancy" {
  description = "The tenancy of the instance. Valid values are 'default' or 'dedicated'"
  type        = string
  default     = "default"
}

# Autoscaling group
variable "autoscaling_max_size" {
  description = "The maximum size of the auto scale group"
  type        = string
  default     = "2"
}

variable "autoscaling_min_size" {
  description = "The minimum size of the auto scale group"
  type        = string
  default     = "1"
}

variable "autoscaling_desired_capacity" {
  description = "The number of Amazon EC2 instances that should be running in the group"
  type        = string
  default     = "1"
}

variable "autoscaling_vpc_zone_identifier" {
  description = "A list of subnet IDs to launch resources in"
  type        = list(string)
  default     = ["subnet-09be2c7b61db33e6e", "subnet-0a395d5ef29dbe319"]
}

variable "autoscaling_default_cooldown" {
  description = "The amount of time, in seconds, after a scaling activity completes before another scaling activity can start"
  type        = number
  default     = 300
}

variable "autoscaling_health_check_grace_period" {
  description = "Time (in seconds) after instance comes into service before checking health"
  type        = number
  default     = 300
}

variable "autoscaling_health_check_type" {
  description = "Controls how health checking is done. Values are - EC2 and ELB"
  type        = string
  default     = "EC2"
}

variable "autoscaling_force_delete" {
  description = "Allows deleting the autoscaling group without waiting for all instances in the pool to terminate. You can force an autoscaling group to delete even if it's in the process of scaling a resource. Normally, Terraform drains all the instances before deleting the group. This bypasses that behavior and potentially leaves resources dangling"
  type        = bool
  default     = false
}

variable "autoscaling_load_balancers" {
  description = "A list of elastic load balancer names to add to the autoscaling group names"
  type        = list(string)
  default     = []
}


variable "tags_as_map" {
  description = "A map of tags and values in the same format as other resources accept. This will be converted into the non-standard format that the aws_autoscaling_group requires."
  type        = map(string)
  default     = {}
}

variable "autoscaling_wait_for_capacity_timeout" {
  description = "A maximum duration that Terraform should wait for ASG instances to be healthy before timing out. (See also Waiting for Capacity below.) Setting this to '0' causes Terraform to skip all Capacity Waiting behavior."
  type        = string
  default     = "10m"
}


//---------------------------------------------

// Dynamodb Module Variable

variable "create-table" {
  description = "Controls if DynamoDB table and associated resources are created"
  type        = bool
  default     = false
}

variable "count-table" {
  type        = number
  default     = 1
}

variable "name" {
  description = "Name of the DynamoDB table"
  type        = string
  default     = "yash"
}

variable "attributes" {
  description = "List of nested attribute definitions. Only required for hash_key and range_key attributes. Each attribute has two properties: name - (Required) The name of the attribute, type - (Required) Attribute type, which must be a scalar type: S, N, or B for (S)tring, (N)umber or (B)inary data"
  type        = list(map(string))
  default     = [
 {
   name = "id"
   type = "N"
 }
 ]
}

variable "hash_key" {
  description = "The attribute to use as the hash (partition) key. Must also be defined as an attribute"
  type        = string
  default     = "id"
}

variable "range_key" {
  description = "The attribute to use as the range (sort) key. Must also be defined as an attribute"
  type        = string
  default     = null
}

variable "billing_mode" {
  description = "Controls how you are billed for read/write throughput and how you manage capacity. The valid values are PROVISIONED or PAY_PER_REQUEST"
  type        = string
  default     = "PAY_PER_REQUEST"
}

variable "write_capacity" {
  description = "The number of write units for this table. If the billing_mode is PROVISIONED, this field should be greater than 0"
  type        = number
  default     = null
}

variable "read_capacity" {
  description = "The number of read units for this table. If the billing_mode is PROVISIONED, this field should be greater than 0"
  type        = number
  default     = null
}

variable "point_in_time_recovery_enabled" {
  description = "Whether to enable point-in-time recovery"
  type        = bool
  default     = false
}

variable "ttl_enabled" {
  description = "Indicates whether ttl is enabled"
  type        = bool
  default     = false
}

variable "ttl_attribute_name" {
  description = "The name of the table attribute to store the TTL timestamp in"
  type        = string
  default     = ""
}

variable "global_secondary_indexes" {
  description = "Describe a GSI for the table; subject to the normal limits on the number of GSIs, projected attributes, etc."
  type        = list(any)
  default     = []
}

variable "local_secondary_indexes" {
  description = "Describe an LSI on the table; these can only be allocated at creation so you cannot change this definition after you have created the resource."
  type        = list(any)
  default     = []
}

variable "stream_enabled" {
  description = "Indicates whether Streams are to be enabled (true) or disabled (false)."
  type        = bool
  default     = false
}

variable "stream_view_type" {
  description = "When an item in the table is modified, StreamViewType determines what information is written to the table's stream. Valid values are KEYS_ONLY, NEW_IMAGE, OLD_IMAGE, NEW_AND_OLD_IMAGES."
  type        = string
  default     = null
}

variable "server_side_encryption_enabled" {
  description = "Whether or not to enable encryption at rest using an AWS managed KMS customer master key (CMK)"
  type        = bool
  default     = false
}

variable "server_side_encryption_kms_key_arn" {
  description = "The ARN of the CMK that should be used for the AWS KMS encryption. This attribute should only be specified if the key is different from the default DynamoDB CMK, alias/aws/dynamodb."
  type        = string
  default     = null
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "timeouts" {
  description = "Updated Terraform resource management timeouts"
  type        = map(string)
  default = {
    create = "10m"
    update = "60m"
    delete = "10m"
  }
}

variable "autoscaling_defaults" {
  description = "A map of default autoscaling settings"
  type        = map(string)
  default = {
    scale_in_cooldown  = 0
    scale_out_cooldown = 0
    target_value       = 70
  }
}

variable "autoscaling_read" {
  description = "A map of read autoscaling settings. `max_capacity` is the only required key. See example in examples/autoscaling"
  type        = map(string)
  default     = {}
}

variable "autoscaling_write" {
  description = "A map of write autoscaling settings. `max_capacity` is the only required key. See example in examples/autoscaling"
  type        = map(string)
  default     = {}
}

variable "autoscaling_indexes" {
  description = "A map of index autoscaling configurations. See example in examples/autoscaling"
  type        = map(map(string))
  default     = {}
}


//------------------------------------


// AWS CICD Variables

variable "create-cicd" {
  type        = bool
  default     = false
}

variable "count-cicd" {
  type        = number
  default     = 1
}

variable "cicd_namespace" {
  type        = string
  default     = "tfsquad"
  description = "Namespace, which could be your organization name, e.g. 'eg' or 'cp'"
}

variable "cicd_stage" {
  type        = string
  default     = "dev"
  description = "Stage, e.g. 'prod', 'staging', 'dev', or 'test'"
}

variable "cicd_name" {
  type        = string
  description = "Solution name, e.g. 'app' or 'jenkins'"
  default     = "yash"
}

variable "cicd_github_oauth_token" {
  type        = string
  description = "GitHub Oauth Token"
  default     = "ee0d7d70f21052115abb47c445afb10"
}
  
variable "cicd_repo_owner" {
  type        = string
  description = "GitHub Organization or Person name"
  default     = "rahulagalcha97"
}

variable "cicd_repo_name" {
  type        = string
  description = "GitHub repository name of the application to be built (and deployed to Elastic Beanstalk if configured)"
  default     = "Maven_Spring"
}

variable "cicd_branch" {
  type        = string
  description = "Branch of the GitHub repository, _e.g._ `master`"
  default     = "master"
}

variable "cicd_codebuild_cache_bucket_suffix_enabled" {
  type        = bool
  description = "The cache bucket generates a random 13 character string to generate a unique bucket name. If set to false it uses terraform-null-label's id value"
  default     = false
}

//-------------------------



variable "ebs_create" {
  type        = bool
  default     = false
}

variable "ebs_count" {
  type    = number
  default = 1
}


variable "beanstalk_region" {
  type        = string
  description = "AWS region"
  default     = "us-east-1"
}

variable "beanstalk_namespace" {
  type        = string
  description = "Namespace, which could be your organization name, e.g. 'eg' or 'cp'"
  default     = "yash"
}

variable "beanstalk_stage" {
  type        = string
  description = "Stage, e.g. 'prod', 'staging', 'dev', or 'test'"
  default     = "dev"
}

variable "beanstalk_name" {
  type        = string
  description = "Solution name, e.g. 'app' or 'cluster'"
  default     = "java-app"
}

variable "beanstalk_delimiter" {
  type        = string
  default     = "-"
  description = "Delimiter to be used between `name`, `namespace`, `stage`, etc."
}

variable "beanstalk_environment" {
  type        = string
  default     = "dev"
  description = "Environment, e.g. 'prod', 'staging', 'dev', 'pre-prod', 'UAT'"
}

variable "beanstalk_attributes" {
  type        = list(string)
  default     = []
  description = "Additional attributes (e.g. `1`)"
}

variable "beanstalk_tags" {
  type        = map(string)
  default     = {
      owner   = "tfsquad" 
  }
  description = "Additional tags (e.g. `map('BusinessUnit`,`XYZ`)"
}

variable "beanstalk_description" {
  type        = string
  default     = "This is dev env"
  description = "Short description of the Environment"
}

variable "beanstalk_elastic_beanstalk_application_name" {
  type        = string
  description = "Elastic Beanstalk application name"
  default     = "tfsquad"
}

variable "beanstalk_environment_type" {
  type        = string
  default     = "LoadBalanced"
  description = "Environment type, e.g. 'LoadBalanced' or 'SingleInstance'.  If setting to 'SingleInstance', `rolling_update_type` must be set to 'Time', `updating_min_in_service` must be set to 0, and `loadbalancer_subnets` will be unused (it applies to the ELB, which does not exist in SingleInstance environments)"
}

variable "beanstalk_loadbalancer_type" {
  type        = string
  default     = "application"
  description = "Load Balancer type, e.g. 'application' or 'classic'"
}
  
variable "beanstalk_allowed_security_groups" {
  type        = list(string)
  description = "List of security groups to add to the EC2 instances"
  default     = ["sg-0ee8c4dd5755f94a6"]
}

variable "beanstalk_vpc_id" {
  type        = string
  description = "ID of the VPC in which to provision the AWS resources"
  default     = "vpc-0b744e5beb2deef13"
}

variable "beanstalk_loadbalancer_subnets" {
  type        = list(string)
  description = "List of subnets to place Elastic Load Balancer"
  default     = ["subnet-00634fe8d1c524689"]
}

variable "beanstalk_application_subnets" {
  type        = list(string)
  description = "List of subnets to place EC2 instances"
  default     = ["subnet-00634fe8d1c524689", "subnet-0287faf200c11c5fd"]
}

variable "beanstalk_instance_type" {
  type        = string
  default     = "t2.micro"
  description = "Instances type"
}

variable "beanstalk_solution_stack_name" {
  type        = string
  description = "Elastic Beanstalk stack, e.g. Docker, Go, Node, Java, IIS. For more info, see https://docs.aws.amazon.com/elasticbeanstalk/latest/platforms/platforms-supported.html"
  default     = "64bit Amazon Linux 2018.03 v3.3.8 running Tomcat 8.5 Java 8"
}

//------------------------------


// NLB Module Variables

variable "create-nlb" {
  type        = bool
  description = "control the creation of NLB"
  default     = false
}

variable "count-nlb" {
  type        = number
  default     = 1
}

variable "nlb_name" {
  type        = string
  description = "Name of the application"
  default     = "yash"
}

variable "nlb_vpc_id" {
  type        = string
  description = "VPC ID to associate with NLB"
  default     = "vpc-0701eb3975900afd5"
}

variable "nlb_subnet_ids" {
  type        = list(string)
  description = "A list of subnet IDs to associate with NLB"
  default     = ["subnet-006a18349bab369b5" , "subnet-01d9ed6c2e0c0c466"]
}

variable "nlb_health_check_enabled" {
  type        = bool
  default     = true
  description = "A boolean flag to enable/disable the NLB health checks"
}
  
variable "nlb_health_check_port" {
  type        = number
  default     = null
  description = "The port to send the health check request to (defaults to `traffic-port`)"
}

variable "nlb_health_check_protocol" {
  type        = string
  default     = null
  description = "The protocol to use for the health check request"
}


//-------------------------------

 
// athena module variables

variable "create-athena" {
  type        = bool
  default     = false
}

variable "count-athena" {
  type        = number
  default     = 1
}

variable "athena_name" {
  type        = string
  default     = "athena"
}

variable "athena_namespace" {
  type        = string
  default     = "yash"
}

variable "athena_stage" {
  type        = string
  default     = "dev"
}

variable "athena_tags" {
  type        = map(string)
  default     = {}
}

variable "athena_database_name" {
  type        = string
  default     = "yash"
  description = "Name of the existing database. Required if create_database variable is false"
}

variable "athena_bucket_name" {
  type        = string
  default     = "yash123213"
  description = "Name of the Athena database bucket. Required if create_database is true"
}

variable "athena_queries" {
  type        = map(string)
  description = "A map of Athena query SQLs where key is the query name and the value is the path to the file containing the query"
  default     = {}
}

variable "athena_query_output_locations" {
  type        = map(string)
  description = "A map of output locations (S3 URLs) for Athena queries. Keys are query names identical to the map above"
  default     = {}
}
  
//-------------------------

// CloudFront Module Variables

variable "create-cf" {
 type         = bool
 default      = false
}

variable "count-cf" {
 type         = number
 default      = 1
}

variable "cf_name" {
  type        = string
  description = "Name  (e.g. `bastion` or `app`)"
  default     = "yash"
}


//---------------------------

// DocumentDB Module Variables 

variable "create_documentdb" {
  type        = bool
  description = "Set to false to prevent the module from creating any resources"
  default     = false
}

variable "documentdb_count" {
  type    = number
  default = 1
}
variable "documentdb_namespace" {
  type        = string
  description = "Namespace (e.g. `eg` or `cp`)"
  default     = "tfsquad"
}

variable "documentdb_stage" {
  type        = string
  description = "Stage (e.g. `prod`, `dev`, `staging`)"
  default     = "dev"
}

variable "documentdb_name" {
  type        = string
  description = "Name of the application"
  default     = "yash-documentdb"
}

variable "documentdb_delimiter" {
  type        = string
  default     = "-"
  description = "Delimiter between `namespace`, `stage`, `name` and `attributes`"
}

variable "documentdb_attributes" {
  type        = list(string)
  description = "Additional attributes (_e.g._ \"1\")"
  default     = []
}

variable "documentdb_tags" {
  type        = map(string)
  description = "Additional tags (_e.g._ { BusinessUnit : ABC })"
  default     = {}
}

variable "documentdb_zone_id" {
  type        = string
  default     = ""
  description = "Route53 parent zone ID. If provided (not empty), the module will create sub-domain DNS records for the DocumentDB master and replicas"
}

variable "documentdb_allowed_security_groups" {
  type        = list(string)
  default     = ["sg-06201e50d324e44aa"]
  description = "List of existing Security Groups to be allowed to connect to the DocumentDB cluster"
}

variable "documentdb_allowed_cidr_blocks" {
  type        = list(string)
  default     = []
  description = "List of CIDR blocks to be allowed to connect to the DocumentDB cluster"
}

variable "documentdb_vpc_id" {
  type        = string
  description = "VPC ID to create the cluster in (e.g. `vpc-a22222ee`)"
  default     = "vpc-0f82247407a2d4643"
}

variable "documentdb_subnet_ids" {
  type        = list(string)
  description = "List of VPC subnet IDs to place DocumentDB instances in"
  default     = ["subnet-031dd0754e0357c9a", "subnet-06281dda5b2c4debb"]
}

// https://docs.aws.amazon.com/documentdb/latest/developerguide/limits.html#suported-instance-types
variable "documentdb_instance_class" {
  type        = string
  default     = "db.r4.large"
  description = "The instance class to use. For more details, see https://docs.aws.amazon.com/documentdb/latest/developerguide/db-instance-classes.html#db-instance-class-specs"
}

variable "documentdb_cluster_size" {
  type        = number
  default     = 3
  description = "Number of DB instances to create in the cluster"
}

variable "documentdb_snapshot_identifier" {
  type        = string
  default     = ""
  description = "Specifies whether or not to create this cluster from a snapshot. You can use either the name or ARN when specifying a DB cluster snapshot, or the ARN when specifying a DB snapshot"
}

variable "documentdb_db_port" {
  type        = number
  default     = 27017
  description = "DocumentDB port"
}

variable "documentdb_master_username" {
  type        = string
  default     = "tfsquad"
  description = "(Required unless a snapshot_identifier is provided) Username for the master DB user"
}

variable "documentdb_master_password" {
  type        = string
  default     = "Test123456789"
  description = "(Required unless a snapshot_identifier is provided) Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file. Please refer to the DocumentDB Naming Constraints"
}

variable "documentdb_retention_period" {
  type        = number
  default     = 5
  description = "Number of days to retain backups for"
}

variable "documentdb_preferred_backup_window" {
  type        = string
  default     = "07:00-09:00"
  description = "Daily time range during which the backups happen"
}

variable "documentdb_cluster_parameters" {
  type = list(object({
    apply_method = string
    name         = string
    value        = string
  }))
  default     = []
  description = "List of DB parameters to apply"
}

variable "documentdb_cluster_family" {
  type        = string
  default     = "docdb3.6"
  description = "The family of the DocumentDB cluster parameter group. For more details, see https://docs.aws.amazon.com/documentdb/latest/developerguide/db-cluster-parameter-group-create.html"
}

variable "documentdb_engine" {
  type        = string
  default     = "docdb"
  description = "The name of the database engine to be used for this DB cluster. Defaults to `docdb`. Valid values: `docdb`"
}

variable "documentdb_engine_version" {
  type        = string
  default     = ""
  description = "The version number of the database engine to use"
}


//--------------------------------------------------------

// Batch Module Variables

variable "batch_create" {
  type    = bool
  default = false
}

variable "batch_count" {
  type    = number
  default = 1
}

variable "batch_availability_zones" {
  description = "The avaiability zones for the subnets of compute environment, Required if subnets created outside the module are not passed in. So that necessary networking resources are created"
  type        = list(string)
  default     = []
}

variable "batch_bid_percentage" {
  type        = number
  description = "Integer of minimum percentage that a Spot Instance price must be when compared with the On-Demand price for that Instance type before instances are launched. For example, if you bid percentage is 20% (20), then the Spot price must be bellow 20% of the current On-Demand price for that EC2 Instance. This parameter is required for SPOT compute environments"
  default     = 100
}

variable "batch_cidr_block" {
  description = "The CIDR block for the Compute environment VPC."
  type        = string
  default     = "192.168.0.0/16"
}

variable "batch_compute_resources_type" {
  type        = string
  description = "The type of compute environment. Valid items are EC2 or SPOT"
  default     = "EC2"
}

variable "batch_desired_vcpus" {
  type        = number
  description = "The desired number of EC2 vCPUS in the compute environment, this number must be between min and max vcpus"
  default     = 1
}

variable "batch_ec2_key_pair" {
  type        = string
  description = "The EC2 key pair is used for instances launched in the compute environment"
  default     = ""
}

variable "batch_image_id" {
  type        = string
  description = "The Amazon Machine Image (AMI) ID used for instances launched in the compute environment"
  default     = ""
}

variable "batch_instance_role" {
  type        = string
  description = "The Amazon ECS instance role applied to Amazon EC2 instance in a computed environment, Module will create the role if not provided"
  default     = ""
}

variable "batch_instance_type" {
  type        = list(string)
  description = "A list of instance types that may be launched"
  default     = ["r5a.large"]
}

variable "batch_launch_template" {
  type = list(object({
    launch_template_id = string #ID of the lauch template
    version            = string #The version number of the template. Default: The default version of the launch template
  }))
  description = "The launch template to use for your compute resource"
  default     = []
}

variable "batch_max_vcpus" {
  type        = string
  description = "The maximum number of EC2 vCPUs that an environment can reach"
  default     = "16"
}

variable "batch_min_vcpus" {
  type        = string
  description = "The minimum number of EC2 vCPUs that environment should maintain"
  default     = "1"
}


variable "batch_name" {
  description = "The name of resources created, used either directly or as a prefix."
  type        = string
  default     = "tfsquad"
}

variable "batch_security_group_ids" {
  type        = list(string)
  description = "A list of EC2 security group that are associated with instances launched in the compuite environments"
  default     = []
}

variable "batch_service_role" {
  type        = string
  description = "The full Amazon Resource Name(ARN) of the IAM role that allows AES Batch to make calls to other AWS services on you behalf, If not provided module will create the role"
  default     = ""
}

variable "batch_spot_iam_fleet_role" {
  type        = string
  description = "The Amazon Resource Name (ARN) of the Amazon EC2 Spot Fleet IAM role applied to a SPOT compute environment. This parameter is required for SPOT compute environment. When compute_resources_type is SPOT and if this role arn is not provided then module will create one"
  default     = ""
}

variable "batch_state" {
  type        = string
  description = "The state of the compute environment. If the state id ENABLED, then the compute environment accepts jobs from a queue and can scale out automatically based on queues. Valid items are ENABLED or DISABLED. Default to ENABLED"
  default     = "ENABLED"
}

variable "batch_subnets" {
  type        = list(string)
  description = "A list of VPC subnets into which the compute resources are launched. Module will the necessary networking resources if this variable is not passed"
  default     = []
}

variable "batch_tags" {
  type        = map(string)
  description = "Key-value pair tags to be applied to resource that are launched in the compute environment"
  default     = {
        Terraform = "true"
        Environment = "dev"
  }
}

variable "batch_type" {
  type        = string
  description = "The type of the compute environment. Valid items are MANAGED or UNMANAGED"
  default     = "MANAGED" 
}  

//-----------------------------------

  
// CFT Module Variables

variable "create-cft" {
  type        = bool
  description = "Set to false to prevent the module from creating any resources"
  default     = false
}

variable "count-cft" {
  type        = number
  default     = 1
}

variable "cft_name" {
  type        = string
  description = "Solution name, e.g. 'app' or 'jenkins'"
  default     = "yash"
}

variable "cft_template_url" {
  type        = string
  description = "Amazon S3 bucket URL location of a file containing the CloudFormation template body. Maximum file size: 460,800 bytes"
  default     = "https://cft-terra.s3.amazonaws.com/cft.json"
}


//----------------------------------

// Lightsail Module Variables 

variable "lightsail_create" {
  type    = bool
  default = false
}

variable "lightsail_count" {
  type    = number
  default = 1
}


variable "lightsail_namespace" {
  type        = string
  description = "Namespace, which could be your team, business name or abbreviation, e.g. 'mag' or 'tar'"
  default     = "tfsquad"
}

variable "lightsail_environment" {
  type        = string
  description = "Environment, e.g. 'prod', 'staging', 'dev', 'pre-prod', 'UAT'"
  default     = "dev"
}

variable "lightsail_name" {
  type        = string
  description = "Solution name, e.g. 'app' or 'jenkins'"
  default     = "yashtfsquad"
}

variable "lightsail_attributes" {
  type        = list(string)
  default     = []
  description = "Additional attributes (e.g. `1`)"
}

variable "lightsail_tags" {
  type        = map(string)
  default     = {
      owner   = "tfsquad"
  }
  description = "Additional tags (e.g. `map('BusinessUnit','XYZ')`"
}

variable "lightsail_availability_zone" {
  type        = string
  default     = "us-east-1a"
  description = "The Availability Zone in which to create your instance"
}

variable "lightsail_blueprint_id" {
  type        = string
  default     = "wordpress"
  description = ""
}

variable "lightsail_bundle_id" {
  type        = string
  default     = "micro_2_0"
  description = "The bundle of specification information"
}

variable "lightsail_key_pair_name" {
  type        = string
  default     = "tfsquad"
  description = "The name of your key pair. Created in the Lightsail console (cannot use aws_key_pair at this time)"
}

variable "lightsail_user_data" {
  type        = string
  default     = ""
  description = "launch script to configure server with additional user data"
}

variable "lightsail_create_static_ip" {
  type        = bool
  default     = true
  description = "Create and attach a statis IP to the instance"
}

variable "lightsail_enable_email_alarm" {
  type        = bool
  default     = false
  description = "Enable metric for StatusCheckFailed which will notify using email"
}

variable "lightsail_customer_email" {
  type        = string
  description = "Customers email address, used to track owners of the platform, used for notifications and reporting"
  default     = "mayurdeshmukh4@gmail.com"
}

variable "lightsail_customer_business_name" {
  type        = string
  description = "Customers business name, used for notifications and reporting"
  default     = "tfsquadyash"
}
  
  
  

// MQ Module Variables 

variable "mq_create" {
  type    = bool
  default = false
}

variable "mq_count" {
  type    = number
  default = 1
}

variable "mq_engine_type" {
  description = "(Required) The type of broker engine"
  default     = "ActiveMQ"
}

variable "mq_engine_version" {
  description = "(Required) The version of the broker engine."
  default     = "5.15.0"
}

variable "mq_create_configuration" {
  description = "Should we create mq configuration or use a pre-existing one. If true, please provide input for var.configuration_data below or keep the deafult. if false, please provide input for var.configuration_id and var.configuration_revision below"
  default     = true
}

variable "mq_configuration_file" {
  description = "path to a config file for the mq configuration. defaults to config.xml located in the root module folder"
  default     = "config.xml"
}

variable "mq_configuration_id" {
  description = "The Configuration ID. only supply if var.create_configuration = false"
  default     = ""
}

variable "mq_configuration_revision" {
  description = "The Configuration revision. only supply if var.create_configuration = false"
  default     = ""
}

variable "mq_deployment_mode" {
  description = "(Optional) The deployment mode of the broker. Supported: SINGLE_INSTANCE and ACTIVE_STANDBY_MULTI_AZ"
  default     = "SINGLE_INSTANCE"
}

variable "mq_broker_name" {
  description = "(Required) The name of the broker. leave empty to auto generate"
  default     = "tfsquad"
}

variable "mq_host_instance_type" {
  description = "(Required) The broker's instance type. e.g. mq.t2.micro or mq.m4.large"
  default     = "mq.t2.micro"
}

variable "mq_vpc_id" {
  description = "the vpc id"
  default     = "vpc-8e5a68f4"
}

variable "mq_security_group_ids" {
  type        = list(string)
  description = "The list of security group IDs assigned to the broker"
  default     = ["sg-3b49dd11"]
}

variable "mq_username" {
  description = "(Required) The username of the user."
  default     = "MQAdmin"
}

variable "mq_password" {
  description = "(Required) The password of the user. It must be 12 to 250 characters long, at least 4 unique characters, and must not contain commas. if you wish to autogenerate, leave empty"
  default     = "Yash@12345678"
}

variable "mq_subnet_ids" {
  type        = list(string)
  description = "List of VPC subnet IDs"
  default     = ["subnet-3762d47a"]
}

variable "mq_security_group_name" {
  description = "name of the security group to crete. leave empty to auto-generate"
  default     = ""
}

variable "mq_rules" {
  description = "Map of security group rules objects."
  type = map(object({
    type        = string
    protocol    = string
    from_port   = string
    to_port     = string
    cidr_blocks = list(string)
  }))
  default = {}
}  

//---------------------------

// inspector Module Variables

variable "inspector_create" {
  type        = number
  default     = 1
}

variable "inspector_count" {
  type        = bool
  default     = false
}

variable "inspector_enabled" {
  default     = true
  description = "Set to false to disable all resources in this module.  A workaround for terraform<=0.12 having no mechanism for disabling modules between workspaces."
}

variable "inspector_ruleset_network_reachability" {
  type        = bool
  description = "Enable AWS Network Reachability Ruleset"
  default     = true
}
variable "inspector_ruleset_security_best_practices" {
  type        = bool
  description = "Enable AWS Security Best Practices Ruleset"
  default     = true
}
variable "inspector_schedule_expression" {
  type        = string
  description = "AWS Schedule Expression: https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/ScheduledEvents.html"
  default     = "cron(0 14 ? * THU *)" # Run every Thursday at 2PM UTC/9AM EST/10AM EDT
}

variable "inspector_assessment_duration" {
  type        = string
  description = "The duration of the Inspector assessment run"
  default     = "3600" # 1 hour
}

variable "inspector_enable_scheduled_event" {
  type        = bool
  description = "Enable Cloudwatch Events to schedule an assessment"
  default     = true
}

variable "inspector_name_prefix" {
  type        = string
  description = "Prefix for resource names that terraform will create"
  default     = "tfsquad"
}
variable "inspector_ruleset_cis" {
  type        = bool
  description = "Enable CIS Operating System Security Configuration Benchmarks Ruleset"
  default     = true
}
variable "inspector_ruleset_cve" {
  type        = bool
  description = "Enable Common Vulnerabilities and Exposures Ruleset"
  default     = true
}

  
