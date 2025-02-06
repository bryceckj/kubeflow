output "dir_dns_name" {
  value = module.aws_fsx_kf_dir.ssd_s3_this_dns_name
}

output "dir_id" {
  value = module.aws_fsx_kf_dir.ssd_s3_this_id
}

output "dir_mount_name" {
  value = module.aws_fsx_kf_dir.ssd_s3_this_mount_name
}

output "dir_arn" {
  value = module.aws_fsx_kf_dir.ssd_s3_this_arn
}
