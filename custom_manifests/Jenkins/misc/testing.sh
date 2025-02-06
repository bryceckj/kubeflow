#!/bin/bash
# export KUSTOMIZE_COMMAND="docker run --rm -v `pwd`:/app -w /app -e AWS_SHARED_CREDENTIALS_FILE=/app/aws_credentials line/kubectl-kustomize:1.16.1-3.2.0"
# for i in `cat resources.yaml`; do echo $i; $KUSTOMIZE_COMMAND -c 'kustomize build $i' | kubectl apply -f -; done


export WORKSPACE=/home/ec2-user/workspace/MLOps/Kubeflow/UAT/Kubeflow
export AWS_ROLE_ARN=arn:aws:iam::<AWS_ACCOUNT_ID>:role/<ROLE_NAME>
aws sts assume-role --role-session-name Jenkins01 --role-arn  ${AWS_ROLE_ARN} > awscre
AWS_DEFAULT_REGION=<REGION>
cat > ${WORKSPACE}/aws_credentials <<EOF
[default]
output = json
region = $AWS_DEFAULT_REGION
aws_access_key_id = $(jq -r .Credentials.AccessKeyId awscre)
aws_secret_access_key = $(jq -r .Credentials.SecretAccessKey awscre)
aws_session_token = $(jq -r .Credentials.SessionToken awscre)
EOF
export AWS_SHARED_CREDENTIALS_FILE=${WORKSPACE}/aws_credentials

#export KUBECONFIG_NAME=KF-USW2-DEV
cp /home/ec2-user/.kube/config ${WORKSPACE}/kubeconfig
export KUSTOMIZE_COMMAND="docker run --rm -v ${WORKSPACE}:/test -w /test -e AWS_SHARED_CREDENTIALS_FILE=/test/aws_credentials -e KUBECONFIG=/test/kubeconfig <image_registry>/kustomize:3.2.1"
$KUSTOMIZE_COMMAND -c "kustomize build common/cert-manager/cert-manager/base/ | kubectl apply -f -"

$KUSTOMIZE_COMMAND -c "kustomize build example | kubectl apply -f -"

# fsx yaml details
dnsname: <FSX_DNS>
mountname: <FSX_MOUNT_NAME>
volumeHandle: <FSX_ID>:/admin-pv/