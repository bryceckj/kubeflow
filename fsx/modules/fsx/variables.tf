variable "storage_type" {
}

variable "fsx_name" {
}

variable "deployment_type" {
}

variable "per_unit_storage_throughput" {
  default = ""
}

variable "storage_capacity" {
}

variable "automatic_backup_retention_days" {
}

variable "subnet_ids" {
}

variable "tags" {
}

variable "security_group_ids" {
}

variable "drive_cache_type" {
  default = ""
}

variable "import_path" {
  default = null
}

variable "export_path" {
  default = null
}

variable "auto_import_policy" {
  default = ""
}

variable "backend" {
  default = "default"
}
