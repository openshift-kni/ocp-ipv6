#!/usr/bin/env bash
set -xe

source common.sh
source build_utils.sh

CNO_VERSION="$1"
if [ -z "${CNO_VERSION}" ]; then
    echo "usage: $0 <cluster-network-operator version>" >&2
    echo "example: $0 4.3.0.ipv6-2019-11-01-0001" >&2
    exit 1
fi

check_prereqs $CNO_STREAM || exit 1

build_image "cluster-network-operator" $CNO_VERSION $CNO_STREAM \
             $CNO_GIT_URI $CNO_GIT_REF $CNO_DOCKERFILE
