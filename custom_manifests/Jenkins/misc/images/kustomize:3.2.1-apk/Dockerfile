FROM golang:1.16-alpine

#COPY kustomize /go/kustomize

RUN apk update && \
    apk add g++ make git && \
    git clone --branch kustomize/v3.2.1 https://github.com/kubernetes-sigs/kustomize.git && \
    unset GOPATH && \
    unset GO111MODULES && \
    export PATH=$PATH:/usr/local/go/bin && \
    ln -s ~/go/bin/kustomize /usr/local/go/bin/kustomize && \
    (cd kustomize/kustomize; go install .)