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
RUN pip3 install -r /tmp/requirements/requirements.txt

EXPOSE 8888
RUN mkdir -p /home/ds/notebooks
ENV HOME=/home/ds
ENV SHELL=/bin/bash
ENV USER=ds
VOLUME /home/ds/notebooks
WORKDIR /home/ds/notebooks


ADD jupyter_notebook_config.json /home/ds/.jupyter/
CMD ["tini", "--", "jupyter-notebook", "--allow-root", "--no-browser",  "--port",  "8888",  "--ip", "0.0.0.0"]
