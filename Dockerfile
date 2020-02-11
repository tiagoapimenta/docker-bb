FROM docker.io/alpine:3.11.3

MAINTAINER Tiago A. Pimenta <tiagoapimenta@gmail.com>

COPY prefs.js /tmp/prefs.js

COPY start /start

RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing firefox libc6-compat msttcorefonts-installer update-ms-fonts && \
	update-ms-fonts && \
	fc-cache -f && \
	apk add --virtual tmp --no-cache dpkg && \
	wget -P /tmp https://cloud.gastecnologia.com.br/bb/downloads/ws/warsaw_setup64.deb
	mkdir /tmp/o && \
	dpkg -x /tmp/warsaw_setup64.deb /tmp/o && \
	... && \
	rm -rf /tmp/warsaw_setup64.deb /tmp/o && \
	apk del tmp

ENV DISPLAY :0.0

ENV XAUTHORITY /tmp/.Xauthority

ENV GDK_SYNCHRONIZE 1

CMD [ \
		"/start" \
	]
