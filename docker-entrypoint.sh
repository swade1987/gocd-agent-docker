#!/bin/bash

set -e

if [ "$1" = 'go-agent' ]; then
    echo export GO_SERVER="$GO_SERVER" >> /etc/default/go-agent
    echo export DAEMON=N >> /etc/default/go-agent
    echo go ALL=NOPASSWD: /usr/bin/docker >> /etc/sudoers

    /etc/init.d/go-agent start
fi

exec "$@"