FROM golang:1.10.3
ENV ZMQ_VERSION 4.2.3

# Install needed packages
ADD ./zeromq-4.2.3 /tmp/zeromq/zeromq-4.2.3
RUN apt-get update && apt-get install -y --fix-missing \
    curl \
    libtool \
    pkg-config \
    build-essential \
    autoconf \
    automake \
    && cd /tmp/zeromq/zeromq-$ZMQ_VERSION/ \
    && ./configure --without-libsodium \
    && make \
    && make install \
    && ldconfig \
    && rm -rf /tmp/zeromq \
    && apt-get purge -y \
    curl \
    libtool \
    pkg-config \
    build-essential \
    autoconf \
    automake \
    && apt-get clean && apt-get autoclean && apt-get -y autoremove

RUN apt-get install -y pkg-config lxc