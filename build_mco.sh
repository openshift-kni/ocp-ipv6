#!/usr/bin/env bash
set -xe

source common.sh
source build_utils.sh

MCO_VERSION="$1"
if [ -z "${MCO_VERSION}" ]; then
    echo "usage: $0 <machine-config-operator version>" >&2
    echo "example: $0 4.3.0.ipv6-2019-11-01-0001" >&2
    exit 1
fi

check_prereqs $MCO_STREAM || exit 1

build_image "machine-config-operator" $MCO_VERSION $MCO_STREAM \
             $MCO_GIT_URI $MCO_GIT_REF $MCO_DOCKERFILE
