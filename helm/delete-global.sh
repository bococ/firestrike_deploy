#!/usr/bin/env bash
set -eux
GLOBAL_CHART="firestrike-global"
GLOBAL_ID="$1"
GLOBAL_NAME="${GLOBAL_CHART}${GLOBAL_ID}"
kubectl delete namespace ${GLOBAL_NAME}
