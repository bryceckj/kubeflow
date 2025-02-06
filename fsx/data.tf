data "aws_caller_identity" "current" {}

data "aws_vpc" "vpc" {
  tags = {
    VpcAppTag = "PA-VPC"
  }
}


data "aws_subnet_ids" "primary" {
  vpc_id = data.aws_vpc.vpc.id
  tags = {
    K8S-CNI = "Primary"
  }
}

data "aws_subnet_ids" "secondary" {
  vpc_id = data.aws_vpc.vpc.id
  tags = {
    K8S-CNI = "Secondary"
  }
}

locals {
  // Make subnet strings to list
  primary_subnet_ids_string   = join(",", data.aws_subnet_ids.primary.ids)
  primary_subnet_ids_list     = split(",", local.primary_subnet_ids_string)
  secondary_subnet_ids_string = join(",", data.aws_subnet_ids.secondary.ids)
  secondary_subnet_ids_list   = split(",", local.secondary_subnet_ids_string)
}

