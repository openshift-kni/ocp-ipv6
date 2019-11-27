#!/usr/bin/env bash
set -xe

source common.sh
source build_utils.sh

MOC_VERSION="$1"; shift || true
BASE_RELEASE_PULLSPEC="$1"; shift || true
HYPERKUBE_PULLSPEC="$1"; shift || true
if [ -z "${MOC_VERSION}" -o -z "${BASE_RELEASE_PULLSPEC}" -o -z "${HYPERKUBE_PULLSPEC}" ]; then
    echo "usage: $0 <output version> <base release pullspec> <hyperkube pullspec>" >&2
    echo "example: $0 4.3.0.ipv6-2019-11-01-0001 registry.svc.ci.openshift.org/ocp/release:... registry.svc.ci.openshift.org/ipv6/hyperkube@sha256:..." >&2
    exit 1
fi

check_prereqs $MOC_STREAM || exit 1

MOC_PULLSPEC=$(oc adm release extract --file=image-references ${BASE_RELEASE_PULLSPEC} | jq -r '.spec.tags | .[] | select(.name=="machine-os-content") | .from.name')

DOCKERFILE=$(cat <<EOF
FROM ${MOC_PULLSPEC} AS moc

FROM ${HYPERKUBE_PULLSPEC} AS hyperkube

FROM quay.io/coreos-assembler/coreos-assembler:latest AS build
COPY --from=moc /srv/ /srv/
COPY --from=hyperkube /usr/bin/hyperkube /overrides/usr/bin/hyperkube

USER 0
RUN coreos-assembler dev-overlay --repo /srv/repo --rev \$(find /srv -name *.commit | sed -Ee 's|.*objects/(.+)/(.+)\.commit|\1\2|' | head -1) --add-tree /overrides --output-ref origin-ci-dev

FROM scratch
COPY --from=build /srv/ /srv/
ENTRYPOINT ["/noentry"]
EOF
)

build_image_from_dockerfile "machine-os-content" $MOC_VERSION $MOC_STREAM "$DOCKERFILE"
