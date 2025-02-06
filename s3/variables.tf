//S3 bucket
variable "s3_bucket"{
  description = "Name of S3 bucket used for Kubeflow products"
}

//common tags
variable "tags" {
  default = {
    Owner               = "MLOps"
    Environment         = "Sandbox"
    CostCenter          = "1234"
    InfraLocation       = "USW2"
    ServiceLevel        = "Standard-8X5"
    BackupPlan          = "NotApplicable"
    BackupRetention     = "None"
    BackupInterval      = "None"
  }
}