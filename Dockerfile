#!/usr/bin/env bash

FROM mtgupf/essentia:python3

# Export env settings
ENV TERM=xterm
ENV LANG C.UTF-8

RUN apt-get update -y && apt-get install build-essential -y

ADD apt-packages.txt /tmp/apt-packages.txt
RUN xargs -a /tmp/apt-packages.txt apt-get install -y

ADD requirements.txt /tmp/requirements/requirements.txt

RUN pip3 install -r /tmp/requirements/pre-requirements.txt
RUN pip3 install -r /tmp/requirements/requirements.txt

EXPOSE 8888
RUN mkdir -p /home/ds/notebooks
ENV HOME=/home/ds
ENV SHELL=/bin/bash
ENV USER=ds
VOLUME /home/ds/notebooks
WORKDIR /home/ds/notebooks

CMD ["jupyter-notebook", "--allow-root", "--no-browser",  "--port",  "8888",  "--ip=0.0.0.0"]
