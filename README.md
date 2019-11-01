

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
```

Note the namespace was initially created and configured as follows:

```
$ oc --config=ipv6-kubeconfig new-project ipv6
$ oc --config=ipv6-kubeconfig adm policy add-role-to-user admin <other admin>
$ oc --config=ipv6-kubeconfig create imagestream machine-config-operator
$ oc --config=ipv6-kubeconfig create imagestream cluster-network-operator
````

## Building

```
$ IPV6_CONFIG=config_example.sh ./build_mco.sh 4.3.0.ipv6-2019-11-01-0001
...
machine-config-operator built to sha256:37021127dc9c1261401e67f573d53f5c444c9efebbdeb42875569dd9cc04c674
$ IPV6_CONFIG=config_example.sh ./build_cno.sh 4.3.0.ipv6-2019-11-01-0001
...
cluster-network-operator built to sha256:40eb00fa6cbe7767ad9c047fbdfab149e7916e18a761854e65ee9af8f057e604
```

## Accessing

```
$ oc --config=ipv6-kubeconfig registry login --to=ipv6-pullsecret
$ oc image info --registry-config=ipv6-pullsecret registry.svc.ci.openshift.org/ipv6/machine-config-operator@sha256:37021127dc9c1261401e67f573d53f5c444c9efebbdeb42875569dd9cc04c674 -o json | jq -r '.config.config.Labels["io.openshift.build.commit.id"]'
19ad261e5a74cd068f55a440ef3cd9f1a3768153
```
