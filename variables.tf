#vriables for access analyzer

#Module      : LABEL
#Description : Terraform label module variables.
variable "name" {
  type        = string
  default     = ""
  description = "Name  (e.g. `app` or `cluster`)."
}

variable "region" {
  type        = string
  default     = "us-east-1"
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

variable "delimiter" {
  type        = string
  default     = "-"
  description = "Delimiter to be used between `organization`, `environment`, `name` and `attributes`."
}

variable "tags" {
  type        = map(any)
  default     = {}
  description = "Additional tags (e.g. map(`BusinessUnit`,`XYZ`)."
}

variable "managedby" {
  type        = string
  default     = "hello@clouddrove.com"
  description = "ManagedBy, eg 'CloudDrove'."
}

# Module      : Control tower Module
# Description : Terraform EC2 module variables.

variable "delegated_account_id" {
  type    = string
  default = ""
}
variable "template_bucket_name" {
  description = "bukcet name in which files are stored"
  type        = string
  default     = "control-tower-cloudformation-template"
}


#--------variables for access analyzer-----------
variable "enable_access_analyzer" {
  type        = bool
  description = "enable true if we want to create the stack elase false"
  default     = false
}

variable "access_analyzer_template_file" {
  type        = string
  default     = ""
  description = "URL of the CloudFormation template"
}

variable "access_analyser_stack_name" {
  type        = string
  default     = "Access-Analyzer"
  description = "name of stack"
}

# variable "access_analyzer_excluded_accounts" {
#     description = "Accounts to be excluded from the Access Analyzer"
#   type        = string
#   default     = ""
# }



variable "access_analyzer_lambda_file" {
  description = "lambda file path (lambda code zip file path) from s3"
  type        = string
  default     = "access-analyser/access-analyser.zip"
}

variable "role_to_assume" {
  description = "What role should be assumed in accounts to enable GuardDuty?  The Default is AWSControlTowerExecution for a Control Tower environment."
  type        = string
  default     = "AWSControlTowerExecution"
}

variable "capabilities" {
  type    = list(any)
  default = ["CAPABILITY_NAMED_IAM"]
}



#------------variables for detective----------------

variable "detective_stack_name" {
  description = "The name of the CloudFormation stack"
  type        = string
  default     = "Detective"
}
variable "enable_detective" {
  type        = bool
  default     = false
  description = "enable true if we want to create a stack for detective service elase put false"
}
variable "detective_lambda_file" {
  description = "The S3 Path to the Lambda Zip File"
  type        = string
  default     = "detective/detective.zip"

}
variable "excluded_accounts" {
  description = "Excluded Accounts list. This list should contain Management account, Log Archive and Audit accounts at the minimum"
  default     = ""
  type        = string
}
variable "detective_template_file" {
  description = "s3 template file url"
  default     = ""
  type        = string
}

#variables for guardduty------
variable "guardduty_stack_name" {
  description = "Name of the CloudFormation Stack"
  type        = string
  default     = "Guard-duty"
}
variable "guardduty_template_file" {
  description = "URL of the CloudFormation template"
  type        = string
  default     = ""
}
variable "administration_role_arn" {
  description = "ARN of the administration role for the StackSet"
  type        = string
  default     = ""
}
variable "execution_role_name" {
  description = "Name of the execution role for the StackSet"
  type        = string
  default     = "AWSControlTowerExecution"
}
# variable "security_account_id" {
#     description = "Security account ID"
#   type = string
#   default = ""
# }
variable "guardduty_s3_source_file" {
  description = "S3 bucket where the source files are stored"
  type        = string
  default     = "guardduty/guardduty_enabler.zip"
}
# variable "guardduty_compliance_frequency" {
#     description = "Frequency of compliance checks"
#   type = string
#   default = ""
# }
# variable "guardduty_region_filter" {
#     description = "Region filter for Control Tower"
#   type = string
#   default = ""
# }
variable "guardduty_stack_instance_region" {
  description = "region in which you want to deploy "
  type        = string
  default     = "us-east-1"
}
variable "enable_guardduty" {
  description = "true if you want to deploy guardduty stacket else false"
  type        = bool
  default     = false
}

#----------inspector variables---------
variable "inspector_stack_name" {
  description = "Name of the CloudFormation StackSet"
  type        = string
  default     = "Inspector"
}
variable "inspector_lambda_file" {
  description = "path of the CloudFormation lambda file (lambda code zip file path)"
  type        = string
  default     = "inspector/inspector.zip"
}
variable "inspector_template_file" {
  description = "URL of the CloudFormation template"
  type        = string
  default     = ""
}
variable "enable_inspector" {
  description = "enable true if you want to create stackset for inspector else false"
  type        = bool
  default     = false
}
# variable "inspector_account_id" {
#   type = string
#   default = ""
# }

#--------security-hub-----------
variable "security_hub_stack_name" {
  type        = string
  default     = "Securityhub"
  description = "Name of the CloudFormation stack"
}
variable "security_hub_template_file" {
  type        = string
  default     = ""
  description = "URL to the CloudFormation template in S3"
}
# variable "security_hub_region_filter" {
#    description = "Region filter for the deployment"
#   type = string
#   default = ""
# }
# variable "security_hub_ou_filter" {
#   description = "Organizational Unit filter"
#   type = string
#   default = ""
# }
variable "security_hub_s3_source_key" {
  description = "S3 key (lambda code zip file path) for the CloudFormation template"
  type        = string
  default     = "security-hub/securityhub_enabler.zip"
}
# variable "security_hub_compliance_frequency" {
#   description = "Frequency of compliance checks"
#   type = string
#   default = ""
# }
variable "security_hub_aws_standard" {
  description = "Enable AWS standard (Yes/No)"
  type        = string
  default     = "Yes"
}
variable "security_hub_cis120_standard" {
  description = "Enable CIS 1.20 standard (Yes/No)"
  type        = string
  default     = "No"
}
variable "security_hub_cis140_standard" {
  description = "Enable CIS 1.40 standard (Yes/No)"
  type        = string
  default     = "Yes"
}
# variable "seccurity_hub_cis140_standard" {
#   description = "Enable CIS 1.40 standard (Yes/No)"
#   type = string
#   default = ""
# }
variable "security_hub_pci_standard" {
  description = "Enable PCI standard (Yes/No)"
  type        = string
  default     = "Yes"
}
variable "security_hub_nist_standard" {
  description = "Enable NIST standard (Yes/No)"
  type        = string
  default     = "Yes"
}
variable "enable_security_hub" {
  type        = bool
  default     = false
  description = "put true if you want to create stackset for security_hub else false"
}

#--------------config-------------------
variable "enable_config" {
  type        = bool
  default     = false
  description = "put true if you want to create stackset for config else false"
}
variable "config_stack_name" {
  type        = string
  default     = "Aws-Config"
  description = "name of stack for config"
}
variable "config_template_url" {
  type        = string
  default     = ""
  description = ""
}
# variable "ConfigRecorderExcludedResourceTypes" {
#   type = string
#   default = "AWS::HealthLake::FHIRDatastore,AWS::Pinpoint::Segment,AWS::Pinpoint::ApplicationSettings"
#   description = "List of all resource types to be excluded from Config Recorder"
# }
# variable "cloudformation_version" {
#   type = string
#   default = "2"
#   description = "cloudformation version "
# }

#----------------------inspection lambda-----------------
variable "enable_inspection_lambda" {
  type        = bool
  default     = false
  description = "put true if you want to deploy stack for inspection lambda else false"
}
variable "inspection_stack_name" {
  type        = string
  default     = "Inspection-lambda"
  description = "name of inspection lambda stack"
}
variable "inspection_destination_bucket_name" {
  type        = string
  default     = ""
  description = "destination bucket name for inspection lambda"
}
variable "inspection_lambda_template_file" {
  type        = string
  default     = ""
  description = "lambda file template url form s3 bucket"
}
variable "inspection_lambda_key" {
  type        = string
  default     = "inspection-lambda/aws-inspection-lambda.zip"
  description = "lambda file path for inspection lambda (lambda code zip file path)"
}

#--------------macie----------------
variable "enable_macie" {
  type        = bool
  default     = false
  description = "put true if you want to deploy stak for macie else false"
}
variable "macie_stack_name" {
  type        = string
  default     = "Aws-Macie"
  description = "name of cloudfromation stack for macie."
}
variable "macie_template_file" {
  type        = string
  default     = ""
  description = "template file url for macie"
}
# variable "macie_destination_bucket_name" {
#   type = string
#   default = ""
#   description = "detination bucket name for macie"
# }
variable "macie_lambda_file" {
  type        = string
  default     = "aws-macie/macie.zip"
  description = "lambda file path (lambda code zip file path)"
}

#----------------subdomain delegation --------
variable "subdomain_delegation_master_stack_name" {
  type        = string
  default     = "hosted-zone-delegation-master"
  description = "the value for name of stack for master account "
}
variable "subdomain_delegation_template_file" {
  type        = string
  default     = ""
  description = "template url from s3"
}
variable "subdomain_delegation_hosted_zone_id" {
  type        = string
  default     = ""
  description = "hosted zone id for master stack"
}
variable "subdomain_delegation_authorized_account" {
  type        = string
  default     = ""
  description = "authorized account id for subdomain delegation master stack"
}
variable "subdomain_delegation_s3_key" {
  type        = string
  default     = "hosted-zone-delegation/layer.zip"
  description = "s3 key for subdomain delegation master stack (lambda code zip file path)"
}
variable "subdomain_delegation_child_stack_name" {
  type        = string
  default     = "hosted-zone-delegation-child"
  description = "child stack name for subdomain delegation"
}
variable "subdomain_delegation_domain_name" {
  type        = string
  default     = ""
  description = "domain name for subdomain delegation child stack"
}
variable "subdomain_delegation_master_account_id" {
  type        = string
  default     = ""
  description = "subdomain delegation master account id "
}
variable "enable_subdomain_delegation_master" {
  type        = bool
  default     = false
  description = "put true if you want to deploy else false for subdomain delegation master"
}
variable "enable_subdomain_delegation_child" {
  type        = bool
  default     = false
  description = "put true if you want to deploy else false for subdomain delegation child"
}

#-------- aws notification webhook-------------------
variable "enable_notification_webhook" {
  type        = bool
  default     = false
  description = "put true if you want to deploy stack for aws notification webhook elase false"
}
variable "notification_webhook_stack_name" {
  type        = string
  default     = "ct-notification-webhook"
  description = "control tower aws notification webhook stack name"
}
variable "notification_webhook_template_file" {
  type        = string
  default     = ""
  description = "aws notification webhook service cloudfromation template url"
}
variable "webhook_url" {
  type        = string
  default     = ""
  description = "webhook url slack or any other."
}
variable "notification_webhook_rule_filter" {
  type        = string
  default     = "ALL_RULES"
  description = "filter rules for aws notification url"
}
variable "notification_webhook_s3_key" {
  type        = string
  default     = ""
  description = "path for lambda zip file in bucket (lambda code zip file path)"
}

variable "enable_backup_member_account_role" {
  description = "enable true if you want to create stackset for inspector else false"
  type        = bool
  default     = false
}

variable "pTagKey1" {
  type        = string
  default     = "deployedby"
  description = "path for lambda zip file in bucket (lambda code zip file path)"
}

variable "pTagValue1" {
  type        = string
  default     = "stackset"
  description = "path for lambda zip file in bucket (lambda code zip file path)"
}

variable "backup_member_role_template_file" {
  type        = string
  default     = ""
  description = "template object url from s3"
}

########

variable "enable_backup_member_account" {
  description = "enable true if you want to create stackset for inspector else false"
  type        = bool
  default     = false
}

variable "backup_member_account_file" {
  type        = string
  default     = ""
  description = "template object url from s3"
}

variable "pCrossAccountBackupRole" {
  type        = string
  default     = "awsbackuprole"
  description = "path for lambda zip file in bucket (lambda code zip file path)"
}

variable "pBackupKeyAlias" {
  type        = string
  default     = "awsbackupkey"
  description = "path for lambda zip file in bucket (lambda code zip file path)"
}

variable "pMemberBackupVaultName" {
  type        = string
  default     = "awsbackupvault"
  description = "path for lambda zip file in bucket (lambda code zip file path)"
}

variable "enable_inspector" {
  description = "enable true if you want to create stackset for inspector else false"
  type        = bool
  default     = false
}

variable "enable_central_backup_account" {
  description = "enable true if you want to create stackset for inspector else false"
  type        = bool
  default     = false
}

variable "central_backup_account_file" {
  type        = string
  default     = ""
  description = "template object url from s3"
}

variable "enable_central_backup_org_account" {
  description = "enable true if you want to create stackset for inspector else false"
  type        = bool
  default     = false
}

variable "central_backup_org_account_template_file" {
  type        = string
  default     = ""
  description = "template object url from s3"
}

variable "pBackupTagKey2" {
  type        = string
  default     = "backup"
  description = "path for lambda zip file in bucket (lambda code zip file path)"
}

variable "pBackupTagValue2" {
  type        = string
  default     = "enable"
  description = "path for lambda zip file in bucket (lambda code zip file path)"
}

variable "pCentralBackupVaultArn" {
  type        = string
  default     = "aws-backup/OrgPolicyCustomResourceManager.zip"
  description = "path for lambda zip file in bucket (lambda code zip file path)"
}
