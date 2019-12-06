#!/usr/bin/env bash
set -xe

source common.sh
source build_utils.sh

OCM_VERSION="$1"
if [ -z "${OCM_VERSION}" ]; then
    echo "usage: $0 <openshift-controller-manager version>" >&2
    echo "example: $0 4.3.0.ipv6-2019-11-01-0001" >&2
    exit 1
fi

check_prereqs $OCM_STREAM || exit 1

build_image "openshift-controller-manager" $OCM_VERSION $OCM_STREAM \
             $OCM_GIT_URI $OCM_GIT_REF $OCM_DOCKERFILE
