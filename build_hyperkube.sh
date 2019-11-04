#!/usr/bin/env bash
set -xe

source common.sh
source build_utils.sh

HYPERKUBE_VERSION="$1"
if [ -z "${HYPERKUBE_VERSION}" ]; then
    echo "usage: $0 <hyperkube version>" >&2
    echo "example: $0 4.3.0.ipv6-2019-11-01-0001" >&2
    exit 1
fi

check_prereqs $HYPERKUBE_STREAM || exit 1

build_image "hyperkube" $HYPERKUBE_VERSION $HYPERKUBE_STREAM \
             $HYPERKUBE_GIT_URI $HYPERKUBE_GIT_REF $HYPERKUBE_DOCKERFILE
