#!/usr/bin/env bash
set -xe

source common.sh
source build_utils.sh

CAPA_VERSION="$1"
if [ -z "${CAPA_VERSION}" ]; then
    echo "usage: $0 <cluster-api-provider-azure version>" >&2
    echo "example: $0 4.3.0.ipv6-2019-11-01-0001" >&2
    exit 1
fi

check_prereqs $CAPA_STREAM || exit 1

build_image "cluster-api-provider-azure" $CAPA_VERSION $CAPA_STREAM \
             $CAPA_GIT_URI $CAPA_GIT_REF $CAPA_DOCKERFILE
