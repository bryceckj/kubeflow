
# ------------------------------------------------------------------------------
# Creates S3 for shared Kubeflow data storage
# ------------------------------------------------------------------------------

resource "aws_s3_bucket" "kf" {
  bucket        = var.s3_bucket
  force_destroy = true
  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "aws:kms"
      }
    }
  }
  tags = merge({ "Name" = var.s3_bucket }, var.tags, )
}

/*
resource "aws_s3_bucket_object" "base_folder" {
    bucket  = aws_s3_bucket.kf.id
    acl     = "private"
    key     =  "/"
    content_type = "application/x-directory"
    kms_key_id = "key_arn_if_used"
}
*/

/*
// Test S3 Role
resource "aws_iam_role" "s3-sa" {
  name                 = "${var.cluster_name}-S3-SA"
  description          = "IAM ROLE For S3 Service Account"
  assume_role_policy   = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Federated": "arn:aws:iam::<AWS_ACCOUNT_ID>:oidc-provider/oidc.eks.us-west-2.amazonaws.com/id/4175E9A94EEAC47951E7611DA67B5040"
            },
            "Action": "sts:AssumeRoleWithWebIdentity",
            "Condition": {
                "StringEquals": {
                    "oidc.eks.us-west-2.amazonaws.com/id/4175E9A94EEAC47951E7611DA67B5040:sub": [
                        "system:serviceaccount:kubeflow:default"
                    ],
                    "oidc.eks.us-west-2.amazonaws.com/id/4175E9A94EEAC47951E7611DA67B5040:aud": "sts.amazonaws.com"
                }
            }
        },
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "sagemaker.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        },
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "codebuild.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy" "s3-sa_policy" {
  name   = "IAM-ROLE-POLICY-S3-SA"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AmazonSageMakerCRUDAccessS3Policy",
            "Effect": "Allow",
            "Action": [
                "s3:*"
            ],
            "Resource": "*"
        },
        {
            "Sid": "AmazonSageMakerReadOnlyAccessKMSPolicy",
            "Effect": "Allow",
            "Action": [
                "kms:DescribeKey",
                "kms:ListAliases"
            ],
            "Resource": "*"
        },
        {
            "Sid": "AmazonSageMakerCRUDAccessECRPolicy",
            "Effect": "Allow",
            "Action": [
                "ecr:Set*",
                "ecr:CompleteLayerUpload",
                "ecr:Batch*",
                "ecr:Upload*",
                "ecr:InitiateLayerUpload",
                "ecr:Put*",
                "ecr:Describe*",
                "ecr:CreateRepository",
                "ecr:Get*",
                "ecr:StartImageScan"
            ],
            "Resource": "*"
        },
        {
            "Sid": "AmazonSageMakerCRUDAccessCloudWatchPolicy",
            "Effect": "Allow",
            "Action": [
                "cloudwatch:Put*",
                "cloudwatch:Get*",
                "cloudwatch:List*",
                "cloudwatch:DescribeAlarms",
                "logs:Put*",
                "logs:Get*",
                "logs:List*",
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:ListLogDeliveries",
                "logs:Describe*",
                "logs:CreateLogDelivery",
                "logs:PutResourcePolicy",
                "logs:UpdateLogDelivery"
            ],
            "Resource": "*"
        }
    ]
}
EOF
  role   = aws_iam_role.s3-sa.id
}

output "s3-sa_role_arn" {
  value = aws_iam_role.s3-sa.arn
}
*/