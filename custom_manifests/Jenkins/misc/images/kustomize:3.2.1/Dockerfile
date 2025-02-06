FROM golang:1

RUN git clone --branch kustomize/v3.2.1 https://github.com/kubernetes-sigs/kustomize.git && \
    unset GOPATH && \
    unset GO111MODULES && \
    export PATH=$PATH:/usr/local/go/bin && \
    ln -s ~/go/bin/kustomize /usr/local/go/bin/kustomize && \
    (cd kustomize/kustomize; go install .)

RUN apt update && \
    apt install -y curl unzip git vim jq less && \
    ## Install awscli v2
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    ## Install kubectl
    curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl" && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin/kubectl && \
    ## Cleanup ##
    apt-get clean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["sh"]