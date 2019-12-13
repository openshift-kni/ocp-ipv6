#!/usr/bin/env bash
set -xe

source common.sh
source build_utils.sh

CMA_VERSION="$1"
if [ -z "${CMA_VERSION}" ]; then
    echo "usage: $0 <cluster-machine-approver version>" >&2
    echo "example: $0 4.3.0.ipv6-2019-12-13-0001" >&2
    exit 1
fi

check_prereqs $CMA_STREAM || exit 1

build_image "cluster-machine-approver" $CMA_VERSION $CMA_STREAM \
             $CMA_GIT_URI $CMA_GIT_REF $CMA_DOCKERFILE
