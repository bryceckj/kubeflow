FROM jupyter/scipy-notebook:ubuntu-20.04

USER root
ENV DEBIAN_FRONTEND=noninteractive \
    CONDA_DIR=/opt/conda \
    SHELL=/bin/bash \
    PATH=/opt/conda/bin:$PATH \
    OVERLAY_VERSION="v2.2.0.3"

RUN conda update conda -y && \
    # Install Tensorflow
    $CONDA_DIR/bin/pip install tensorflow && \
    # Install Kubeflow Pipelines
    $CONDA_DIR/bin/pip install kfp && \
    # Install Sagemaker
    $CONDA_DIR/bin/pip install sagemaker && \
    # Install AWS
    $CONDA_DIR/bin/pip --no-cache-dir install --upgrade awscli && \
    $CONDA_DIR/bin/pip install boto3 && \
    export AWS_PAGER='' && \
    # Install S6 overlay
    wget -O /tmp/s6-overlay-amd64.tar.gz https://github.com/just-containers/s6-overlay/releases/download/${OVERLAY_VERSION}/s6-overlay-amd64.tar.gz && \
    tar xzf /tmp/s6-overlay-amd64.tar.gz -C / --exclude="./bin" && \
    tar xzf /tmp/s6-overlay-amd64.tar.gz -C /usr ./bin && \
    # Cleanup
    apt-get clean && \
    apt-get autoremove -y && \
    npm cache clean --force && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf $CONDA_DIR/share/jupyter/lab/staging && \
    rm -rf /tmp/*  && \
    conda clean --all -f -y && \
    rm -rf /root/.cache /root/.conda /root/.config

RUN apt-get update -y && \
    # Install basic pkgs
    apt-get install -y curl && \
    # Install psycopg2 libraries
    apt-get install libxslt-dev libxml2-dev libpam-dev libedit-dev -y && \
    apt-get install -y postgresql && \
    apt-get install -y postgresql-client && \
    apt-get install -y postgresql-server-dev-12 && \
    $CONDA_DIR/bin/pip --no-cache-dir install psycopg2-binary && \
    # Configure jovyan group permissions
    echo "iamrole:x:1337:jovyan" >> /etc/group && \
    # Cleanup
    apt-get clean && \
    apt-get autoremove -y && \
    npm cache clean --force && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf $CONDA_DIR/share/jupyter/lab/staging && \
    rm -rf /tmp/*  && \
    conda clean --all -f -y && \
    rm -rf /root/.cache /root/.conda /root/.config

ENV NB_PREFIX /

COPY root /
CMD ["/init"]