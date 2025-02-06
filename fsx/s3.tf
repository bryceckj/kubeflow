
# ------------------------------------------------------------------------------
# Creates S3 for KF YAML Backup
# ------------------------------------------------------------------------------

resource "aws_s3_bucket" "kubeflow" {
  depends_on    = [module.aws_fsx_kf_dir]
  bucket        = var.s3_bucketname
  force_destroy = true
  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "aws:kms"
      }
    }
  }
  tags = merge({ "Name" = var.s3_bucketname }, local.tags, )
}


resource "aws_fsx_data_repository_association" "kubeflow" {
  depends_on           = [aws_s3_bucket.kubeflow]
  file_system_id       = module.aws_fsx_kf_dir.ssd_s3_this_id[0]
  data_repository_path = "s3://${aws_s3_bucket.kubeflow.id}"
  file_system_path     = "/home/"

  s3 {
    auto_export_policy {
      events = ["NEW", "CHANGED", "DELETED"]
    }
  }
}
