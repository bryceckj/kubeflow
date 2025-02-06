## EFS Security group
resource "aws_security_group" "kf-volumes" {
        name        = "${var.efs_name}-efs-sg"
        description = "Allows NFS traffic from instances within the VPC."
        vpc_id      = data.aws_vpc.vpc.id
  ingress {
        from_port = 2049
        to_port   = 2049
        protocol  = "tcp"

        cidr_blocks = [
          "10.0.0.0/8"
        ]
  }
  egress {
        from_port = 2049
        to_port   = 2049
        protocol  = "tcp"
        cidr_blocks = [
          "10.0.0.0/8"
        ]
  }
  tags = local.tags
}

resource "aws_efs_file_system" "kf-volumes" {
    creation_token = "${var.efs_name}-efs"
    encrypted      = true
    tags = local.tags
}

resource "aws_efs_mount_target" "kf-volumes" {
  file_system_id  = aws_efs_file_system.kf-volumes.id
  subnet_id       = element(local.primary_subnet_ids_list, count.index)
  count           = length(local.primary_subnet_ids_list)
  security_groups = [aws_security_group.kf-volumes.id]
}

// Create /volumes directory in the EFS 
// to enable setting NFS provisioner basePath
resource "null_resource" "efs_mount" {
  provisioner "local-exec" {
    command     = <<EOS
mkdir -p $WORKSPACE/efs_mount ;\
sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport ${aws_efs_mount_target.kf-volumes.0.ip_address}:/ $WORKSPACE/efs_mount ;\
sudo mkdir -p $WORKSPACE/efs_mount/volumes ;\
sleep 5
EOS
    interpreter = var.local_exec_interpreter
  }
}

output "kf-volumes" {
  value = aws_efs_file_system.kf-volumes.id
}
output "kf-volumes-dns" {
  value = aws_efs_file_system.kf-volumes.dns_name
}

output "kf-volumes-ip-first" {
  value = aws_efs_mount_target.kf-volumes.0.ip_address
}
