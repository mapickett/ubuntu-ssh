# syntax=docker/dockerfile:1

FROM ubuntu:latest

LABEL org.opencontainers.image.source=https://github.com/mapickett/ubuntu-ssh
LABEL org.opencontainers.image.description="Custom ubuntu image running sshd for use with Containerlab"

COPY rootfs /

RUN apt-get update && \
    apt-get install -y openssh-server iproute2 sudo iputils-ping traceoute net-tools \
    dnsutils curl wget iperf3 iftop tcpdump nmap netcat-openbsd && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN mkdir /var/run/sshd

RUN useradd -ms /bin/bash admin \
    && echo "admin:admin" | chpasswd \
    && echo "admin ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/admin \
    && chmod 0440 /etc/sudoers.d/admin

EXPOSE 22

ENTRYPOINT ["/entrypoint.sh"]