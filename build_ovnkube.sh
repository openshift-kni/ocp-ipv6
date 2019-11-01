#!/usr/bin/env bash
set -xe

#
# Build a new ovn-kubernetes image
#
# See config_example.sh for required configuration steps
#

SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
USER=`whoami`

# Get variables from the config file
if [ -z "${IPV6_CONFIG:-}" ]; then
    # See if there's a config_$USER.sh in the SCRIPTDIR
    if [ -f "${SCRIPTDIR}/config_${USER}.sh" ]; then
        echo "Using IPV6_CONFIG ${SCRIPTDIR}/config_${USER}.sh"
        IPV6_CONFIG="${SCRIPTDIR}/config_${USER}.sh"
    else
        echo "Please run with a configuration environment set." >&2
        echo "eg IPV6_CONFIG=config_example.sh $0" >&2
        exit 1
    fi
fi
source $IPV6_CONFIG

OVNKUBE_VERSION="$1"
if [ -z "${OVNKUBE_VERSION}" ]; then
    echo "usage: $0 <mco version>" >&2
    echo "example: $0 4.3.0.ipv6-2019-11-01-0001" >&2
    exit 1
fi

echo "Building ovn-kubernetes from ${OVNKUBE_GIT_URI}:${OVNKUBE_GIT_REF} to ${OVNKUBE_STREAM}:${OVNKUBE_VERSION}"

# Check prerequisites
if [ $(oc --config "${IPV6_KUBECONFIG}" project -q) != "${IPV6_NAMESPACE}" ]; then
    echo "Wrong namespace configured, run 'oc --config ${IPV6_KUBECONFIG} project ${IPV6_NAMESPACE}'" >&2
    exit 1
fi

if ! oc --config "${IPV6_KUBECONFIG}" get imagestream "${OVNKUBE_STREAM}" 2>/dev/null; then
    echo "No '${OVNKUBE_STREAM}' imagestream in '${IPV6_NAMESPACE}' namespace" >&2
    exit 1
fi

oc --config "${IPV6_KUBECONFIG}" apply -f - <<EOF
apiVersion: build.openshift.io/v1
kind: Build
metadata:
  name: ovn-kubernetes-${OVNKUBE_VERSION}
spec:
  source:
    type: Git
    git:
      uri: ${OVNKUBE_GIT_URI}
      ref: ${OVNKUBE_GIT_REF}
  strategy:
    type: Docker
    dockerStrategy:
      imageOptimizationPolicy: SkipLayers
      dockerfilePath: Dockerfile
  output:
    to:
      kind: ImageStreamTag
      name: ${OVNKUBE_STREAM}:${OVNKUBE_VERSION}
EOF

BUILD_POD=$(oc --config "${IPV6_KUBECONFIG}" get build "ovn-kubernetes-${OVNKUBE_VERSION}" -o json | jq -r '.metadata.annotations["openshift.io/build.pod-name"]')
oc --config "${IPV6_KUBECONFIG}" wait --for condition=Ready pod "${BUILD_POD}" --timeout=240s
oc --config "${IPV6_KUBECONFIG}" logs -f "${BUILD_POD}"

BUILD_PHASE=$(oc --config "${IPV6_KUBECONFIG}" get build "ovn-kubernetes-${OVNKUBE_VERSION}" -o json | jq -r .status.phase)
if [ "${BUILD_PHASE}" = "Complete" ]; then
    BUILD_OUTPUT=$(oc --config "${IPV6_KUBECONFIG}" get build "ovn-kubernetes-${OVNKUBE_VERSION}" -o json | jq -r .status.output.to.imageDigest)
    echo "ovn-kubernetes built to ${BUILD_OUTPUT}"
else
    echo "ovn-kubernetes build failed? Build phase is ${BUILD_PHASE}"
fi
