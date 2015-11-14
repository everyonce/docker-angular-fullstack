FROM ubuntu:wily

ENV DEBIAN_FRONTEND noninteractive

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN echo "force-unsafe-io" > /etc/dpkg/dpkg.cfg.d/02apt-speedup
RUN echo "Acquire::http {No-Cache=True;};" > /etc/apt/apt.conf.d/no-cache

RUN echo $'#!/bin/sh\nexit 101' > /usr/sbin/policy-rc.d
RUN chmod +x /usr/sbin/policy-rc.d

RUN \
#  add-apt-repository ppa:fkrull/deadsnakes
  apt-get update && \
  apt-get -y install \
          software-properties-common \
          vim \
          pwgen \
          unzip \
          curl \
          git-core

RUN \
  curl -sL https://deb.nodesource.com/setup_5.x | bash - && \
  apt-get update && apt-get dist-upgrade -y && \
  apt-get install -y nodejs 
RUN \
  apt-get install -y libfreetype6 libfreetype6-dev libfontconfig1 libfontconfig1-dev ruby python build-essential 
RUN npm install -g n
RUN n stable
# RUN npm install -g touch v8-debug
RUN \
  npm install -g yo bower grunt-cli generator-angular-fullstack
VOLUME /data
RUN useradd -ms /bin/bash node
RUN chown -R node:node /data
USER node
WORKDIR /data
ENV HOME /data
EXPOSE 9000

CMD ["yo"]
