//Common variables
variable "region" {
  default = "us-west-2"
}

#variable "node_subnets" {}
#variable "pod_subnets" {}

// EKS Cluster variables
variable "aws_account_name" {}
variable "cluster_name" {}
variable "cluster_version" {}
variable "cluster_enabled_log_types" {}
variable "vpc_cni_addon_version" {}
variable "kube_proxy_addon_version" {}
variable "coredns_addon_version" {}
variable "ssh_key_name" {}
variable "secret_name_prefix" {
  description = "The prefix for the secretmanager secret entry that would be created by the eks module"
}
variable "cluster_endpoint_private_access_cidrs" {}

// NFS Provisioner
variable "install_nfs_provisioner" {}
variable "nfs_provisioner_server_name" {}
variable "nfs_provisioner_base_path" {}
variable "nfs_provisioner_set_as_default_sc" {}

// ALB Module Variables
variable "alb_name" {}
variable "shared_r53_role" {
  description = "ARN of the Shared Services account R53 Role"
  default     = "arn:aws:iam::<AWS_ACCOUNT_ID>:role/ROLE-USW2-ROUTE53"
}
variable "alb_bucket_logs" {
	default = "s3-usw2-elb-logging"
}

variable "asg_workers_sg_ingress_ports" {}
variable "create_self_siged_cert" {
  default = false
}
variable "domain_name" {
  description = "Domain name for creating Route53 entries"
}
variable "acm_domain_name" {}
variable "create_route53_entries" {
  default = true
}
variable "r53_hostname" {}
variable "r53_cname_entries" {
  description = "List of cname entries to be created for ALB"
}

// Helm Chart variables
variable "helm_chart_secret_id" {
  default = "HELM-CHART-SECRETS"
}

variable "install_cluster_autoscaler" {
  default = true
}
//Prometheus stack
variable "install_kube_premetheus_stack" {
  default = true
}
variable "kube_prometheus_domain_name" {
  description = "Domain name for grafana, alertmanager and prometheus"
}

variable "install_ingress_nginx" {
  default = false
}
variable "install_fsx_csi_driver" {}
variable "install_aws_ebs_csi_driver" {
  default = false
}
variable "install_external_secrets" {
  default = false
}
variable "install_datadog_agent" {
  default = true
}
variable "cluster_autoscaler_chart_version" {
  description = "Cluster Autoscaler Chart Version"
}
variable "ingress_nginx_chart_version" {
  description = "Ingress Nginx Chart Version"
}
variable "metrics_server_chart_version" {
  description = "Metrics Server Chart Version"
}
variable "fsx_csi_driver_chart_version" {
  description = "FSX CSI Driver Chart Version"
}
variable "ebs_csi_driver_chart_version" {
  description = "EBS CSI Driver Chart Version"
}
variable "kube_prometheus_chart_version" {
  description = "Kube Prometheus Stack Chart Version"
}
variable "nfs_provisioner_chart_version" {
  description = "NFS Provisioner Chart Version"
}
variable "kiam_server_chart_version" {
  description = "Kiam Server Chart Version"
}
variable "splunk_connect_chart_version" {
  description = "Splunk Connect Chart Version"
}
variable "datadog_agent_chart_version" {
  description = "Datadog Agent Chart Version"
}


//Splunk Connect
variable "install_splunk_connect" {
  default = true
}
variable "splunk_connect_logging_index_name" {}
variable "splunk_connect_metrix_index_name" {}

//KIAM HELM Chart Variables
variable "install_kiam_server" {
  default = true
}

//S3 bucket
variable "s3_bucket"{
  description = "Name of S3 bucket used for Kubeflow products"
}

//common tags
variable "tags" {
  default = {
    Owner               = "MLOps"
    Environment         = "Sandbox"
    CostCenter          = "1234"
    InfraLocation       = "USW2"
    BackupPlan          = "NotApplicable"
    BackupRetention     = "None"
    BackupInterval      = "None"
  }
}
