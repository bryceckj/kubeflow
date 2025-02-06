variable "region" {
  default = "us-west-2"
}
variable "jenkins_role" {
}

variable "s3_bucketname" {
  default = "S3 Bucket name for gstore_scratch fsx"
}
variable "fsx_name" {
  description = "Name for FSX"
}

variable "storage_type" {

}
variable "deployment_type" {

}
variable "per_unit_storage_throughput" {

}
variable "storage_capacity" {

}
variable "backend" {
  default = "S3"
}
variable "drive_cache_type" {
  default = "NA"
}

variable "backup_days" {
  default = "7"
}

variable "fsx_secret_name" {
}
