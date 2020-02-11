FROM ubuntu:18.04

MAINTAINER Tiago A. Pimenta <tiagoapimenta@gmail.com>

COPY prefs.js /tmp/prefs.js

COPY start /start

COPY openssl.conf /tmp/openssl.conf

RUN apt-get update && \
  echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | \
    debconf-set-selections && \
  DEBIAN_FRONTEND=noninteractive \
    apt-get install -y --no-install-recommends \
      firefox \
      ttf-mscorefonts-installer \
      wget \
      libnss3-tools \
      openssl && \
  rm -rf /var/lib/apt/lists/* && \
  wget -P /tmp \
    https://cloud.gastecnologia.com.br/bb/downloads/ws/warsaw_setup64.deb && \
  dpkg -P wget && \
  mkdir /tmp/o && \
  dpkg -x /tmp/warsaw_setup64.deb /tmp/o && \
  openssl genrsa -des3 \
    -passout "pass:$(cat /sys/class/dmi/id/modalias)" \
    -out /tmp/o/root_ca.key 4096 && \
  openssl req -new -sha256 -x509 -days 3650 \
    -key /tmp/o/root_ca.key \
    -passin "pass:$(cat /sys/class/dmi/id/modalias)" \
    -out /tmp/o/root_ca.cer \
    -config /tmp/openssl.conf \
    -subj "/CN=Warsaw Personal CA" && \
  openssl genrsa -des3 \
    -passout "pass:$(cat /sys/class/dmi/id/modalias)" \
    -out /tmp/o/localhost.key 4096 && \
  openssl req -new \
    -key /tmp/o/localhost.key \
    -passin "pass:$(cat /sys/class/dmi/id/modalias)" \
    -out /tmp/o/localhost.csr \
    -config /tmp/openssl.conf \
    -subj "/CN=127.0.0.1" && \
  openssl x509 -req -sha256 -days 3650 \
    -in /tmp/o/localhost.csr \
    -CA /tmp/o/root_ca.cer \
    -CAkey /tmp/o/root_ca.key \
    -passin "pass:$(cat /sys/class/dmi/id/modalias)" \
    -set_serial 1 \
    -out /tmp/o/localhost.crt && \
  mkdir -p /usr/local/etc/warsaw && \
  cat /tmp/o/localhost.crt /tmp/o/localhost.key > \
    /usr/local/etc/warsaw/ws.dat && \
  cp \
    /tmp/o/usr/local/etc/warsaw/features.datc \
    /tmp/o/usr/local/etc/warsaw/config.cfgc \
    /usr/local/etc/warsaw && \
  install \
    -m 666 \
    /dev/null /usr/local/etc/warsaw/local.cfg && \
  cp -r \
    /tmp/o/usr/local/lib/warsaw \
    /usr/local/lib/warsaw && \
  mkdir -p /usr/local/bin/warsaw && \
  install \
    -m 755 \
    /tmp/o/usr/local/bin/warsaw/core \
    /usr/local/bin/warsaw/core && \
  cp \
    /tmp/o/root_ca.cer \
    /tmp/.warsaw.cer && \
  rm -rf /tmp/warsaw_setup64.deb /tmp/o /tmp/openssl.conf

ENV DISPLAY :0.0
ENV XAUTHORITY /tmp/.Xauthority
ENV GDK_SYNCHRONIZE 1

ENV PULSE_SERVER unix:/tmp/pulse/native
ENV PULSE_COOKIE /tmp/.pulse-cookie

CMD [ \
      "/start" \
    ]
