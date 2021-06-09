#!/usr/bin/env bash
set -eux
GLOBAL_CHART="firestrike-global"
GLOBAL_ID="$1"
GLOBAL_NAME="${GLOBAL_CHART}${GLOBAL_ID}"
kubectl create namespace ${GLOBAL_NAME} || true
helm upgrade --install -f firestrike-global/${ENV}.yaml --namespace ${GLOBAL_NAME} ${GLOBAL_NAME} ${GLOBAL_CHART}
