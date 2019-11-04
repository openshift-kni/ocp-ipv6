#!/bin/bash


function check_prereqs() {
    istream="$1"; shift

    if [ $(oc --config "${IPV6_KUBECONFIG}" project -q) != "${IPV6_NAMESPACE}" ]; then
        echo "Wrong namespace configured, run 'oc --config ${IPV6_KUBECONFIG} project ${IPV6_NAMESPACE}'" >&2
        return 1
    fi

    if ! oc --config "${IPV6_KUBECONFIG}" get imagestream "${istream}" 2>/dev/null; then
        echo "No '${istream}' imagestream in '${IPV6_NAMESPACE}' namespace" >&2
        return 1
    fi
}

function build_image() {
    iname="$1"; shift
    iversion="$1"; shift
    istream="$1"; shift
    git_uri="$1"; shift
    git_ref="$1"; shift
    dockerfile="$1"; shift

    echo "Building ${iname} from ${git_uri}:${git_ref} to ${istream}:${iversion}"

    oc --config "${IPV6_KUBECONFIG}" apply -f - <<EOF
apiVersion: build.openshift.io/v1
kind: Build
metadata:
  name: ${iname}-${iversion}
spec:
  source:
    type: Git
    git:
      uri: ${git_uri}
      ref: ${git_ref}
  strategy:
    type: Docker
    dockerStrategy:
      imageOptimizationPolicy: SkipLayers
      dockerfilePath: ${dockerfile}
  output:
    to:
      kind: ImageStreamTag
      name: ${istream}:${iversion}
EOF

    BUILD_POD=$(oc --config "${IPV6_KUBECONFIG}" get build "${iname}-${iversion}" -o json | jq -r '.metadata.annotations["openshift.io/build.pod-name"]')
    oc --config "${IPV6_KUBECONFIG}" wait --for condition=Ready pod "${BUILD_POD}" --timeout=240s
    oc --config "${IPV6_KUBECONFIG}" logs -f "${BUILD_POD}"

    BUILD_PHASE=$(oc --config "${IPV6_KUBECONFIG}" get build "${iname}-${iversion}" -o json | jq -r .status.phase)
    if [ "${BUILD_PHASE}" = "Complete" ]; then
        BUILD_OUTPUT=$(oc --config "${IPV6_KUBECONFIG}" get build "${iname}-${iversion}" -o json | jq -r .status.output.to.imageDigest)
        echo "${iname} built to ${BUILD_OUTPUT}"
    else
        echo "${iname} build failed? Build phase is ${BUILD_PHASE}"
    fi
}
