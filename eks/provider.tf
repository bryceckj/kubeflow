provider "aws" {
  region = var.region
}

// provider for creating Route53 role
provider "aws" {
  region = var.region
  alias  = "route53"

  assume_role {
    role_arn = var.shared_r53_role
  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
      configuration_aliases = [aws, aws.route53]
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.4.1"
    }
  }
}

// Kubernetes provider
provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

// Helm provider. Required only for installing helm charts module
provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.cluster.token
  }
}
