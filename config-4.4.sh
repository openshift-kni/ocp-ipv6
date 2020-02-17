#!/bin/bash

## Generic configuration

# A namespace where builds will be executed
IPV6_NAMESPACE=ipv6

# The image stream (under the ocp namespace) where our 'base' image is tagged
IPV6_BASE=4.4

# Image stream where the release will be published to
IPV6_RELEASE_STREAM=release

# A kubeconfig for api.ci.openshift.org
IPV6_KUBECONFIG=ipv6-kubeconfig

# Need access to wherever the payload image - and the
# images referenced by the payload - are hosted
IPV6_PULLSECRET=ipv6-pullsecret

## Specific modules

# cluster-network-operator build config
CNO_STREAM=cluster-network-operator
CNO_GIT_URI=https://github.com/openshift-kni/cluster-network-operator.git
CNO_GIT_REF=4.4-ipv6
CNO_DOCKERFILE=Dockerfile

# ovn-kubernetes build config
OVNKUBE_STREAM=ovn-kubernetes
OVNKUBE_GIT_URI=https://github.com/openshift-kni/ovn-kubernetes.git
OVNKUBE_GIT_REF=4.4-ipv6
OVNKUBE_DOCKERFILE=Dockerfile
