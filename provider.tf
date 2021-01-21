provider "aws" {
  version                     = "~> 2.0"
  region                      = "us-east-1"
  access_key                  = "AKIAS4FFUNNURDMCBKGU" 
  secret_key                  = "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"
  skip_get_ec2_platforms      = true
  skip_metadata_api_check     = true
  skip_region_validation      = true
  skip_credentials_validation = true
  skip_requesting_account_id  = true
}