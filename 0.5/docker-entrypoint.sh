#!/usr/bin/env bash

set -e

export GOMAXPROCS=`nproc`

exec /usr/local/bin/consul agent \
    -config-file=/etc/consul/consul.json \
    -config-dir=/etc/consul/conf.d \
    "$@"
