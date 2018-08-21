#!/usr/bin/env bash

FROM mtgupf/essentia:ubuntu16.04-python3

# Export env settings
ENV TERM=xterm
ENV LANG C.UTF-8

# Add Tini. Tini operates as a process subreaper for jupyter. This prevents
# kernel crashes.
ENV TINI_VERSION v0.18.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/bin/tini
RUN chmod +x /usr/bin/tini

ADD apt-packages.txt /tmp/apt-packages.txt

RUN apt-get update \
    && xargs -a /tmp/apt-packages.txt apt-get install -y \
    && rm -rf /var/lib/apt/lists/*

ADD requirements.txt /tmp/requirements/requirements.txt
RUN pip3 install --no-cache-dir -r /tmp/requirements/requirements.txt

EXPOSE 8888

RUN adduser -q --gecos "" --disabled-password mir

RUN mkdir -p /notebooks

VOLUME /notebooks
WORKDIR /notebooks

USER mir
ADD jupyter_notebook_config.json /home/mir/.jupyter/

USER root

ADD start.sh /usr/local/bin

CMD ["start.sh", "tini", "-s", "--", "jupyter-notebook", "--allow-root", "--no-browser",  "--port",  "8888",  "--ip", "0.0.0.0"]
