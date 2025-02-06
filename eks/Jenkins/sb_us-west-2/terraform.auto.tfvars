//Common values
region           = "us-west-2"
aws_account_name = "SB"

//EKS Module
cluster_name                          = "KF-USW2-SB"
cluster_version                       = "1.21"
vpc_cni_addon_version                 = "v1.9.1-eksbuild.1"
kube_proxy_addon_version              = "v1.21.2-eksbuild.2"
coredns_addon_version                 = "v1.8.4-eksbuild.1"
ssh_key_name                          = "key-ssh-sb"
cluster_enabled_log_types             = ["scheduler"]
secret_name_prefix                    = "eks-cluster-04"
cluster_endpoint_private_access_cidrs = ["10.0.0.0/8", "100.64.0.0/16"]

//ALB Module
alb_name                     = "ALB-KF-USW2-SB"
asg_workers_sg_ingress_ports = ["32443", "31390", "31080"]
domain_name                  = "<team>.<company>.com"
acm_domain_name              = "*.<team>.<company>.com"
r53_hostname                 = "kf-sb-us"
r53_cname_entries            = ["*.kf.sb.us.aa"]
create_route53_entries       = true
#alb_bucket_logs             = "s3-usw2-sbx-alb-logs"
alb_bucket_logs              = "s3-usw2-elb-logging"

//HELM Chart Modules
//KIAM
install_kiam_server = true
//kube-prometheus-stack
install_kube_premetheus_stack = true
kube_prometheus_domain_name   = "kf.sb.us.aa.<team>.<company>.com"
//Ingress Nginx
install_ingress_nginx = true
//CSI Drivers
install_fsx_csi_driver     = true
install_aws_ebs_csi_driver = true
//Datadog Agent
install_datadog_agent = true
//Chart Versions
cluster_autoscaler_chart_version = "9.16.1"
ingress_nginx_chart_version = "4.0.18"
metrics_server_chart_version = "5.11.3"
fsx_csi_driver_chart_version = "1.4.1"
ebs_csi_driver_chart_version = "2.4.0"
kube_prometheus_chart_version = "33.2.0"
nfs_provisioner_chart_version = "4.0.16"
kiam_server_chart_version = "6.1.2"
splunk_connect_chart_version = "1.4.3"
datadog_agent_chart_version = "6.64.0"
//Splunk Connect 
install_splunk_connect            = true
splunk_connect_logging_index_name = "sbx-k8s-logs"
splunk_connect_metrix_index_name  = "sbx-k8s-metrics"
//NFS Provisioner
install_nfs_provisioner           = true
nfs_provisioner_server_name       = "fs-<ID>.efs.us-west-2.amazonaws.com"
nfs_provisioner_base_path         = "/volumes"
nfs_provisioner_set_as_default_sc = true

//S3 Bucket for Kubeflow
s3_bucket                         = "s3-usw2-sbx-kf-assets-01"

//Common tags
tags = {
  Owner               = "MLOps"
  Environment         = "Sandbox"
  CostCenter          = "1234"
  InfraLocation       = "USW2"
  Application         = "KubeFlow"
  BackupPlan          = "NotApplicable"
  BackupRetention     = "None"
  BackupInterval      = "None"
}
