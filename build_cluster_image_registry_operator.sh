#!/usr/bin/env bash
set -xe

source common.sh
source build_utils.sh

CIRO_VERSION="$1"
if [ -z "${CIRO_VERSION}" ]; then
    echo "usage: $0 <cluster-image-registry-operator version>" >&2
    echo "example: $0 4.3.0.ipv6-2019-11-01-0001" >&2
    exit 1
fi

check_prereqs $CIRO_STREAM || exit 1

build_image "cluster-image-registry-operator" $CIRO_VERSION $CIRO_STREAM \
             $CIRO_GIT_URI $CIRO_GIT_REF $CIRO_DOCKERFILE
