#!/usr/bin/env bash
set -xe

source common.sh
source build_utils.sh

CONSOLE_OPERATOR_VERSION="$1"
if [ -z "${CONSOLE_OPERATOR_VERSION}" ]; then
    echo "usage: $0 <console-operator version>" >&2
    echo "example: $0 4.3.0.ipv6-2019-11-01-0001" >&2
    exit 1
fi

check_prereqs $CONSOLE_OPERATOR_STREAM || exit 1

build_image "console-operator" $CONSOLE_OPERATOR_VERSION $CONSOLE_OPERATOR_STREAM \
             $CONSOLE_OPERATOR_GIT_URI $CONSOLE_OPERATOR_GIT_REF $CONSOLE_OPERATOR_DOCKERFILE
