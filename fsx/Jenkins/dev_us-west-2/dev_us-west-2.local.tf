locals {
  // Common tags
  tags = {
    Owner               = "MLOps"
    Environment         = "Sandbox"
    CostCenter          = "1234"
    InfraLocation       = "USW2"
    Application         = "KubeFlow"
    BackupPlan          = "Standard_15"
    BackupRetention     = "Retention_30"
    BackupInterval      = "Daily"
  }

  ingress_with_self = [
    {
      from_port   = 988
      to_port     = 988
      protocol    = 6
      description = "Lustre Fsx rule"
      self        = true
    },
    {
      from_port   = 1021
      to_port     = 1023
      protocol    = 6
      description = "Lustre Fsx rule"
      self        = true
    },
  ]

  ingress_with_cidr_blocks = [
    {
      from_port   = 988
      to_port     = 988
      protocol    = "tcp"
      description = "Lustre Fsx rule"
      cidr_blocks = "100.64.0.0/16"
    },
    {
      from_port   = 1021
      to_port     = 1023
      protocol    = "udp"
      description = "Lustre Fsx rule"
      cidr_blocks = "100.64.0.0/16"
    },
    {
      from_port   = 988
      to_port     = 988
      protocol    = "tcp"
      description = "Lustre Fsx rule"
      cidr_blocks = data.aws_vpc.vpc.cidr_block
    },
    {
      from_port   = 1021
      to_port     = 1023
      protocol    = "udp"
      description = "Lustre Fsx rule"
      cidr_blocks = data.aws_vpc.vpc.cidr_block
    },
  ]
}
