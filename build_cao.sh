#!/usr/bin/env bash
set -xe

source common.sh
source build_utils.sh

CAO_VERSION="$1"
if [ -z "${CAO_VERSION}" ]; then
    echo "usage: $0 <cluster-authentication-operator version>" >&2
    echo "example: $0 4.3.0.ipv6-2019-11-01-0001" >&2
    exit 1
fi

check_prereqs $CAO_STREAM || exit 1

build_image "cluster-authentication-operator" $CAO_VERSION $CAO_STREAM \
             $CAO_GIT_URI $CAO_GIT_REF $CAO_DOCKERFILE
