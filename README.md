
As we bootstrap OpenShift's IPv6 support, we will have a number of
components that have IPv6 patches that are not yet merged. We build
images with those changes in the `kni` workspace of the OpenShift CI
cluster.

## Preparation and Configuration

We build and publish within a namespace on an OpenShift
cluster. First, prepare a `kubeconfig` with credentials to this
cluster, and with the desired namespace set as the default:

```
$ oc --config=ipv6-kubeconfig login https://api.ci.openshift.org --token=...
$ oc --config=ipv6-kubeconfig project ipv6
$ oc --config=ipv6-kubeconfig registry login --to=ipv6-pullsecret
$ oc --config=ipv6-kubeconfig registry login -z default --to=ipv6-serviceaccount-pullsecret
```

Note the namespace was initially created and configured as follows:

```
$ oc --config=ipv6-kubeconfig new-project ipv6
$ oc --config=ipv6-kubeconfig adm policy add-role-to-user admin <other admin>
$ oc --config=ipv6-kubeconfig create imagestream release
$ oc --config=ipv6-kubeconfig create imagestream machine-config-operator
$ oc --config=ipv6-kubeconfig create imagestream cluster-network-operator
````

## Building

To build component images:

```
$ IPV6_CONFIG=config_example.sh ./build_mco.sh 4.3.0.ipv6-2019-11-01-0001
...
machine-config-operator built to sha256:37021127dc9c1261401e67f573d53f5c444c9efebbdeb42875569dd9cc04c674
$ IPV6_CONFIG=config_example.sh ./build_cno.sh 4.3.0.ipv6-2019-11-01-0001
...
cluster-network-operator built to sha256:40eb00fa6cbe7767ad9c047fbdfab149e7916e18a761854e65ee9af8f057e604
$ IPV6_CONFIG=config_example.sh ./build_ovnkube.sh 4.3.0.ipv6-2019-11-01-0001
...
ovn-kubernetes built to sha256:6684f115f73328287a9cff6e71daa49329fb11580651e79ba6a8aa550ea97690
```

And to build a release image:

```
$ IPV6_CONFIG=config_example.sh ./prep_release.sh 4.3.0-0.ci-2019-11-01-112322-ipv6.1 \
    registry.svc.ci.openshift.org/ocp/release:4.3.0-0.ci-2019-11-01-112322 \
    machine-config-operator=registry.svc.ci.openshift.org/ipv6/machine-config-operator@sha256:37021127dc9c1261401e67f573d53f5c444c9efebbdeb42875569dd9cc04c674 \
    cluster-network-operator=registry.svc.ci.openshift.org/ipv6/cluster-network-operator@sha256:40eb00fa6cbe7767ad9c047fbdfab149e7916e18a761854e65ee9af8f057e604 \
    ovn-kubernetes=registry.svc.ci.openshift.org/ipv6/ovn-kubernetes@sha256:6684f115f73328287a9cff6e71daa49329fb11580651e79ba6a8aa550ea97690
...
New 4.3.0-0.ci-2019-11-01-112322-ipv6.1 release payload available to registry.svc.ci.openshift.org/ipv6/release:4.3.0-0.ci-2019-11-01-112322-ipv6.1
```

## Accessing

```
$ oc image info --registry-config=ipv6-pullsecret -o json \
      registry.svc.ci.openshift.org/ipv6/machine-config-operator@sha256:37021127dc9c1261401e67f573d53f5c444c9efebbdeb42875569dd9cc04c674 \
      | jq -r '.config.config.Labels["io.openshift.build.commit.id"]'
19ad261e5a74cd068f55a440ef3cd9f1a3768153
```

```
$ oc adm release info -a ipv6-pullsecret --pullspecs registry.svc.ci.openshift.org/ipv6/release:4.3.0-0.ci-2019-11-01-112322-ipv6.1
Name:          4.3.0-0.ci-2019-11-01-112322-ipv6.1
Digest:        sha256:504623fb4b169b47a6065351e26386689bb12afce851ab6cf5b16a6658303c1f
...
Release Metadata:
  Version:  4.3.0-0.ci-2019-11-01-112322-ipv6.1
...
Images:
  NAME                                            PULL SPEC
...
  cluster-network-operator                        registry.svc.ci.openshift.org/ipv6/cluster-network-operator@sha256:40eb00fa6cbe7767ad9c047fbdfab149e7916e18a761854e65ee9af8f057e604
...
  machine-config-operator                         registry.svc.ci.openshift.org/ipv6/machine-config-operator@sha256:37021127dc9c1261401e67f573d53f5c444c9efebbdeb42875569dd9cc04c674
...
```
