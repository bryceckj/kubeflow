module "kf-sg" {
  source                   = "github.com/terraform-aws-modules/terraform-aws-security-group"
  name                     = upper("SG-${var.fsx_name}")
  description              = "Allow ingress AWS resources to FSX"
  vpc_id                   = data.aws_vpc.vpc.id
  tags                     = local.tags
  egress_rules             = ["all-all"]
  use_name_prefix          = true
  ingress_with_self        = local.ingress_with_self
  ingress_with_cidr_blocks = local.ingress_with_cidr_blocks
}
