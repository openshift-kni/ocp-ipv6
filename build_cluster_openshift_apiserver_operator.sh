#!/usr/bin/env bash
set -xe

source common.sh
source build_utils.sh

COAO_VERSION="$1"
if [ -z "${COAO_VERSION}" ]; then
    echo "usage: $0 <cluster-openshift-apiserver-operator version>" >&2
    echo "example: $0 4.3.0.ipv6-2019-11-01-0001" >&2
    exit 1
fi

check_prereqs $COAO_STREAM || exit 1

build_image "cluster-openshift-apiserver-operator" $COAO_VERSION $COAO_STREAM \
             $COAO_GIT_URI $COAO_GIT_REF $COAO_DOCKERFILE
