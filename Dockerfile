ARG KASTEN_VERSION=8.0.2
FROM gcr.io/kasten-images/kanister-tools:${KASTEN_VERSION}

ARG HELM_VERSION=3.7.1
ARG KUBECTL_VERSION=1.32.0

USER root

RUN microdnf install -y \
    tar \
    jq \
    nc \
    && microdnf clean all \
    && curl -LO "https://dl.k8s.io/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl" \
    && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl \
    && curl -LO "https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz" \
    && tar -zxvf "helm-v${HELM_VERSION}-linux-amd64.tar.gz" \
    && mv linux-amd64/helm /usr/local/bin/helm \
    && rm -rf linux-amd64 helm-v${HELM_VERSION}-linux-amd64.tar.gz

USER 1001

ENTRYPOINT ["/bin/sh"]