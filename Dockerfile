# docker build --rm --no-cache -t myubuntu:latest .
# docker run --rm -it myubuntu /usr/bin/bash
# ip address add 10.0.0.2/24 dev eth1

FROM ubuntu:latest

COPY rootfs /

RUN apt-get update \
    && apt-get install -y openssh-server iproute2 sudo
    
RUN mkdir /var/run/sshd

RUN useradd -ms /bin/bash admin \
    && echo "admin:admin" | chpasswd \
    && echo "admin ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/admin \
    && chmod 0440 /etc/sudoers.d/admin

EXPOSE 22

ENTRYPOINT ["/entrypoint.sh"]