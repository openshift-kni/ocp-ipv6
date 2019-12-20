#!/usr/bin/env bash
set -xe

source common.sh
source build_utils.sh

INSTALLER_BAREMETAL_VERSION="$1"
if [ -z "${INSTALLER_BAREMETAL_VERSION}" ]; then
    echo "usage: $0 <installer-baremetal version>" >&2
    echo "example: $0 4.3.0.ipv6-2019-11-01-0001" >&2
    exit 1
fi

check_prereqs $INSTALLER_BAREMETAL_STREAM || exit 1

build_image "installer-baremetal" $INSTALLER_BAREMETAL_VERSION $INSTALLER_BAREMETAL_STREAM \
             $INSTALLER_BAREMETAL_GIT_URI $INSTALLER_BAREMETAL_GIT_REF $INSTALLER_BAREMETAL_DOCKERFILE
