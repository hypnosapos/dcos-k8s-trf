FROM debian:stretch-slim

ENV NAMESPACE=kubeflow
ENV APP_NAME="dcos-kubeflow"
ENV VERSION="v0.1.2"
ENV GIT_VERSION="master"
ENV TERRAFORM_VERSION="0.11.7"
ENV GITHUB_TOKEN=""

RUN apt-get update \
    && apt-get install -y gcc make curl jq unzip git

RUN git clone -b $GIT_VERSION https://github.com/mesosphere/dcos-kubernetes-quickstart.git

WORKDIR /dcos-kubernetes-quickstart

RUN curl -L https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -o tarraform.zip \
 && unzip tarraform.zip && chmod +x terraform && mv terraform /usr/local/bin/

ADD ./*.sh ./

CMD ./cmd.sh