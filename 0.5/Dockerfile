FROM krmcbride/debian:jessie
MAINTAINER Kevin McBride <krmcbride.io@gmail.com>

RUN apt-get update && apt-get install -y \
   unzip \
   && rm -rf /var/lib/apt/lists/*

ENV CONSUL_VERSION 0.5.2

RUN set -ex \
  && curl -SLO "https://dl.bintray.com/mitchellh/consul/${CONSUL_VERSION}_linux_amd64.zip" \
  && curl -SLO "https://dl.bintray.com/mitchellh/consul/${CONSUL_VERSION}_web_ui.zip" \
  && curl -SLO "https://dl.bintray.com/mitchellh/consul/${CONSUL_VERSION}_SHA256SUMS" \
  && grep ${CONSUL_VERSION}_linux_amd64.zip ${CONSUL_VERSION}_SHA256SUMS | shasum -c \
  && grep ${CONSUL_VERSION}_web_ui.zip ${CONSUL_VERSION}_SHA256SUMS | shasum -c \
  && unzip ${CONSUL_VERSION}_linux_amd64.zip -d /usr/local/bin/ \
  && unzip ${CONSUL_VERSION}_web_ui.zip -d /var/www/ \
  && rm ${CONSUL_VERSION}_linux_amd64.zip \
  && rm ${CONSUL_VERSION}_web_ui.zip \
  && rm ${CONSUL_VERSION}_SHA256SUMS

RUN mkdir /etc/consul
RUN mkdir /etc/consul/conf.d
COPY consul.json /etc/consul/

COPY check-http /usr/local/bin/
COPY check-cmd /usr/local/bin/
COPY watch-handler /usr/local/bin/

EXPOSE 8300 8301 8301/udp 8302 8302/udp 8400 8500 8600 8600/udp

# Prevent registrator from registering Consul with itself
ENV SERVICE_IGNORE yes

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
