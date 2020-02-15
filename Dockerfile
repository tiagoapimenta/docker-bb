FROM ubuntu:18.04

COPY prefs.js start openssl.conf /tmp/

RUN apt-get update && \
  apt-get install -y --no-install-recommends wget openssl && \
  wget -P /tmp --no-check-certificate \
    https://cloud.gastecnologia.com.br/bb/downloads/ws/warsaw_setup64.deb && \
  mkdir /tmp/o /fs && \
  install -o root -g root -m 755 /tmp/start /fs/start && \
  install -o root -g root -m 1777 -d /fs/tmp && \
  install -o root -g root -m 644 /tmp/prefs.js /fs/tmp/.prefs.js && \
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
  for dir in \
    usr \
    usr/local \
    usr/local/etc \
    usr/local/etc/warsaw \
    usr/local/lib \
    usr/local/bin \
    usr/local/bin/warsaw; do \
    install -o root -g root -m 755 -d "/fs/$dir"; \
  done && \
  cat /tmp/o/localhost.crt /tmp/o/localhost.key > \
    /fs/usr/local/etc/warsaw/ws.dat && \
  cp \
    /tmp/o/usr/local/etc/warsaw/features.datc \
    /tmp/o/usr/local/etc/warsaw/config.cfgc \
    /fs/usr/local/etc/warsaw && \
  install \
    -m 666 \
    /dev/null /fs/usr/local/etc/warsaw/local.cfg && \
  cp -r \
    /tmp/o/usr/local/lib/warsaw \
    /fs/usr/local/lib/warsaw && \
  install \
    -m 755 \
    /tmp/o/usr/local/bin/warsaw/core \
    /fs/usr/local/bin/warsaw/core && \
  cp \
    /tmp/o/root_ca.cer \
    /fs/tmp/.warsaw.cer && \
  rm -rf /tmp/warsaw_setup64.deb /tmp/o

FROM ubuntu:18.04

MAINTAINER Tiago A. Pimenta <tiagoapimenta@gmail.com>

COPY --from=0 /fs /

RUN apt-get update && \
  echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | \
    debconf-set-selections && \
  DEBIAN_FRONTEND=noninteractive \
    apt-get install -y --no-install-recommends \
      firefox \
      ttf-mscorefonts-installer \
      libgtk2.0-0 \
      libnss3-tools && \
  rm -rf /var/lib/apt/lists/*

ENV DISPLAY :0.0
ENV XAUTHORITY /tmp/.Xauthority
ENV GDK_SYNCHRONIZE 1

CMD [ \
      "/start" \
    ]
