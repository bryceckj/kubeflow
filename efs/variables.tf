variable "region" {
  default = "us-west-2"
}

variable "efs_name" {
  description = "Name of Kubeflow EFS"
}

variable "jenkins_role" {
  description = "ARN of the ROLE which Jenkins server will assume"
}

variable "efs_secret_name" {
  description = "Name of the AWS Secret containing EFS outputs"
}

variable "local_exec_interpreter" {
  description = "Command to run for local-exec resources. Must be a shell-style interpreter"
  type        = list(string)
  default     = ["/bin/bash", "-c"]
}