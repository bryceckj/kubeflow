locals {

  // Common tags 
  tags = {
    Name                = var.efs_name
    Owner               = "MLOps"
    Environment         = "Production"
    CostCenter          = "1234"
    InfraLocation       = "USW2"
    Application         = "KubeFlow"
    BackupPlan          = "Standard"
  }
}
