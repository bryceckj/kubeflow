// Get details about current AWS account
data "aws_caller_identity" "current" {}

//Find out the VPC ID where EKS would be deployed
data "aws_vpc" "vpc" {
  tags = {
    VpcAppTag = "PA-VPC"
  }
}

// findout the worker nodes network (10.x.x.x) subnet IDs
data "aws_subnet_ids" "node" {
  vpc_id = data.aws_vpc.vpc.id
  tags = {
    K8S-CNI = "Primary"
  }
}

// findout the pod network (100.64.x.x) subnet IDs
data "aws_subnet_ids" "pod" {
  vpc_id = data.aws_vpc.vpc.id
  tags = {
    K8S-CNI = "Secondary"
  }
}

data "aws_subnet_ids" "single_az_asg" {
  vpc_id = data.aws_vpc.vpc.id
    tags = {
    FSXFileSystem = "Yes"
  }
}

// AMI for worker nodes
data "aws_ami" "aws-k8s-ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amazon-eks-node-1.21*"]
  }

  owners = ["<AWS_ACCOUNT_ID>"]
}

// Get the information about the created EKS cluster
data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

// Get the Authentication information for EKS cluster used for terraform client
data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

data "aws_secretsmanager_secret_version" "helm_chart_secret" {
  secret_id = var.helm_chart_secret_id
}

// ACM Certificates
data "aws_acm_certificate" "this" {
  count  = var.create_self_siged_cert ? 0 : 1
  domain = var.acm_domain_name
}

locals {
  acm_domain_name_arn = var.create_self_siged_cert ? aws_acm_certificate.self-signed-cert[0].arn : data.aws_acm_certificate.this[0].arn

}

data "aws_acm_certificate" "<team>" {
  domain = "*.<team>.<company>.com"
}

data "template_file" "user_data" {
  template = file("${path.module}/Templates/user_data.tpl")
}