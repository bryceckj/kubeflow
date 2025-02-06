resource "aws_secretsmanager_secret" "fsx_output" {
  name = var.fsx_secret_name
}

data "template_file" "secret_manager" {
  template = file("${path.module}/templates/secret_manager_tpl.json")
  vars = {
    fsx_name                  = var.fsx_name
    dir_dns_name              = module.aws_fsx_kf_dir.ssd_s3_this_dns_name[0]
    dir_id                    = module.aws_fsx_kf_dir.ssd_s3_this_id[0]
    dir_mount_name            = module.aws_fsx_kf_dir.ssd_s3_this_mount_name[0]
    dir_arn                   = module.aws_fsx_kf_dir.ssd_s3_this_arn[0]
  }
}

resource "aws_secretsmanager_secret_version" "fsx_output" {
  secret_id     = aws_secretsmanager_secret.fsx_output.id
  secret_string = data.template_file.secret_manager.rendered
}
