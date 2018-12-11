FROM ubuntu:18.04

RUN \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential && \
  apt-get install -y software-properties-common && \
  apt-get install -y curl git htop man unzip nano wget && \
  apt-get install -y python-pip libssl-dev


RUN groupadd docker

# http://aptosid.com/index.php?name=PNphpBB2&file=viewtopic&t=2985
RUN export UID=0 \
  && curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | apt-key add - \
  && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable" \
  && apt-get update \
  && apt-get install -y docker-ce
RUN usermod -aG docker root

RUN pip install docker-py
RUN pip install molecule


run mkdir /root/molecule
run mkdir /root/molecule/base

EXPOSE 8080
USER root
WORKDIR /root/molecule/base
