FROM debian:buster-slim
MAINTAINER    Laur

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update && \
    apt-get install -y --no-install-recommends  deluge-gtk && \
    ulimit -n 30000 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  /root/.cache/pip*

ENTRYPOINT ["/usr/bin/deluge-gtk"]
