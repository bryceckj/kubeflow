locals {
  // Secretname to store cluster information
  cluster_secret_name = "${var.secret_name_prefix}-${var.cluster_name}"

  // EKS Cluster -  Worker Groups 
  workers_group_defaults = {
    asg_desired_capacity   = 1
    asg_max_size           = 40
    asg_min_size           = 1
    ami_id                 = data.aws_ami.aws-k8s-ami.id
    root_volume_size       = 100
    root_encrypted         = true
    root_volume_type       = "gp3"
    root_volume_throughput = 125
    root_iops              = 4000
    key_name               = var.ssh_key_name
    subnets                = local.singleaz_subnet_ids_list
    target_group_arns      = module.alb.target_group_arns
    kubelet_extra_args     = "--read-only-port=10255"

  }

  worker_groups_launch_template = [
    {
      name               = "eks-management-"
      instance_type      = "t3.medium"
      asg_desired_capacity = 1
      asg_min_size         = 1
      asg_max_size         = 2
      iam_role_id        = local.kiam_server_node_role_id
      kubelet_extra_args = "--read-only-port=10255 --max-pods=25 --node-labels=Management=yes --register-with-taints=management=false:NoExecute"
      additional_userdata  = data.template_file.user_data.rendered
      tags = [
        { key = "Worker_type", value = "Management", propagate_at_launch = true }
      ]
    },
    {
      name                     = "worker-1-"
      asg_min_size             = 1
      instance_type            = "m5a.4xlarge"
      suspended_processes      = ["AZRebalance"]
      kubelet_extra_args       = "--read-only-port=10255"
      additional_userdata  = data.template_file.user_data.rendered
      tags = [
        { key = "Worker_type", value = "Worker", propagate_at_launch = true }
      ]
    }
    # {
    #   name                     = "worker-2-"
    #   asg_min_size             = 1
    #   subnets                  = ["${element(local.primary_subnet_ids_list, 1)}"]
    #   instance_type            = "m5a.4xlarge"
    #   suspended_processes      = ["AZRebalance"]
    #   kubelet_extra_args       = "--read-only-port=10255"
    #   tags = [
    #     { key = "Worker_type", value = "Worker", propagate_at_launch = true }
    #   ]
    # },
  ]

  // EKS Cluster - RBAC 
  map_roles = [
    {
      rolearn  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/ROLE-${var.aws_account_name}-AWSADM"
      username = "user-${var.aws_account_name}-awsadm"
      groups   = ["system:masters"]
    },
    {
      rolearn  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/ROLE-${var.aws_account_name}-AWSPWUSR"
      username = "${var.aws_account_name}-awspwusr"
      groups   = ["system:masters"]
    },
    {
      rolearn  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/ROLE-USW2-PROD-API"
      username = "${var.aws_account_name}-api"
      groups   = ["system:masters"]
    },
  ]

  // ALB TargetGroups
  target_groups = [
    {
      name_prefix          = "EKSALB"
      backend_protocol     = "HTTPS"
      backend_port         = 32443
      deregistration_delay = 30
      health_check = {
        interval            = 30
        path                = "/healthz"
        protocol            = "HTTPS"
        healthy_threshold   = 5
        unhealthy_threshold = 3
        timeout             = 6
      }
    },
    {
      name_prefix          = "ISTOGW"
      backend_protocol     = "HTTPS"
      backend_port         = 31390
      deregistration_delay = 30
      health_check = {
        interval            = 30
        path                = "/dex"
        protocol            = "HTTPS"
        healthy_threshold   = 5
        unhealthy_threshold = 3
        timeout             = 6
      }
    },
    {
      name_prefix          = "KNAT"
      backend_protocol     = "HTTP"
      backend_port         = 31080
      deregistration_delay = 30
      health_check = {
        interval            = 10
        path                = "/"
        protocol            = "HTTP"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        matcher             = 404
      }
    },
  ]

  // ALB Listeners
  https_listeners = [
    {
      port               = 443
      protocol           = "HTTPS"
      "certificate_arn"  = local.acm_domain_name_arn
      target_group_index = 1
    },
  ]

  //ALB Listener Rules
  https_listener_rules = [
    {
      https_listener_index = 0
      priority             = 1

      conditions = [{
        host_headers = [local.knative_cname]
      }]

      actions = [{
        type               = "forward"
        target_group_index = 2
      }]
    }
  ]


  knative_cname = "${var.r53_cname_entries[0]}.${var.domain_name}"

  // Make subnet strings to list
  primary_subnet_ids_string    = join(",", data.aws_subnet_ids.node.ids)
  primary_subnet_ids_list      = split(",", local.primary_subnet_ids_string)
  secondary_subnet_ids_string  = join(",", data.aws_subnet_ids.pod.ids)
  secondary_subnet_ids_list    = split(",", local.secondary_subnet_ids_string)
  singleaz_subnet_ids_string   = join(",", data.aws_subnet_ids.single_az_asg.ids)
  singleaz_subnet_ids_list     = split(",", local.singleaz_subnet_ids_string)
  dockerhub_username           = jsondecode(data.aws_secretsmanager_secret_version.helm_chart_secret.secret_string)["dockerhub-username"]
  dockerhub_password           = jsondecode(data.aws_secretsmanager_secret_version.helm_chart_secret.secret_string)["dockerhub-password"]
  datadog_agent_api_key        = jsondecode(data.aws_secretsmanager_secret_version.helm_chart_secret.secret_string)["datadog_agent_api_key"]
  splunk_connect_logging_token = jsondecode(data.aws_secretsmanager_secret_version.helm_chart_secret.secret_string)["splunk_connect_logging_token"]
  splunk_connect_metrics_token = jsondecode(data.aws_secretsmanager_secret_version.helm_chart_secret.secret_string)["splunk_connect_metrics_token"]
}
