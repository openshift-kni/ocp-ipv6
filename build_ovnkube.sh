#!/usr/bin/env bash
set -xe

source common.sh
source build_utils.sh

OVNKUBE_VERSION="$1"
if [ -z "${OVNKUBE_VERSION}" ]; then
    echo "usage: $0 <ovn-kubernetes version>" >&2
    echo "example: $0 4.3.0.ipv6-2019-11-01-0001" >&2
    exit 1
fi

check_prereqs $OVNKUBE_STREAM || exit 1

build_image "ovn-kubernetes" $OVNKUBE_VERSION $OVNKUBE_STREAM \
             $OVNKUBE_GIT_URI $OVNKUBE_GIT_REF $OVNKUBE_DOCKERFILE
