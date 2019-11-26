#!/usr/bin/env bash
set -xe

source common.sh
source build_utils.sh

CKCMO_VERSION="$1"
if [ -z "${CKCMO_VERSION}" ]; then
    echo "usage: $0 <cluster-kube-controller-manager-operator version>" >&2
    echo "example: $0 4.3.0.ipv6-2019-11-01-0001" >&2
    exit 1
fi

check_prereqs $CKCMO_STREAM || exit 1

build_image "cluster-kube-controller-manager-operator" $CKCMO_VERSION $CKCMO_STREAM \
             $CKCMO_GIT_URI $CKCMO_GIT_REF $CKCMO_DOCKERFILE
