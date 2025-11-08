FROM --platform=linux/amd64 debian:trixie

ENV DEBIAN_FRONTEND=noninteractive
RUN sed -i 's#deb\.debian\.org\/debian$#ftp.jp.debian.org\/debian#' /etc/apt/sources.list.d/debian.sources 
RUN apt-get update

RUN apt-get install -y --no-install-recommends \
    locales \
    ca-certificates \
    git

RUN echo "ja_JP.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen ja_JP.UTF-8 && \
    dpkg-reconfigure locales && \
    /usr/sbin/update-locale LANG=ja_JP.UTF-8
ENV LANG=ja_JP.UTF-8
ENV LANGUAGE=ja_JP:ja
ENV LC_ALL=ja_JP.UTF-8
