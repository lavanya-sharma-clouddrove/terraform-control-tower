#----------------------------- Common Variables -----------------

#Module      : LABEL
#Description : Terraform label module variables.


variable "name" {
  type        = string
  default     = ""
  description = "Name  (e.g. `app` or `cluster`)."
}

variable "region" {
  type = string
  default = "us-east-1"
  description = "region in which we want to deploy stack"
}
variable "repository" {
  type        = string
  default     = "https://github.com/clouddrove/aws-control-tower-architecture"
  description = "Terraform current module repo"

  validation {
    # regex(...) fails if it cannot find a match
    condition     = can(regex("^https://", var.repository))
    error_message = "The module-repo value must be a valid Git repo link."
  }
}

variable "tags" {
  type        = map(any)
  default     = {}
  description = "Additional tags (e.g. map(`BusinessUnit`,`XYZ`)."
}

variable "environment" {
  type        = string
  default     = "common"
  description = "Environment (e.g. `prod`, `dev`, `staging`)."
}
variable "label_order" {
  type        = list(any)
  default     = ["name"]
  description = "Label order, e.g. `name`,`application`."
}

variable "managedby" {
  type        = string
  default     = "hello@clouddrove.com"
  description = "ManagedBy, eg 'CloudDrove'."
}

variable "administration_role_arn" {
    description = "ARN of the administration role for the StackSet"
  type = string
  default = "arn:aws:iam::924144197303:role/AWSControlTowerExecution"
}

variable "execution_role_name" {
    description = "Name of the execution role for the StackSet"
  type = string
  default = "AWSControlTowerExecution"
}

variable "delegated_account_id" {
  type = string
  default = ""
}

variable "excluded_accounts" {
  description = "Accounts to be excluded from the Access Analyzer"
  type        = list(string) 
  default     = []
}

variable "template_bucket_name" {
  description = "bukcet name in which files are stored"
  type        = string
  default     = "control-tower-lavanya"
}

variable "role_to_assume" {
  description = "What role should be assumed in accounts to enable GuardDuty?  The Default is AWSControlTowerExecution for a Control Tower environment."
  type        = string
  default     = "AWSControlTowerExecution"
}

variable "capabilities" {
  type        = list
  default     = ["CAPABILITY_NAMED_IAM"]
}

variable "cloudformation_version" {
  type = string
  default = "2"
  description = "cloudformation version "
}

#---------------------------- Access Analyser Variables---------------------

variable "enable_access_analyzer" {
  type = bool
  description = "enable true if we want to create the stack elase false"
  default = false
}

variable "access_analyser_stack_name" {
  type = string
  default = "ct-AccessAnalyzerStack"
  description = "name of stack"
}

variable "access_analyzer_template_file_s3_Object_url" {
  type        = string
  default     = ""
    description = "URL of the CloudFormation template"
}

variable "access_analyzer_lambda_file_s3_key" {
  description = "lambda file path (lambda code zip file path) from s3"
  type        = string
  default     = "access-analyser/access-analyser.zip"
}


#-------------------------- Detective Variables -----------------------------

variable "enable_detective" {
  type = bool
  default = false
  description = "enable true if we want to create a stack for detective service elase put false"
}

variable "detective_stack_name" {
    description = "The name of the CloudFormation stack"
  type = string
  default = "ct-detective"
}

variable "detective_template_file_s3_object_url" {
description = "s3 template file url"
  default = ""
  type = string
}

variable "detective_lambda_file_s3_key" {
 description =  "The S3 Path to the Lambda Zip File"
  type = string
  default = "detective/detective.zip"
}


#-------------------------- Guardduty Variables ----------------------------

variable "enable_guardduty" {
  description = "true if you want to deploy guardduty stacket else false"
  type = bool
  default = false
}

variable "guardduty_stack_name" {
    description = "Name of the CloudFormation Stack"
  type = string
  default = "ct-guardduty"
}

variable "guardduty_template_file_s3_object_url" {
    description = "URL of the CloudFormation template"
  type = string
  default = ""
}

variable "guardduty_lambda_file_s3_key" {
    description = "S3 bucket where the source files are stored"
  type = string
  default ="guardduty/guardduty_enabler.zip"
}


#------------------------- Inspector Variables ------------------------

variable "enable_inspector" {
  description = "enable true if you want to create stackset for inspector else false"
  type = bool
  default = false
}

variable "inspector_stack_name" {
   description = "Name of the CloudFormation StackSet"
  type = string
  default = "ct-inspector"
}

variable "inspector_template_file_s3_object_url" {
  description = "URL of the CloudFormation template"
  type = string
  default = ""
}

variable "inspector_lambda_file_s3_key" {
  description = "path of the CloudFormation lambda file (lambda code zip file path)"
  type = string
  default = "inspector/inspector.zip"
}

#---------------------------- Security Hub Variables----------------------------

variable "enable_security_hub" {
  type = bool
  default = false
  description = "put true if you want to create stackset for security_hub else false"
}

variable "security_hub_stack_name" {
  type = string
  default = "ct-securityhub"
   description = "Name of the CloudFormation stack"
}

variable "security_hub_template_file_s3_object_url" {
  type = string
  default = ""
  description = "URL to the CloudFormation template in S3"
}

variable "security_hub_lambda_file_s3_key" {
   description = "S3 key (lambda code zip file path) for the CloudFormation template"
  type = string
  default = "security-hub/securityhub_enabler.zip"
}

variable "security_hub_aws_standard" {
  description = "Enable AWS standard (Yes/No)"
  type = string
  default = "Yes"
}

variable "security_hub_cis120_standard" {
   description = "Enable CIS 1.20 standard (Yes/No)"
  type = string
  default = "No"
}

variable "security_hub_cis140_standard" {
   description = "Enable CIS 1.40 standard (Yes/No)"
  type = string
  default = "Yes"
}

variable "security_hub_pci_standard" {
  description = "Enable PCI standard (Yes/No)"
  type = string
  default = "Yes"
}
variable "security_hub_nist_standard" {
  description = "Enable NIST standard (Yes/No)"
  type = string
  default = "Yes"
}


#----------------- Config Variables -------------------------

variable "enable_config" {
  type = bool
  default = false
  description = "put true if you want to create stackset for config else false"
}

variable "config_stack_name" {
  type = string
  default = "ct-aws-config"
  description = "name of stack for config"
}

variable "config_template_file_s3_object_url" {
  type = string
  default = ""
  description = ""
}

variable "ConfigRecorderExcludedResourceTypes" {
  type = string
  default = "AWS::HealthLake::FHIRDatastore,AWS::Pinpoint::Segment,AWS::Pinpoint::ApplicationSettings"
  description = "List of all resource types to be excluded from Config Recorder"
}

#------------------------------- Inspection Lambda Variables---------------------

variable "enable_inspection_lambda" {
  type = bool
  default = false
  description = "put true if you want to deploy stack for inspection lambda else false"
}
variable "inspection_lambda_stack_name" {
  type = string
  default = "ct-inspection-lambda"
  description = "name of inspection lambda stack"
}

variable "inspection_lambda_template_s3_object_url" {
  type = string
  default = ""
  description = "lambda file template url form s3 bucket"
}

variable "inspection_lambda_lambda_file_s3_key" {
  type = string
  default = ""
  description = "lambda file path for inspection lambda (lambda code zip file path)"
}

variable "inspection_destination_bucket_name" {
  type = string
  default = ""
  description = "destination bucket name for inspection lambda"
}


#-------------------- Macie Variables -------------------------------

variable "enable_macie" {
  type = bool
  default = false
  description = "put true if you want to deploy stak for macie else false"
}

variable "macie_stack_name" {
  type = string
  default = "ct-aws-macie"
  description = "name of cloudfromation stack for macie."
}

variable "macie_template_file_object_url" {
  type = string
  default = ""
  description = "template file url for macie"
}

variable "macie_lambda_file_s3_key" {
  type = string
  default = "aws-macie/macie.zip"
  description = "lambda file path (lambda code zip file path)"
}

#--------------------------- Subdomain Delegation (Master Stack) varaibles-------------

variable "enable_subdomain_delegation_master" {
  type = bool
  default = false
  description = "put true if you want to deploy else false for subdomain delegation master"
}

variable "subdomain_delegation_master_stack_name" {
  type = string
  default = "ct-subdomain-delegation-master"
  description = "the value for name of master stack "
}

variable "subdomain_delegation_master_template_file_s3_object_url" {
  type = string
  default = ""
  description = "template url from s3"
}

variable "subdomain_delegation_hosted_zone_id" {
  type = string
  default = ""
  description = "hosted zone id for master stack"
}

variable "subdomain_delegation_authorized_account" {
  type = string
  default = ""
  description = "authorized account id for subdomain delegation master stack"
}

variable "subdomain_delegation_lambda_file_s3_key" {
  type = string
  default = ""
  description = "s3 key for subdomain delegation master stack (lambda code zip file path)"
}

#-------------------- Subdomain Delegation (Child Stack) Variables--------------------

variable "enable_subdomain_delegation_child" {
  type = bool
  default = false
  description = "put true if you want to deploy else false for subdomain delegation child"
}

variable "subdomain_delegation_child_stack_name" {
  type = string
  default = "ct-subdomain-delegation-child"
  description = "child stack name for subdomain delegation"
}

variable "subdomain_delegation_domain_name" {
  type = string
  default = ""
  description = "domain name for subdomain delegation child stack"
}

variable "subdomain_delegation_child_template_file_s3_object_url" {
  type = string
  default = ""
  description = "template url from s3"
}

#------------------- AWS Notification Webhook------------------------------

variable "enable_notification_webhook" {
  type = bool
  default = false
  description = "put true if you want to deploy stack for aws notification webhook elase false"
}

variable "notification_webhook_stack_name" {
  type = string
  default = "ct-notification-webhook"
  description = "control tower aws notification webhook stack name"
}

variable "notification_webhook_template_file_s3_object_url" {
  type = string
  default = ""
  description = "aws notification webhook service cloudfromation template url"
}

variable "webhook_url" {
  type = string
  default = ""
  description  = "webhook url slack or any other."
}

variable "notification_webhook_rule_filter" {
  type = string
  default = "ALL_RULES"
  description = "filter rules for aws notification url"
}

variable "notification_webhook_lambda_file_s3_key" {
  type = string
  default = ""
  description  = "path for lambda zip file in bucket (lambda code zip file path)"
}
