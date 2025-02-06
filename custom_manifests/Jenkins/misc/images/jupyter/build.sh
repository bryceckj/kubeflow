#!/bin/bash

docker build . -t kubeflow:jupyter && \
docker tag kubeflow:jupyter <image_registry>/kubeflow:jupyter && \
docker push <image_registry>/kubeflow:jupyter