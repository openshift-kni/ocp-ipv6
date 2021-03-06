#!/usr/bin/env bash
set -xe

source common.sh
source build_utils.sh

INSTALLER_VERSION="$1"
if [ -z "${INSTALLER_VERSION}" ]; then
    echo "usage: $0 <installer version>" >&2
    echo "example: $0 4.3.0.ipv6-2019-11-01-0001" >&2
    exit 1
fi

check_prereqs $INSTALLER_STREAM || exit 1

build_image "installer" $INSTALLER_VERSION $INSTALLER_STREAM \
             $INSTALLER_GIT_URI $INSTALLER_GIT_REF $INSTALLER_DOCKERFILE
