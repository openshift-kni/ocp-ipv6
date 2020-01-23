#!/usr/bin/env bash
set -xe

source common.sh
source build_utils.sh

CKAO_VERSION="$1"
if [ -z "${CKAO_VERSION}" ]; then
    echo "usage: $0 <cluster-kube-apiserver-operator version>" >&2
    echo "example: $0 4.3.0.ipv6-2019-11-01-0001" >&2
    exit 1
fi

check_prereqs $CKAO_STREAM || exit 1

build_image "cluster-kube-apiserver-operator" $CKAO_VERSION $CKAO_STREAM \
             $CKAO_GIT_URI $CKAO_GIT_REF $CKAO_DOCKERFILE
