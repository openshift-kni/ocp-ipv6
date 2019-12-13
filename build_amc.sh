#!/usr/bin/env bash
set -xe

source common.sh
source build_utils.sh

AMC_VERSION="$1"
if [ -z "${AMC_VERSION}" ]; then
    echo "usage: $0 <aws-machine-controllers version>" >&2
    echo "example: $0 4.3.0.ipv6-2019-12-13-0001" >&2
    exit 1
fi

check_prereqs $AMC_STREAM || exit 1

build_image "aws-machine-controllers" $AMC_VERSION $AMC_STREAM \
             $AMC_GIT_URI $AMC_GIT_REF $AMC_DOCKERFILE
