#!/usr/bin/env bash
set -xe

source common.sh
source build_utils.sh

DNS_VERSION="$1"
if [ -z "${DNS_VERSION}" ]; then
    echo "usage: $0 <cluster-dns-operator version>" >&2
    echo "example: $0 4.3.0.ipv6-2019-11-01-0001" >&2
    exit 1
fi

check_prereqs $DNS_STREAM || exit 1

build_image "cluster-dns-operator" $DNS_VERSION $DNS_STREAM \
             $DNS_GIT_URI $DNS_GIT_REF $DNS_DOCKERFILE
