#!/usr/bin/env bash
set -xe

source common.sh
source build_utils.sh

IRONIC_IMAGE_VERSION="$1"
if [ -z "${IRONIC_IMAGE_VERSION}" ]; then
    echo "usage: $0 <$IRONIC_IMAGE_STREAM version>" >&2
    echo "example: $0 4.3.0.ipv6-2019-11-01-0001" >&2
    exit 1
fi

check_prereqs $IRONIC_IMAGE_STREAM || exit 1

build_image "$IRONIC_IMAGE_STREAM" $IRONIC_IMAGE_VERSION $IRONIC_IMAGE_STREAM \
             $IRONIC_IMAGE_GIT_URI $IRONIC_IMAGE_GIT_REF $IRONIC_IMAGE_DOCKERFILE
