locals {

  // Common tags 
  tags = {
    Name                = var.efs_name
    Owner               = "MLOps"
    Environment         = "Sandbox"
    CostCenter          = "1234"
    BusinessUnit        = "Team"
    InfraLocation       = "USW2"
    Application         = "KubeFlow"
    BackupPlan          = "Standard"
  }
}
