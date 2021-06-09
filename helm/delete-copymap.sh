#!/usr/bin/env bash
set -eux
COPYMAP_CHART="firestrike-copymap"
GLOBALCOPYMAP_ID="$1"
COPYMAP_NAME="${COPYMAP_CHART}${GLOBALCOPYMAP_ID}"
kubectl delete namespace ${COPYMAP_NAME}
