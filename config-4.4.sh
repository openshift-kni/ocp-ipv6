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

# cluster-etcd-operator build config
CEO_STREAM=cluster-etcd-operator
CEO_GIT_URI=https://github.com/openshift-kni/cluster-etcd-operator.git
CEO_GIT_REF=4.4-ipv6
CEO_DOCKERFILE=Dockerfile.rhel7

# installer build_config
INSTALLER_STREAM=installer
INSTALLER_GIT_URI=https://github.com/openshift-kni/installer.git
INSTALLER_GIT_REF=4.4-ipv6
INSTALLER_DOCKERFILE=images/installer/Dockerfile.ci

# installer-artifacts build_config
INSTALLER_ARTIFACTS_STREAM=installer-artifacts
INSTALLER_ARTIFACTS_GIT_URI=https://github.com/openshift-kni/installer.git
INSTALLER_ARTIFACTS_GIT_REF=4.4-ipv6
INSTALLER_ARTIFACTS_DOCKERFILE=images/installer-artifacts/Dockerfile.rhel

# cluster-api-provider-azure build config
CAPA_STREAM=azure-machine-controllers
CAPA_GIT_URI=https://github.com/openshift-kni/cluster-api-provider-azure.git
CAPA_GIT_REF=4.4-ipv6
CAPA_DOCKERFILE=Dockerfile
