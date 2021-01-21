provider "aws" {
  version = "~> 2.0"
  region  = "us-east-1"
  access_key = "AKIAS5PE77E5DIHT7G56"
  secret_key = "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" 
  skip_get_ec2_platforms      = true
  skip_metadata_api_check     = true
  skip_region_validation      = true
  skip_credentials_validation = true
  skip_requesting_account_id  = true
}
