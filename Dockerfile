FROM debian:buster-slim
MAINTAINER    Laur

ENV DEBIAN_FRONTEND=noninteractive

RUN useradd --create-home deluge && \
    mkdir -p /home/deluge/.config/deluge && \
    apt-get -y update && \
    apt-get install -y --no-install-recommends  deluge-gtk && \
    ulimit -n 30000 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  /root/.cache/pip*

USER deluge

WORKDIR /home/deluge

ENTRYPOINT ["/usr/bin/deluge-gtk"]
