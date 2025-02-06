resource "aws_secretsmanager_secret" "efs_output" {
  name = var.efs_secret_name
}

data "template_file" "secret_manager" {
  template = file("${path.module}/templates/secret_manager_tpl.json")
  vars = {
    efs_name       = var.efs_name
    efs_id         = aws_efs_file_system.kf-volumes.id
    efs_dns        = aws_efs_file_system.kf-volumes.dns_name
  }
}

resource "aws_secretsmanager_secret_version" "efs_output" {
  secret_id     = aws_secretsmanager_secret.efs_output.id
  secret_string = data.template_file.secret_manager.rendered
}
