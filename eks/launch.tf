module "eks" {
  source                                = "git::ssh://git@<CUSTOM_TF_MODULES_REPO>/eks?ref=v0.1.1"
  region                                = var.region
  cluster_name                          = var.cluster_name
  cluster_version                       = var.cluster_version
  vpc_cni_addon_version                 = var.vpc_cni_addon_version
  kube_proxy_addon_version              = var.kube_proxy_addon_version
  coredns_addon_version                 = var.coredns_addon_version
  vpc_id                                = data.aws_vpc.vpc.id
  node_subnets                          = data.aws_subnet_ids.node.ids
  pod_subnets                           = data.aws_subnet_ids.pod.ids
  ssh_key_name                          = var.ssh_key_name
  cluster_enabled_log_types             = var.cluster_enabled_log_types
  cluster_secret_name                   = local.cluster_secret_name
  workers_group_defaults                = local.workers_group_defaults
  worker_groups_launch_template         = local.worker_groups_launch_template
  map_roles                             = local.map_roles
  tags                                  = var.tags
  cluster_endpoint_private_access_cidrs = var.cluster_endpoint_private_access_cidrs
}

module "alb" {
  source                       = "git::ssh://git@<CUSTOM_TF_MODULES_REPO>/eks-alb.git?ref=v0.1.2"
  create_route53_entries       = var.create_route53_entries
  alb_name                     = var.alb_name
  vpc_id                       = data.aws_vpc.vpc.id
  subnets                      = data.aws_subnet_ids.node.ids
  worker_security_group_id     = module.eks.worker_sg_id
  alb_https_listeners          = local.https_listeners
  alb_target_groups            = local.target_groups
  alb_bucket_logs              = var.alb_bucket_logs
  access_logs                  = { 
    bucket  = var.alb_bucket_logs
    }
  asg_workers_sg_ingress_ports = var.asg_workers_sg_ingress_ports
  https_listener_rules         = local.https_listener_rules
  aws_route53_zone             = "<team>.<company>.com"
  r53_hostname                 = var.r53_hostname
  r53_domain_name              = var.domain_name
  r53_cname_entries            = var.r53_cname_entries
  tags                         = var.tags
  providers = {
    aws         = aws
    aws.route53 = aws.route53
  }
}

module "helm-charts" {
  source                     = "git::ssh://git@<CUSTOM_TF_MODULES_REPO>/eks-helm.git?ref=v0.1.4"
  depends_on                 = [module.eks]
  cluster_name               = var.cluster_name
  install_cluster_autoscaler = var.install_cluster_autoscaler
  dockerhub_username         = local.dockerhub_username
  dockerhub_password         = local.dockerhub_password
  eks_oidc_issuer_url        = module.eks.eks_oidc_issuer_url
  install_ingress_nginx      = var.install_ingress_nginx
  install_aws_ebs_csi_driver = var.install_aws_ebs_csi_driver
  install_fsx_csi_driver     = var.install_fsx_csi_driver
  install_external_secrets   = var.install_external_secrets
  //nfs-subdir-external-provisioner
  install_nfs_provisioner           = var.install_nfs_provisioner
  nfs_provisioner_server_name       = var.nfs_provisioner_server_name
  nfs_provisioner_base_path         = var.nfs_provisioner_base_path
  nfs_provisioner_set_as_default_sc = var.nfs_provisioner_set_as_default_sc
  //datadog
  install_datadog_agent = var.install_datadog_agent
  datadog_agent_api_key = local.datadog_agent_api_key
  // chart versions
  cluster_autoscaler_chart_version = var.cluster_autoscaler_chart_version
  ingress_nginx_chart_version = var.ingress_nginx_chart_version
  metrics_server_chart_version = var.metrics_server_chart_version
  fsx_csi_driver_chart_version = var.fsx_csi_driver_chart_version
  ebs_csi_driver_chart_version = var.ebs_csi_driver_chart_version
  kube_prometheus_chart_version = var.kube_prometheus_chart_version
  nfs_provisioner_chart_version = var.nfs_provisioner_chart_version
  kiam_server_chart_version = var.kiam_server_chart_version
  splunk_connect_chart_version = var.splunk_connect_chart_version
  datadog_agent_chart_version = var.datadog_agent_chart_version
  //kube-prometheus-stack
  kube_prometheus_domain_name   = var.kube_prometheus_domain_name
  install_kube_premetheus_stack = var.install_kube_premetheus_stack
  //splunk connect
  install_splunk_connect            = var.install_splunk_connect
  splunk_connect_logging_index_name = var.splunk_connect_logging_index_name
  splunk_connect_metrix_index_name  = var.splunk_connect_metrix_index_name
  splunk_connect_logging_token      = local.splunk_connect_logging_token
  splunk_connect_metrics_token      = local.splunk_connect_metrics_token
  //KIAM details
  install_kiam_server  = var.install_kiam_server
  kiam_server_role_arn = aws_iam_role.kiam_server.arn
}

/*
resource "aws_eks_cluster" "this" {
  name                      = "KF-EUC1-2-PRD"
  role_arn                  = "arn:aws:iam::<AWS_ACCOUNT_ID>:role/<ROLE_NAME>"
      
    vpc_config {
          cluster_security_group_id = "<SG_ID>"
          endpoint_private_access   = true
          endpoint_public_access    = false
          public_access_cidrs       = [
              "0.0.0.0/0",
            ]
          security_group_ids        = [
              "<SG_ID>>",
            ]
          subnet_ids                = [
              "subnet-<ID>",
              "subnet-<ID>",
            ]
          vpc_id                    = "vpc-<ID>"
    }

    timeouts {
          create = "30m"
          delete = "15m"
          update = "60m"
    }

}
*/