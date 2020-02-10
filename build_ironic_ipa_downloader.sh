#!/usr/bin/env bash
set -xe

source common.sh
source build_utils.sh

IPA_DOWNLOADER_VERSION="$1"
if [ -z "${IPA_DOWNLOADER_VERSION}" ]; then
    echo "usage: $0 <$IPA_DOWNLOADER_STREAM version>" >&2
    echo "example: $0 4.3.0.ipv6-2019-11-01-0001" >&2
    exit 1
fi

check_prereqs $IPA_DOWNLOADER_STREAM || exit 1

build_image "$IPA_DOWNLOADER_STREAM" $IPA_DOWNLOADER_VERSION $IPA_DOWNLOADER_STREAM \
             $IPA_DOWNLOADER_GIT_URI $IPA_DOWNLOADER_GIT_REF $IPA_DOWNLOADER_DOCKERFILE
