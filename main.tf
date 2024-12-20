provider "aws" {
  region = var.region
}

data "aws_caller_identity" "current" {}
data "aws_organizations_organization" "organization" {}

module "labels" {
  source      = "clouddrove/labels/aws"
  version     = "1.3.0"
  name        = var.name
  repository  = var.repository
  environment = var.environment
  managedby   = var.managedby
  label_order = var.label_order
}

# Access Analyzer
resource "aws_cloudformation_stack_set" "access_analyzer_stackset" {
  count                   = var.enable_access_analyzer ? 1 : 0
  name                    = var.access_analyser_stack_name
  template_url            = var.access_analyzer_template_file
  administration_role_arn = var.administration_role_arn
  execution_role_name     = var.execution_role_name

  parameters = {
    OrganizationId                = data.aws_organizations_organization.organization.id
    AccessAnalyserMasterAccountId = var.delegated_account_id
    ExcludedAccounts              = var.excluded_accounts
    S3SourceBucket                = var.template_bucket_name
    S3Key                         = var.access_analyzer_lambda_file
  }

  capabilities = var.capabilities
  tags         = module.labels.tags
}

resource "aws_cloudformation_stack_set_instance" "access_analyzer_instance" {
  count          = var.enable_access_analyzer ? 1 : 0
  account_id     = data.aws_caller_identity.current.account_id
  region         = var.region
  stack_set_name = var.enable_access_analyzer ? aws_cloudformation_stack_set.access_analyzer_stackset[0].name : null
}

# Detective (nothing mention in docs stack or stackset)
resource "aws_cloudformation_stack_set" "detective_stackset" {
  count                   = var.enable_detective ? 1 : 0
  name                    = var.detective_stack_name
  template_url            = var.detective_template_file
  administration_role_arn = var.administration_role_arn
  execution_role_name     = var.execution_role_name

  parameters = {
    OrganizationId           = data.aws_organizations_organization.organization.id
    DetectiveMasterAccountId = var.delegated_account_id
    S3SourceBucket           = var.template_bucket_name
    S3Key                    = var.detective_lambda_file
    RoleToAssume             = var.role_to_assume
    ExcludedAccounts         = var.excluded_accounts
  }

  capabilities = var.capabilities
  tags         = module.labels.tags
}

resource "aws_cloudformation_stack_set_instance" "detective_instance" {
  count          = var.enable_detective ? 1 : 0
  account_id     = data.aws_caller_identity.current.account_id
  region         = var.region
  stack_set_name = var.enable_detective ? aws_cloudformation_stack_set.detective_stackset[0].name : null
}

# GuardDuty 
resource "aws_cloudformation_stack" "guardduty_stack" {
  count        = var.enable_guardduty ? 1 : 0
  name         = var.guardduty_stack_name
  template_url = var.guardduty_template_file
  parameters = {
    OrganizationId    = data.aws_organizations_organization.organization.id
    SecurityAccountId = var.delegated_account_id
    S3SourceBucket    = var.template_bucket_name
    S3SourceFile      = var.guardduty_s3_source_file
    ExcludedAccounts  = var.excluded_accounts
  }

  capabilities = var.capabilities
  tags         = module.labels.tags
}

# Inspector
resource "aws_cloudformation_stack_set" "inspector_stackset" {
  count                   = var.enable_inspector ? 1 : 0
  name                    = var.inspector_stack_name
  template_url            = var.inspector_template_file
  administration_role_arn = var.administration_role_arn
  execution_role_name     = var.execution_role_name

  parameters = {
    OrganizationId          = data.aws_organizations_organization.organization.id
    InspectorAuditAccountId = var.delegated_account_id
    S3SourceBucket          = var.template_bucket_name
    S3Key                   = var.inspector_lambda_file
    RoleToAssume            = var.role_to_assume
    ExcludedAccounts        = var.excluded_accounts
  }

  capabilities = var.capabilities
  tags         = module.labels.tags
}

resource "aws_cloudformation_stack_set_instance" "inspector_instance" {
  count          = var.enable_inspector ? 1 : 0
  account_id     = data.aws_caller_identity.current.account_id
  region         = var.region
  stack_set_name = var.enable_inspector ? aws_cloudformation_stack_set.inspector_stackset[0].name : null
}

# Security Hub
resource "aws_cloudformation_stack" "security_hub_stack" {
  count        = var.enable_security_hub ? 1 : 0
  name         = var.security_hub_stack_name
  template_url = var.security_hub_template_file

  parameters = {
    SecurityAccountId = var.delegated_account_id
    ExcludedAccounts  = var.excluded_accounts
    OrganizationId    = data.aws_organizations_organization.organization.id
    # RegionFilter        = var.security_hub_region_filter
    # OUFilter            = var.security_hub_ou_filter
    S3SourceBucket = var.template_bucket_name
    S3SourceKey    = var.security_hub_s3_source_key
    # ComplianceFrequency = var.security_hub_compliance_frequency
    RoleToAssume   = var.role_to_assume
    AWSStandard    = var.security_hub_aws_standard
    CIS120Standard = var.security_hub_cis120_standard
    CIS140Standard = var.security_hub_cis140_standard
    PCIStandard    = var.security_hub_pci_standard
    NISTStandard   = var.security_hub_nist_standard
  }

  capabilities = var.capabilities
  tags         = module.labels.tags
}

# Config
resource "aws_cloudformation_stack" "config_stack" {
  count        = var.enable_config ? 1 : 0
  name         = var.config_stack_name
  template_url = var.config_template_url

  parameters = {
    ExcludedAccounts = var.excluded_accounts
    S3SourceBucket   = var.template_bucket_name
  }

  capabilities = var.capabilities
  tags         = module.labels.tags
}

# Inspection Lambda
resource "aws_cloudformation_stack" "inspection_lambda_stack" {
  count        = var.enable_inspection_lambda ? 1 : 0
  name         = var.inspection_stack_name
  template_url = var.inspection_lambda_template_file

  parameters = {
    DestinationBucketName = var.inspection_destination_bucket_name
    OrganizationId        = data.aws_organizations_organization.organization.id
    AssumeRole            = var.role_to_assume
    S3SourceBucket        = var.template_bucket_name
    S3Key                 = var.inspection_lambda_key
  }

  capabilities = var.capabilities
  tags         = module.labels.tags
}

# Macie
resource "aws_cloudformation_stack" "macie_stack" {
  count        = var.enable_macie ? 1 : 0
  name         = var.macie_stack_name
  template_url = var.macie_template_file

  parameters = {
    OrganizationId = data.aws_organizations_organization.organization.id
    # RoleToAssume          = var.role_to_assume
    S3SourceBucket       = var.template_bucket_name
    S3Key                = var.macie_lambda_file
    MacieMasterAccountId = var.delegated_account_id
    ExcludedAccounts     = var.excluded_accounts
  }

  capabilities = var.capabilities
  tags         = module.labels.tags
}

# Subdomain Delegation (Master Stack)
resource "aws_cloudformation_stack" "master_stack" {
  count        = var.enable_subdomain_delegation_master ? 1 : 0
  name         = var.subdomain_delegation_master_stack_name
  template_url = var.subdomain_delegation_template_file

  parameters = {
    HostedZoneId       = var.subdomain_delegation_hosted_zone_id
    AuthorizedAccounts = var.subdomain_delegation_authorized_account
    S3Bucket           = var.template_bucket_name
    S3Key              = var.subdomain_delegation_s3_key
  }

  capabilities = var.capabilities
  tags         = module.labels.tags
}

# Subdomain Delegation (Child Stack)
resource "aws_cloudformation_stack" "child_stack" {
  count        = var.enable_subdomain_delegation_child ? 1 : 0
  name         = var.subdomain_delegation_child_stack_name
  template_url = var.subdomain_delegation_template_file

  parameters = {
    DomainName      = var.subdomain_delegation_domain_name
    MasterAccountId = var.delegated_account_id
  }

  capabilities = var.capabilities
  tags         = module.labels.tags
}
#aws webhook
resource "aws_cloudformation_stack" "ct_notifications_stack" {
  count        = var.enable_notification_webhook ? 1 : 0
  name         = var.notification_webhook_stack_name
  template_url = var.notification_webhook_template_file

  parameters = {
    WebhookUrl   = var.webhook_url
    RuleFilter   = var.notification_webhook_rule_filter
    S3BucketName = var.template_bucket_name
    S3Key        = var.notification_webhook_s3_key
  }

  capabilities = var.capabilities
  tags         = module.labels.tags
}

# AWS CloudFormation StackSet and StackSet Instances for AWS Backups

# Backup Member Account Role StackSet
resource "aws_cloudformation_stack_set" "backup_member_account_role" {
  count                   = var.enable_backup_member_account_role ? 1 : 0
  name                    = "awsbackup-member-accounts-role"
  template_url            = var.backup_member_role_template_file
  administration_role_arn = var.administration_role_arn
  execution_role_name     = var.execution_role_name

  parameters = {
    pCrossAccountBackupRole = var.pCrossAccountBackupRole
    pTagKey1                = var.pTagKey1
    pTagValue1              = var.pTagValue1
  }

  capabilities = var.capabilities
  tags         = module.labels.tags
}

resource "aws_cloudformation_stack_set_instance" "backup_member_account_role_instance" {
  count          = var.enable_backup_member_account_role ? 1 : 0
  account_id     = data.aws_caller_identity.current.account_id
  region         = var.region
  stack_set_name = aws_cloudformation_stack_set.backup_member_account_role[0].name
}

# Backup Member Account StackSet
resource "aws_cloudformation_stack_set" "backup_member_account" {
  count                   = var.enable_backup_member_account ? 1 : 0
  name                    = "backup-member-account"
  template_url            = var.backup_member_account_file
  administration_role_arn = var.administration_role_arn
  execution_role_name     = var.execution_role_name

  parameters = {
    pTagKey1                = var.pTagKey1
    pTagValue1              = var.pTagValue1
    pCrossAccountBackupRole = var.pCrossAccountBackupRole
    pBackupKeyAlias         = var.pBackupKeyAlias
    pMemberBackupVaultName  = var.pMemberBackupVaultName
    pOrganizationId         = data.aws_organizations_organization.organization.id
  }

  capabilities = var.capabilities
  tags         = module.labels.tags
}

resource "aws_cloudformation_stack_set_instance" "backup_member_account_instance" {
  count          = var.enable_backup_member_account ? 1 : 0
  account_id     = data.aws_caller_identity.current.account_id
  region         = var.region
  stack_set_name = aws_cloudformation_stack_set.backup_member_account[0].name
}

# Central Backup Account StackSet
resource "aws_cloudformation_stack_set" "central_backup_account" {
  count                   = var.enable_central_backup_account ? 1 : 0
  name                    = "central-backup-account"
  template_url            = var.central_backup_account_file
  administration_role_arn = var.administration_role_arn
  execution_role_name     = var.execution_role_name

  parameters = {
    pTagKey1                = var.pTagKey1
    pTagValue1              = var.pTagValue1
    pBackupKeyAlias         = var.pBackupKeyAlias
    pCrossAccountBackupRole = var.pCrossAccountBackupRole
    pCentralBackupVaultName = var.pMemberBackupVaultName
    pOrganizationId         = data.aws_organizations_organization.organization.id
  }

  capabilities = var.capabilities
  tags         = module.labels.tags
}

resource "aws_cloudformation_stack_set_instance" "central_backup_account_instance" {
  count          = var.enable_central_backup_account ? 1 : 0
  account_id     = data.aws_caller_identity.current.account_id
  region         = var.region
  stack_set_name = aws_cloudformation_stack_set.central_backup_account[0].name
}

# Central Backup Organization Account StackSet
resource "aws_cloudformation_stack_set" "central_backup_org_account" {
  count                   = var.enable_central_backup_org_account ? 1 : 0
  name                    = var.inspector_stack_name
  template_url            = var.central_backup_org_account_template_file
  administration_role_arn = var.administration_role_arn
  execution_role_name     = var.execution_role_name

  parameters = {
    pCrossAccountBackupRole   = var.pCrossAccountBackupRole
    pTagKey                   = var.pTagKey1
    pTagValue                 = var.pTagValue1
    pOrgbackupAccounts        = data.aws_caller_identity.current.account_id
    pMemberAccountBackupVault = var.pMemberBackupVaultName
    pCentralBackupVaultArn    = var.pCentralBackupVaultArn
    pBackupTagKey1            = var.pTagKey1
    pBackupTagKey2            = var.pTagKey2
    pBackupTagValue1          = var.pTagValue1
    pBackupTagValue2          = var.pTagValue2
  }

  capabilities = var.capabilities
  tags         = module.labels.tags
}

resource "aws_cloudformation_stack_set_instance" "central_backup_org_account_instance" {
  count          = var.enable_central_backup_org_account ? 1 : 0
  account_id     = data.aws_caller_identity.current.account_id
  region         = var.region
  stack_set_name = aws_cloudformation_stack_set.central_backup_org_account[0].name
}
