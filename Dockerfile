FROM ubuntu:18.04
MAINTAINER Indrek Kalluste <indreek@gmail.com>

ARG USER=aws
ARG HOME=/home/$USER

RUN useradd --shell /bin/bash -d $HOME --create-home $USER

RUN apt-get update && apt-get install curl unzip -y

# Install kubectl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl \
	&& mv kubectl /usr/local/bin \
	&& chmod +x /usr/local/bin/kubectl

# Install AWS cli V2
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install \
    && aws --version

COPY run.sh /
RUN chmod +x /run.sh

USER $USER
