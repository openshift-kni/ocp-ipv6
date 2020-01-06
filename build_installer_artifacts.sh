#!/usr/bin/env bash
set -xe

source common.sh
source build_utils.sh

INSTALLER_ARTIFACTS_VERSION="$1"
if [ -z "${INSTALLER_ARTIFACTS_VERSION}" ]; then
    echo "usage: $0 <installer-artifacts version>" >&2
    echo "example: $0 4.3.0.ipv6-2019-11-01-0001" >&2
    exit 1
fi

check_prereqs $INSTALLER_ARTIFACTS_STREAM || exit 1

build_image "installer-artifacts" $INSTALLER_ARTIFACTS_VERSION $INSTALLER_ARTIFACTS_STREAM \
             $INSTALLER_ARTIFACTS_GIT_URI $INSTALLER_ARTIFACTS_GIT_REF $INSTALLER_ARTIFACTS_DOCKERFILE
