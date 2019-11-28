#!/usr/bin/env bash
set -xe

source common.sh
source build_utils.sh

CMO_VERSION="$1"
if [ -z "${CMO_VERSION}" ]; then
    echo "usage: $0 <cluster-monitoring-operator version>" >&2
    echo "example: $0 4.3.0.ipv6-2019-11-01-0001" >&2
    exit 1
fi

check_prereqs $CMO_STREAM || exit 1

build_image "cluster-monitoring-operator" $CMO_VERSION $CMO_STREAM \
             $CMO_GIT_URI $CMO_GIT_REF $CMO_DOCKERFILE
