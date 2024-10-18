variable "region" {
  description = "The AWS region to deploy resources."
  type        = string
  default     = "us-east-1"  # Update to your preferred region
}

variable "name" {
  description = "The name of the application."
  type        = string
}

variable "repository" {
  description = "The repository URL."
  type        = string
}

variable "environment" {
  description = "Deployment environment (e.g., dev, prod)."
  type        = string
}

variable "managedby" {
  description = "Who is managing the deployment."
  type        = string
}

variable "label_order" {
  description = "Order of labels for tagging."
  type        = list(string)
  default     = []
}

variable "capabilities" {
  description = "The capabilities to be used in CloudFormation stacks."
  type        = list(string)
  default     = []
}

# Access Analyzer
variable "enable_access_analyzer" {
  type        = bool
  description = "Enable Access Analyzer stack creation."
  default     = false
}

variable "access_analyzer_stack_name" {
  description = "Stack name for Access Analyzer."
  type        = string
}

variable "access_analyzer_template_file" {
  description = "URL of the CloudFormation template for Access Analyzer."
  type        = string
}

# Detective
variable "enable_detective" {
  type        = bool
  description = "Enable Detective stack creation."
  default     = false
}

variable "detective_stack_name" {
  description = "Stack name for Detective."
  type        = string
}

variable "detective_template_file" {
  description = "URL of the CloudFormation template for Detective."
  type        = string
}

# GuardDuty
variable "enable_guardduty" {
  type        = bool
  description = "Enable GuardDuty stack creation."
  default     = false
}

variable "guardduty_stack_name" {
  description = "Stack name for GuardDuty."
  type        = string
}

variable "guardduty_template_file" {
  description = "URL of the CloudFormation template for GuardDuty."
  type        = string
}

# Inspector
variable "enable_inspector" {
  type        = bool
  description = "Enable Inspector stack creation."
  default     = false
}

variable "inspector_stack_name" {
  description = "Stack name for Inspector."
  type        = string
}

variable "inspector_template_file" {
  description = "URL of the CloudFormation template for Inspector."
  type        = string
}

# Security Hub
variable "enable_security_hub" {
  type        = bool
  description = "Enable Security Hub stack creation."
  default     = false
}

variable "security_hub_stack_name" {
  description = "Stack name for Security Hub."
  type        = string
}

variable "security_hub_template_url" {
  description = "URL of the CloudFormation template for Security Hub."
  type        = string
}

# Config
variable "enable_config" {
  type        = bool
  description = "Enable Config stack creation."
  default     = false
}

variable "config_stack_name" {
  description = "Stack name for Config."
  type        = string
}

variable "config_template_url" {
  description = "URL of the CloudFormation template for Config."
  type        = string
}

# Inspection Lambda
variable "enable_inspection_lambda" {
  type        = bool
  description = "Enable Inspection Lambda stack creation."
  default     = false
}

variable "inspection_stack_name" {
  description = "Stack name for Inspection Lambda."
  type        = string
}

variable "inspection_lambda_template_url" {
  description = "URL of the CloudFormation template for Inspection Lambda."
  type        = string
}

# Macie
variable "enable_macie" {
  type        = bool
  description = "Enable Macie stack creation."
  default     = false
}

variable "macie_stack_name" {
  description = "Stack name for Macie."
  type        = string
}

variable "macie_template_url" {
  description = "URL of the CloudFormation template for Macie."
  type        = string
}

# Subdomain Delegation (Master Stack)
variable "enable_subdomain_delegation_master" {
  type        = bool
  description = "Enable Subdomain Delegation Master stack creation."
  default     = false
}

variable "subdomain_delegation_master_stack_name" {
  description = "Stack name for Subdomain Delegation Master."
  type        = string
}

variable "subdomain_delegation_template_file" {
  description = "URL of the CloudFormation template for Subdomain Delegation."
  type        = string
}

# Subdomain Delegation (Child Stack)
variable "enable_subdomain_delegation_child" {
  type        = bool
  description = "Enable Subdomain Delegation Child stack creation."
  default     = false
}

variable "subdomain_delegation_child_stack_name" {
  description = "Stack name for Subdomain Delegation Child."
  type        = string
}

# Notification Webhook
variable "enable_notification_webhook" {
  type        = bool
  description = "Enable Notification Webhook stack creation."
  default     = false
}

variable "notification_webhook_stack_name" {
  description = "Stack name for Notification Webhook."
  type        = string
}

variable "notification_webhook_template_url" {
  description = "URL of the CloudFormation template for Notification Webhook."
  type        = string
}

# Common Variables
variable "administration_role_arn" {
  description = "The ARN of the administration role for CloudFormation."
  type        = string
}

variable "execution_role_name" {
  description = "The name of the execution role for CloudFormation."
  type        = string
}

variable "template_bucket_name" {
  description = "The S3 bucket where templates are stored."
  type        = string
}

variable "role_to_assume" {
  description = "The role to assume for deploying CloudFormation stacks."
  type        = string
}

variable "excluded_accounts" {
  description = "List of accounts to exclude."
  type        = list(string)
  default     = []
}

variable "delegated_account_id" {
  description = "The account ID of the delegated account."
  type        = string
}

# Security Hub Standards
variable "security_hub_cis120_standard" {
  description = "Enable CIS 120 Standard in Security Hub."
  type        = bool
  default     = false
}

variable "security_hub_cis140_standard" {
  description = "Enable CIS 140 Standard in Security Hub."
  type        = bool
  default     = false
}

variable "security_hub_pci_standard" {
  description = "Enable PCI Standard in Security Hub."
  type        = bool
  default     = false
}

variable "security_hub_nist_standard" {
  description = "Enable NIST Standard in Security Hub."
  type        = bool
  default     = false
}

variable "security_hub_region_filter" {
  description = "Region filter for Security Hub."
  type        = string
}

variable "security_hub_ou_filter" {
  description = "OU filter for Security Hub."
  type        = string
}

variable "security_hub_compliance_frequency" {
  description = "Compliance frequency for Security Hub."
  type        = string
}

variable "webhook_url" {
  description = "The URL for the notification webhook."
  type        = string
}

variable "notification_webhook_rule_filter" {
  description = "Rule filter for notification webhook."
  type        = string
}

variable "notification_webhook_s3_key" {
  description = "S3 key for notification webhook template."
  type        = string
}
