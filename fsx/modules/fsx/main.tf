resource "aws_fsx_lustre_file_system" "ssd_this" {
  count                           = var.storage_type == "SSD" && var.backend == "NA" ? 1 : 0
  storage_type                    = var.storage_type
  deployment_type                 = var.deployment_type
  per_unit_storage_throughput     = var.per_unit_storage_throughput
  storage_capacity                = var.storage_capacity
  automatic_backup_retention_days = var.automatic_backup_retention_days
  subnet_ids                      = var.subnet_ids
  security_group_ids              = var.security_group_ids
  tags                            = merge({ "Name" = var.fsx_name }, var.tags, )
  depends_on                      = [var.security_group_ids]

}


resource "aws_fsx_lustre_file_system" "hdd_this" {
  count                           = var.storage_type == "HDD" && var.backend == "NA" ? 1 : 0
  storage_type                    = var.storage_type
  deployment_type                 = var.deployment_type
  per_unit_storage_throughput     = var.per_unit_storage_throughput
  storage_capacity                = var.storage_capacity
  automatic_backup_retention_days = var.automatic_backup_retention_days
  subnet_ids                      = var.subnet_ids
  security_group_ids              = var.security_group_ids
  tags                            = merge({ "Name" = var.fsx_name }, var.tags, )
  drive_cache_type                = var.drive_cache_type
}

resource "aws_fsx_lustre_file_system" "ssd_s3_this" {
  count              = var.storage_type == "SSD" && var.backend == "S3" ? 1 : 0
  storage_type       = var.storage_type
  deployment_type    = var.deployment_type
  per_unit_storage_throughput     = var.per_unit_storage_throughput
  storage_capacity   = var.storage_capacity
  subnet_ids         = var.subnet_ids
  security_group_ids = var.security_group_ids
  tags               = merge({ "Name" = var.fsx_name }, var.tags, )
  depends_on         = [var.security_group_ids]
}

resource "aws_fsx_lustre_file_system" "hdd_s3_this" {
  count              = var.storage_type == "HDD" && var.backend == "S3" ? 1 : 0
  storage_type       = var.storage_type
  deployment_type    = var.deployment_type
  per_unit_storage_throughput     = var.per_unit_storage_throughput
  storage_capacity   = var.storage_capacity
  subnet_ids         = var.subnet_ids
  security_group_ids = var.security_group_ids
  tags               = merge({ "Name" = var.fsx_name }, var.tags, )
  drive_cache_type   = var.drive_cache_type
  import_path        = "s3://${var.import_path}"
  export_path        = "s3://${var.export_path}"
  auto_import_policy = var.auto_import_policy
  depends_on         = [var.security_group_ids]
}
