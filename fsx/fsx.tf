module "aws_fsx_kf_dir" {
  source                          = "./modules/fsx"
  fsx_name                        = var.fsx_name
  storage_type                    = var.storage_type
  deployment_type                 = var.deployment_type
  backend                         = var.backend
  per_unit_storage_throughput     = var.per_unit_storage_throughput
  storage_capacity                = var.storage_capacity
  drive_cache_type                = var.drive_cache_type
  automatic_backup_retention_days = var.backup_days
  subnet_ids                      = [local.primary_subnet_ids_list[0]]
  security_group_ids              = [module.kf-sg.security_group_id]
  tags                            = merge({ "Name" = var.fsx_name }, local.tags, )
}
