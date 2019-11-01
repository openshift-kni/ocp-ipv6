#!/bin/bash

# A namespace where builds will be executed
IPV6_NAMESPACE=ipv6

# Image stream where the release will be published to
IPV6_RELEASE_STREAM=release

# A kubeconfig for api.ci.openshift.org
IPV6_KUBECONFIG=ipv6-kubeconfig

# Need access to wherever the payload image - and the
# images referenced by the payload - are hosted
IPV6_PULLSECRET=ipv6-pullsecret

# Where to tag MCO builds
MCO_STREAM=machine-config-operator

# The git repository and ref (e.g. branch) to build machine-config-operator from
MCO_GIT_URI=https://github.com/russellb/machine-config-operator.git
MCO_GIT_REF=ipv6

# Where to tag CNO builds
CNO_STREAM=cluster-network-operator

# The git repository and ref (e.g. branch) to build cluster-network-operator from
CNO_GIT_URI=https://github.com/markmc/cluster-network-operator.git
CNO_GIT_REF=ipv6-hack

# Where to tag ovnkube builds
OVNKUBE_STREAM=ovn-kubernetes

# The git repository and ref (e.g. branch) to build ovn-kubernetes from
OVNKUBE_GIT_URI=https://github.com/markmc/ovn-kubernetes.git
OVNKUBE_GIT_REF=ipv6-hack
