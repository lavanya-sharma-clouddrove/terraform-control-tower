
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

locals {
  name        = var.name
  environment = var.environment
  label_order = var.label_order
}

module "control_tower_template_bucket" {
  source  = "clouddrove/s3/aws"
  version = "2.0"

  name               = "${local.name}-control-tower-cloudformation-template"
 # versioning         = var.bucket_versioning
 # bucket_policy      = var.bucket_policy
#  only_https_traffic = var.bucket_only_https_traffic
}
