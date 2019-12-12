#!/usr/bin/env bash
set -xe

source common.sh
source build_utils.sh

HR_VERSION="$1"
if [ -z "${HR_VERSION}" ]; then
    echo "usage: $0 <haproxy-router version>" >&2
    echo "example: $0 4.3.0.ipv6-2019-11-01-0001" >&2
    exit 1
fi

check_prereqs $HR_STREAM || exit 1

build_image "haproxy-router" $HR_VERSION $HR_STREAM \
             $HR_GIT_URI $HR_GIT_REF $HR_DOCKERFILE
