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

# machine-config-operator build config
MCO_STREAM=machine-config-operator
MCO_GIT_URI=https://github.com/russellb/machine-config-operator.git
MCO_GIT_REF=ipv6
MCO_DOCKERFILE=Dockerfile

# cluster-network-operator build config
CNO_STREAM=cluster-network-operator
CNO_GIT_URI=https://github.com/markmc/cluster-network-operator.git
CNO_GIT_REF=ipv6-hack
CNO_DOCKERFILE=Dockerfile

# ovn-kubernetes build config
OVNKUBE_STREAM=ovn-kubernetes
OVNKUBE_GIT_URI=https://github.com/markmc/ovn-kubernetes.git
OVNKUBE_GIT_REF=ipv6-hack
OVNKUBE_DOCKERFILE=Dockerfile

# hyperkube build config
HYPERKUBE_STREAM=hyperkube
HYPERKUBE_GIT_URI=https://github.com/danwinship/origin.git
HYPERKUBE_GIT_REF=ipv6
HYPERKUBE_DOCKERFILE=images/hyperkube/Dockerfile.rhel

# cluster-kube-apiserver-operator build config
CKAO_STREAM=cluster-kube-apiserver-operator
CKAO_GIT_URI=https://github.com/danwinship/cluster-kube-apiserver-operator.git
CKAO_GIT_REF=ipv6-bind
CKAO_DOCKERFILE=Dockerfile

CVO_STREAM=cluster-version-operator
CVO_GIT_URI=https://github.com/russellb/cluster-version-operator.git
CVO_GIT_REF=ipv6-hack
CVO_DOCKERFILE=Dockerfile

# machine-os-content build config
MOC_STREAM=machine-os-content
