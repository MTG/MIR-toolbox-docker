#!/bin/bash
# Based on start.sh from Jupyter Hub

set -e

if [ $# -eq 0 ]; then
    cmd=bash
else
    cmd=$*
fi

if [[ $(id -u) != 0 ]]; then
    echo Must run start.sh as root
    exit 1
fi

if [[ -v JUPYTER_USER_ID && $JUPYTER_USER_ID != 0 && -n $JUPYTER_USER_ID ]]; then
    echo Set mir UID to: $JUPYTER_USER_ID
    usermod -u $JUPYTER_USER_ID mir

    exec gosu mir $cmd
else
    exec $cmd
fi

