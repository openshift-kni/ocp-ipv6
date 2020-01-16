#!/usr/bin/env bash
set -xe

source common.sh
source build_utils.sh

COREDNS_VERSION="$1"
if [ -z "${COREDNS_VERSION}" ]; then
    echo "usage: $0 <$COREDNS_STREAM version>" >&2
    echo "example: $0 4.3.0.ipv6-2020-01-01-0001" >&2
    exit 1
fi

check_prereqs $COREDNS_STREAM || exit 1

build_image "$COREDNS_STREAM" $COREDNS_VERSION $COREDNS_STREAM \
             $COREDNS_GIT_URI $COREDNS_GIT_REF $COREDNS_DOCKERFILE
