#!/usr/bin/env bash
set -xe

source common.sh
source build_utils.sh

MAO_VERSION="$1"
if [ -z "${MAO_VERSION}" ]; then
    echo "usage: $0 <machine-api-operator version>" >&2
    echo "example: $0 4.3.0.ipv6-2019-11-01-0001" >&2
    exit 1
fi

check_prereqs $MAO_STREAM || exit 1

build_image "machine-api-operator" $MAO_VERSION $MAO_STREAM \
             $MAO_GIT_URI $MAO_GIT_REF $MAO_DOCKERFILE
