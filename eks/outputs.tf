output "cluster_id" {
  value = module.eks.cluster_id
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "eks_oidc_issuer_url" {
  value = module.eks.eks_oidc_issuer_url
}

output "worker_sg_id" {
  value = module.eks.worker_sg_id
}

output "cluster_security_group_id" {
  value = module.eks.cluster_security_group_id
}

output "cluster_autoscaler_role_arn" {
  value = module.helm-charts.cluster_autoscaler_role_arn
}

output "aws_ebs_csi_drvier_role_arn" {
  value = module.helm-charts.aws_ebs_csi_drvier_role_arn
}
