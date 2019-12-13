#!/usr/bin/env bash
set -xe

source common.sh
source build_utils.sh

CDO_VERSION="$1"
if [ -z "${CDO_VERSION}" ]; then
    echo "usage: $0 <cluster-dns-operator version>" >&2
    echo "example: $0 4.3.0.ipv6-2019-11-01-0001" >&2
    exit 1
fi

check_prereqs $CDO_STREAM || exit 1

build_image "cluster-dns-operator" $CDO_VERSION $CDO_STREAM \
             $CDO_GIT_URI $CDO_GIT_REF $CDO_DOCKERFILE
