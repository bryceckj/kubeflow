output "ssd_this_dns_name" {
  value = aws_fsx_lustre_file_system.ssd_this.*.dns_name
}

output "ssd_this_id" {
  value = aws_fsx_lustre_file_system.ssd_this.*.id
}

output "ssd_this_mount_name" {
  value = aws_fsx_lustre_file_system.ssd_this.*.mount_name
}

output "ssd_this_arn" {
  value = aws_fsx_lustre_file_system.ssd_this.*.arn
}

output "hdd_this_dns_name" {
  value = aws_fsx_lustre_file_system.hdd_this.*.dns_name
}

output "hdd_this_id" {
  value = aws_fsx_lustre_file_system.hdd_this.*.id
}

output "hdd_this_mount_name" {
  value = aws_fsx_lustre_file_system.hdd_this.*.mount_name
}

output "hdd_this_arn" {
  value = aws_fsx_lustre_file_system.hdd_this.*.arn
}


output "ssd_s3_this_dns_name" {
  value = aws_fsx_lustre_file_system.ssd_s3_this.*.dns_name
}

output "ssd_s3_this_id" {
  value = aws_fsx_lustre_file_system.ssd_s3_this.*.id
}

output "ssd_s3_this_mount_name" {
  value = aws_fsx_lustre_file_system.ssd_s3_this.*.mount_name
}

output "ssd_s3_this_arn" {
  value = aws_fsx_lustre_file_system.ssd_s3_this.*.arn
}


output "hdd_s3_this_dns_name" {
  value = aws_fsx_lustre_file_system.hdd_s3_this.*.dns_name
}

output "hdd_s3_this_id" {
  value = aws_fsx_lustre_file_system.hdd_s3_this.*.id
}

output "hdd_s3_this_mount_name" {
  value = aws_fsx_lustre_file_system.hdd_s3_this.*.mount_name
}

output "hdd_s3_this_arn" {
  value = aws_fsx_lustre_file_system.hdd_s3_this.*.arn
}

