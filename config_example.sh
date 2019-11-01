#!/bin/bash

# A namespace where builds will be executed
IPV6_NAMESPACE=ipv6

# A kubeconfig for api.ci.openshift.org
IPV6_KUBECONFIG=ipv6-kubeconfig

# Where to tag MCO builds
MCO_STREAM=machine-config-operator

# The git repository and ref (e.g. branch) to build machine-config-operator from
MCO_GIT_URI=https://github.com/russellb/machine-config-operator.git
MCO_GIT_REF=ipv6
