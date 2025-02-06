// IAM ROLE for KIAM SERVER Worker NODE
resource "aws_iam_role" "kiam_server_node" {
  name_prefix        = "KIAM-NODE-${var.cluster_name}"
  description        = "Role for the Kiam Server instance profile"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": { "Service": "ec2.amazonaws.com"},
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

// IAM Role Policy for kiam_server worker node
resource "aws_iam_role_policy" "kiam_server_node" {
  name   = "POLICY-KIAM-SERVER-NODE-${var.cluster_name}"
  role   = aws_iam_role.kiam_server_node.name
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "sts:AssumeRole"
            ],
            "Resource": "${aws_iam_role.kiam_server.arn}"
        }
    ]
}
EOF
}

// Policy attachments for the KIAM-Server Worker Node
resource "aws_iam_role_policy_attachment" "workernode" {
  role       = aws_iam_role.kiam_server_node.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "ecr_readonly" {
  role       = aws_iam_role.kiam_server_node.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_role_policy_attachment" "eks_cni" {
  role       = aws_iam_role.kiam_server_node.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "ssm_role" {
  role       = aws_iam_role.kiam_server_node.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}


// IAM Instance Profile for KIAM server Node
resource "aws_iam_instance_profile" "kiam_server_node" {
  name = "ROLE-KIAM-SERVER-NODE-${var.cluster_name}"
  role = aws_iam_role.kiam_server_node.name
}


// IAM Role for KIAM Server POD
resource "aws_iam_role" "kiam_server" {
  name_prefix        = "KIAM-SERVER-${var.cluster_name}"
  description        = "Role for the Kiam Server process assumes"
  assume_role_policy = <<EOF
{
    "Version":  "2008-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        },
        {
            "Effect": "Allow",
            "Principal": {
                "AWS": "${aws_iam_role.kiam_server_node.arn}"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
EOF
}

// IAM Policy for KIAM Server Pod
resource "aws_iam_role_policy" "kiam_server_policy" {
  name   = "POLICY-KIAM-SERVER-${var.cluster_name}"
  role   = aws_iam_role.kiam_server.name
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "sts:AssumeRole"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}


locals {
  kiam_server_node_role_id = aws_iam_role.kiam_server_node.id
}

// Roles output
output "kiam_server_node_role_id" {
  value = aws_iam_role.kiam_server_node.id
}

output "kiam_server_node_role_arn" {
  value = aws_iam_role.kiam_server_node.arn
}