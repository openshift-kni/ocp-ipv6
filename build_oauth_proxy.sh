#!/usr/bin/env bash
set -xe

source common.sh
source build_utils.sh

OAUTHPROXY_VERSION="$1"
if [ -z "${OAUTHPROXY_VERSION}" ]; then
    echo "usage: $0 <$OAUTHPROXY_STREAM version>" >&2
    echo "example: $0 4.3.0.ipv6-2019-12-13-0001" >&2
    exit 1
fi

check_prereqs $OAUTHPROXY_STREAM || exit 1

build_image "$OAUTHPROXY_STREAM" $OAUTHPROXY_VERSION $OAUTHPROXY_STREAM \
             $OAUTHPROXY_GIT_URI $OAUTHPROXY_GIT_REF $OAUTHPROXY_DOCKERFILE
