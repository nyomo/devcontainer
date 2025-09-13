FROM debian:bookworm

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update

RUN apt-get install -y --no-install-recommends \
    sudo \
    locales \
    ca-certificates \
    curl \
    git \
    python3 \
    python3-venv

RUN echo "ja_JP.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen ja_JP.UTF-8 && \
    dpkg-reconfigure locales && \
    /usr/sbin/update-locale LANG=ja_JP.UTF-8
ENV LANG=ja_JP.UTF-8
ENV LANGUAGE=ja_JP:ja
ENV LC_ALL=ja_JP.UTF-8

# set appuser
RUN groupmod -n macusers dialout
RUN groupadd -g 1100 appgroup && \
    useradd -u 1100 -G appgroup -s /bin/bash -N -M appuser
RUN usermod -aG macusers root
RUN usermod -aG macusers appuser

RUN mkdir /home/appuser
RUN chown -R appuser:appgroup /home/appuser
RUN echo "%appgroup ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers.d/appgroup

WORKDIR /workdir
USER appuser

# Python
RUN mkdir /home/appuser/python3
RUN python3 -m venv /home/appuser/python3/
RUN echo 'export PATH=/home/appuser/python3/bin:$PATH' > /home/appuser/.bashrc
COPY requirements.txt /home/appuser
RUN /home/appuser/python3/bin/pip install -r /home/appuser/requirements.txt
ENV PATH=/home/appuser/python3/bin:${PATH}

# node.js

RUN curl -fsSL https://deb.nodesource.com/setup_20.x | sudo bash - && sudo apt-get install -y nodejs

RUN mkdir /home/appuser/node_modules
RUN sudo chown -R appuser:appgroup /home/appuser

# install codex
#RUN npm install --prefix /home/appuser @openai/codex
RUN npm install --prefix /home/appuser @openai/codex --no-package-lock --no-save
ENV PATH=/home/appuser/node_modules/.bin:${PATH}


RUN echo 'export PATH='${PATH}':$PATH' >> /home/appuser/.bashrc
WORKDIR /workdir/app