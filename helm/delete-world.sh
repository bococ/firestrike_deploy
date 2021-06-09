#!/usr/bin/env bash
set -eux
WORLD_CHART="firestrike-world"
WORLD_ID="$1"
WORLD_NAME="${WORLD_CHART}${WORLD_ID}"
kubectl delete namespace ${WORLD_NAME}
