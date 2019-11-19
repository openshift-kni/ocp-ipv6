#!/usr/bin/env bash
set -xe

#
# Prepare a new release payload based on a metadata in builds.yaml
#
# See config.sh for required configuration steps
#
source common.sh

BUILD_NAME="$1"; shift || true
if [ -z "${BUILD_NAME}" ]; then
    echo "usage: $0 <release name>]" >&2
    echo "example: $0 4.3.0-0.ci-2019-11-01-112322-ipv6.1" >&2
    exit 1
fi

BUILD_JSON=$(yq '.[] | select(.name == "'"${BUILD_NAME}"'")' builds.yaml || true)
if [ -z "${BUILD_JSON}" ]; then
    echo "Failed to find build ${BUILD_NAME} in builds.yaml" >&2
    exit 1
fi

OCP_RELEASE=$(echo "${BUILD_JSON}" | jq -r .ocp_release)
IMAGE_OVERRIDES=$(echo "${BUILD_JSON}" | jq -r '.images[] | "\(.name)=\(.image)"')

./prep_release.sh \
    "${BUILD_NAME}" \
     "registry.svc.ci.openshift.org/ocp/release:${OCP_RELEASE}" \
     ${IMAGE_OVERRIDES}
