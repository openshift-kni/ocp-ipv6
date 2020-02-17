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

function wait_for_build() {
    name="$1"; shift

    BUILD_POD=$(oc --config "${IPV6_KUBECONFIG}" get build "${name}" -o json | jq -r '.metadata.annotations["openshift.io/build.pod-name"]')
    oc --config "${IPV6_KUBECONFIG}" wait --for condition=Ready pod "${BUILD_POD}" --timeout=540s
    oc --config "${IPV6_KUBECONFIG}" logs -f "${BUILD_POD}"

    BUILD_PHASE=$(oc --config "${IPV6_KUBECONFIG}" get build "${name}" -o json | jq -r .status.phase)
    if [ "${BUILD_PHASE}" = "Complete" ]; then
        BUILD_OUTPUT=$(oc --config "${IPV6_KUBECONFIG}" get build "${name}" -o json | jq -r .status.output.to.imageDigest)
        echo "${name} built to ${BUILD_OUTPUT}"
    else
        echo "${name} build failed? Build phase is ${BUILD_PHASE}"
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
      from:
        kind: ImageStreamTag
        namespace: ocp
        name: ${IPV6_BASE}:base
  output:
    to:
      kind: ImageStreamTag
      name: ${istream}:${iversion}
EOF

    wait_for_build ${iname}-${iversion}
}

function build_image_from_dockerfile() {
    iname="$1"; shift
    iversion="$1"; shift
    istream="$1"; shift
    dockerfile="$1"; shift

    echo "Building ${iname} to ${istream}:${iversion} via custom Dockerfile"

    dockerfile=$(echo "${dockerfile}" | sed -e 's/^/      /')

    oc --config "${IPV6_KUBECONFIG}" apply -f - <<EOF
apiVersion: build.openshift.io/v1
kind: Build
metadata:
  name: ${iname}-${iversion}
spec:
  source:
    type: Dockerfile
    dockerfile: |
${dockerfile}
  strategy:
    type: Docker
    dockerStrategy:
      imageOptimizationPolicy: SkipLayers
  output:
    to:
      kind: ImageStreamTag
      name: ${istream}:${iversion}
EOF

    wait_for_build ${iname}-${iversion}
}
