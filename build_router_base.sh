#!/usr/bin/env bash
set -xe

source common.sh
source build_utils.sh

RB_VERSION="$1"
if [ -z "${RB_VERSION}" ]; then
    echo "usage: $0 <router-base version>" >&2
    echo "example: $0 4.3.0.ipv6-2019-11-01-0001" >&2
    exit 1
fi

check_prereqs $RB_STREAM || exit 1

build_image "router-base" $RB_VERSION $RB_STREAM \
             $RB_GIT_URI $RB_GIT_REF $RB_DOCKERFILE
