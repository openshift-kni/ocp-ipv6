#!/usr/bin/env bash
set -xe

source common.sh
source build_utils.sh

CVO_VERSION="$1"
if [ -z "${CVO_VERSION}" ]; then
    echo "usage: $0 <cluster-version-operator version>" >&2
    echo "example: $0 4.3.0.ipv6-2019-11-01-0001" >&2
    exit 1
fi

check_prereqs $CVO_STREAM || exit 1

build_image "cluster-version-operator" $CVO_VERSION $CVO_STREAM \
             $CVO_GIT_URI $CVO_GIT_REF $CVO_DOCKERFILE
