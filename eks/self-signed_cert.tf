
resource "tls_private_key" "selfsigned" {
  count     = var.create_self_siged_cert ? 1 : 0
  algorithm = "RSA"
  //ecdsa_curve = "P384"
}

resource "tls_self_signed_cert" "selfsigned" {
  count           = var.create_self_siged_cert ? 1 : 0
  key_algorithm   = "RSA"
  private_key_pem = tls_private_key.selfsigned.*.private_key_pem[0]

  subject {
    common_name  = "*.${var.domain_name}"
    organization = "<company>"
  }
  validity_period_hours = 19800
  dns_names = [
    "*.${var.domain_name}"
  ]
  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
}

resource "aws_acm_certificate" "self-signed-cert" {
  count            = var.create_self_siged_cert ? 1 : 0
  private_key      = element(tls_private_key.selfsigned.*.private_key_pem, 0)
  certificate_body = element(tls_self_signed_cert.selfsigned.*.cert_pem, 0)
  lifecycle {
    create_before_destroy = true
  }
}

