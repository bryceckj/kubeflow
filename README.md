![Kubeflow](./_static/kf.png)

# Kubeflow <!-- omit from toc -->

## Table of Contents <!-- omit from toc -->

- [Introduction](#introduction)
- [Infrastructure](#infrastructure)
  - [FSx](#fsx)
  - [EFS](#efs)
  - [EKS](#eks)
- [Application](#application)
- [Post-Installation](#post-installation)

---

## Introduction

Kubeflow is a Kubernetes-based application focusing on Machine Learning end-to-end workflow service management and operation. For this Platform, Kubeflow is deployed on an EKS cluster.

This repository covers the infrastructure components of the Kubeflow deployment.
After setting up the infrastructure, proceed to install the Kubeflow application.

## Infrastructure

### FSx

- This component creates the AWS FSx for Lustre file system used for each user's Home Directory in Kubeflow.

### EFS

- This component creates the AWS Elastic File System used to provide additional volumes in Kubeflow.
- Users can use this storage separately from their Home Directories.

### EKS

- This component creates the Kubernetes cluster with AWS EKS.
- The EKS terraform modules include pre-configured EKS, ALB, as well as other components such as Prometheus, Datadog, NFS Provisioner, etc.

## Application

- Fork the kubeflow [manifests](https://github.com/kubeflow/manifests) repository
- Copy [custom_manifests](./custom_manifests/) to forked manifests repo
   - Custom manifests include: 
      - app components such as pytorch-job and tensorflow
      - common components such as env-specific istio configs
      - env-specific deployments
      - [volume configs](../kubeflow/custom_manifests/volumes/)

- Update env-specific fields, especially tfvars files

- Install with kustomize

---

## Post-Installation

Verification

```
aws eks --region <region> update-kubeconfig --name <CLUSTER-NAME>
kubectl get ns
kubectl get pods -A
```

- Make sure pods are in `Running` state



