FROM jupyter/scipy-notebook:ubuntu-20.04

USER root
ENV DEBIAN_FRONTEND=noninteractive \
    CONDA_DIR=/opt/conda \
    SHELL=/bin/bash \
    PATH=/opt/conda/bin:$PATH \
    OVERLAY_VERSION="v2.2.0.3"

RUN conda update conda -y && \
    $CONDA_DIR/bin/pip install tensorflow && \
    $CONDA_DIR/bin/pip install kfp && \
    apt-get clean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* && \
    npm cache clean --force && \
    rm -rf $CONDA_DIR/share/jupyter/lab/staging && \
    rm -rf /tmp/*  && \
    conda clean --all -f -y && \
    rm -rf /root/.cache /root/.conda /root/.config

RUN apt-get update -y && \
    apt-get install libxslt-dev libxml2-dev libpam-dev libedit-dev -y && \
    apt-get install -y postgresql && \
    apt-get install -y postgresql-client && \
    apt-get install -y postgresql-server-dev-12 && \
    $CONDA_DIR/bin/pip --no-cache-dir install --upgrade awscli && \
    $CONDA_DIR/bin/pip install boto3 && \
    export AWS_PAGER='' && \
    $CONDA_DIR/bin/pip --no-cache-dir install psycopg2-binary && \
    wget -O /tmp/s6-overlay-amd64.tar.gz https://github.com/just-containers/s6-overlay/releases/download/${OVERLAY_VERSION}/s6-overlay-amd64.tar.gz && \
    tar xzf /tmp/s6-overlay-amd64.tar.gz -C / --exclude="./bin" && \
    tar xzf /tmp/s6-overlay-amd64.tar.gz -C /usr ./bin && \
    apt-get clean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*  && \
    conda clean --all -f -y && \
    rm -rf /root/.cache /root/.conda /root/.config

ENV NB_PREFIX /

CMD ["sh","-c", "jupyter lab --notebook-dir=/home/jovyan --ip=0.0.0.0 --no-browser --allow-root --port=8888 --NotebookApp.token='' --NotebookApp.password='' --NotebookApp.allow_origin='*' --NotebookApp.base_url=${NB_PREFIX} --ServerApp.authenticate_prometheus=False"]
