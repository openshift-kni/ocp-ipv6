#!/bin/bash

## Generic configuration

# A namespace where builds will be executed
IPV6_NAMESPACE=ipv6

# Image stream where the release will be published to
IPV6_RELEASE_STREAM=release

# A kubeconfig for api.ci.openshift.org
IPV6_KUBECONFIG=ipv6-kubeconfig

# Need access to wherever the payload image - and the
# images referenced by the payload - are hosted
IPV6_PULLSECRET=ipv6-pullsecret

## Specific modules

# cluster-image-registry-operator
CIRO_STREAM=cluster-image-registry-operator
CIRO_GIT_URI=https://github.com/openshift-kni/cluster-image-registry-operator.git
CIRO_GIT_REF=4.3-ipv6
CIRO_DOCKERFILE=Dockerfile

# cluster-kube-apiserver-operator build config
CKAO_STREAM=cluster-kube-apiserver-operator
CKAO_GIT_URI=https://github.com/openshift-kni/cluster-kube-apiserver-operator.git
CKAO_GIT_REF=4.3-ipv6
CKAO_DOCKERFILE=Dockerfile.rhel7

# cluster-monitoring-operator build config
CMO_STREAM=cluster-monitoring-operator
CMO_GIT_URI=https://github.com/openshift-kni/cluster-monitoring-operator.git
CMO_GIT_REF=4.3-ipv6
CMO_DOCKERFILE=Dockerfile

# cluster-openshift-apiserver-operator build config
COAO_STREAM=cluster-openshift-apiserver-operator
COAO_GIT_URI=https://github.com/openshift-kni/cluster-openshift-apiserver-operator.git
COAO_GIT_REF=4.3-ipv6
COAO_DOCKERFILE=Dockerfile

# console-operator build config
CONSOLE_OPERATOR_STREAM=console-operator
CONSOLE_OPERATOR_GIT_URI=https://github.com/openshift-kni/console-operator.git
CONSOLE_OPERATOR_GIT_REF=4.3-ipv6
CONSOLE_OPERATOR_DOCKERFILE=Dockerfile

# hyperkube build config
HYPERKUBE_STREAM=hyperkube
HYPERKUBE_GIT_URI=https://github.com/openshift-kni/origin.git
HYPERKUBE_GIT_REF=4.3-ipv6
HYPERKUBE_DOCKERFILE=images/hyperkube/Dockerfile.rhel

# installer build_config
INSTALLER_STREAM=installer
INSTALLER_GIT_URI=https://github.com/openshift-kni/installer.git
INSTALLER_GIT_REF=4.3-ipv6
INSTALLER_DOCKERFILE=images/installer/Dockerfile.ci

# installer-artifacts build_config
INSTALLER_ARTIFACTS_STREAM=installer-artifacts
INSTALLER_ARTIFACTS_GIT_URI=https://github.com/openshift-kni/installer.git
INSTALLER_ARTIFACTS_GIT_REF=4.3-ipv6
INSTALLER_ARTIFACTS_DOCKERFILE=images/installer-artifacts/Dockerfile.rhel

# installer-baremetal build_config
INSTALLER_BAREMETAL_STREAM=baremetal-installer
INSTALLER_BAREMETAL_GIT_URI=https://github.com/openshift-kni/installer.git
INSTALLER_BAREMETAL_GIT_REF=4.3-ipv6
INSTALLER_BAREMETAL_DOCKERFILE=images/baremetal/Dockerfile.ci

# ironic-image build_config
IRONIC_IMAGE_STREAM=ironic-image
IRONIC_IMAGE_GIT_URI=https://github.com/openshift-kni/ironic-image.git
IRONIC_IMAGE_GIT_REF=4.3-ipv6
IRONIC_IMAGE_DOCKERFILE=Dockerfile

# machine-config-operator build config
MCO_STREAM=machine-config-operator
MCO_GIT_URI=https://github.com/openshift-kni/machine-config-operator.git
MCO_GIT_REF=4.3-ipv6
MCO_DOCKERFILE=Dockerfile

# machine-os-content build config
MOC_STREAM=machine-os-content

# openshift-controller-manager build config
OCM_STREAM=openshift-controller-manager
OCM_GIT_URI=https://github.com/openshift-kni/openshift-controller-manager.git
OCM_GIT_REF=4.3-ipv6
OCM_DOCKERFILE=Dockerfile.rhel

# ovn-kubernetes build config
OVNKUBE_STREAM=ovn-kubernetes
OVNKUBE_GIT_URI=https://github.com/openshift-kni/ovn-kubernetes.git
OVNKUBE_GIT_REF=4.3-ipv6
OVNKUBE_DOCKERFILE=Dockerfile

# cluster-ingress-operator build config
CIO_STREAM=cluster-ingress-operator
CIO_GIT_URI=https://github.com/openshift-kni/cluster-ingress-operator.git
CIO_GIT_REF=4.3-ipv6
CIO_DOCKERFILE=Dockerfile

# installer-baremetal build_config
BAREMETAL_RUNTIMECFG_STREAM=baremetal-runtimecfg
BAREMETAL_RUNTIMECFG_GIT_URI=https://github.com/openshift-kni/baremetal-runtimecfg.git
BAREMETAL_RUNTIMECFG_GIT_REF=4.3-ipv6
BAREMETAL_RUNTIMECFG_DOCKERFILE=Dockerfile

COREDNS_STREAM=coredns
COREDNS_GIT_URI=https://github.com/openshift-kni/coredns.git
COREDNS_GIT_REF=4.3-ipv6
COREDNS_DOCKERFILE=Dockerfile.openshift
