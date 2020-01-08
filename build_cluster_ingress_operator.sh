#!/usr/bin/env bash
set -xe

source common.sh
source build_utils.sh

CIO_VERSION="$1"
if [ -z "${CIO_VERSION}" ]; then
    echo "usage: $0 <cluster-ingress-operator version>" >&2
    echo "example: $0 4.3.0.ipv6-2019-11-01-0001" >&2
    exit 1
fi

check_prereqs $CIO_STREAM || exit 1

build_image "cluster-ingress-operator" $CIO_VERSION $CIO_STREAM \
             $CIO_GIT_URI $CIO_GIT_REF $CIO_DOCKERFILE
