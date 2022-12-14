FROM ubuntu:focal

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y gnupg apt-transport-https && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys F23C5A6CF475977595C89F51BA6932366A755776 && \
    echo "deb http://ppa.launchpad.net/deadsnakes/ppa/ubuntu focal main" >> /etc/apt/sources.list.d/deadsnakes-ubuntu-ppa-focal.list

RUN apt-get update && \
    apt-get install -y \
    build-essential \
    cmake \
    default-jdk \
    git \
    libcurl4-openssl-dev \
    libfreetype6-dev \
    libfribidi-dev \
    libharfbuzz-dev \
    libjpeg8-dev \
    libkrb5-dev \
    liblapack-dev \
    liblcms2-dev \
    libldap2-dev \
    libmysqlclient-dev \
    libopenblas-dev \
    libopenjp2-7-dev \
    libpq-dev \
    libsasl2-dev \
    libsecp256k1-dev \
    libsndfile1-dev \
    libssl-dev \
    libtiff5-dev \
    libwebp-dev \
    libxcb1-dev \
    nano \
    pkg-config \
    python3.8 \
    python3.8-dev \
    python3.8-tk \
    python3-pip \
    sudo \
    tcl8.6-dev \
    tk8.6-dev \
    unixodbc-dev \
    virtualenv \
    zlib1g-dev

RUN useradd -ms /bin/bash user && \
    echo 'user:password' | chpasswd && \
    usermod -aG sudo user

USER user

WORKDIR /home/user

COPY --chown=user subjects.json ./

COPY --chown=user requirements.txt ./

COPY --chown=user subjects ./subjects

COPY --chown=user pytest-cannier ./pytest-cannier

COPY --chown=user cannier-framework ./cannier-framework

RUN virtualenv --python=/usr/bin/python3.8 venv && \
    venv/bin/pip install -r requirements.txt ./cannier-framework && \
    venv/bin/cannier setup
