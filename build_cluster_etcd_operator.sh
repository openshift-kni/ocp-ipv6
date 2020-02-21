#!/usr/bin/env bash
set -xe

source common.sh
source build_utils.sh

CEO_VERSION="$1"
if [ -z "${CEO_VERSION}" ]; then
    echo "usage: $0 <cluster-etcd-operator version>" >&2
    echo "example: $0 4.3.0.ipv6-2019-11-01-0001" >&2
    exit 1
fi

check_prereqs $CEO_STREAM || exit 1

build_image "cluster-etcd-operator" $CEO_VERSION $CEO_STREAM \
             $CEO_GIT_URI $CEO_GIT_REF $CEO_DOCKERFILE
