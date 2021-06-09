#!/usr/bin/env bash
set -eux
COPYMAP_CHART="firestrike-copymap"
GLOBALCOPYMAP_ID="$1"
COPYMAP_NAME="${COPYMAP_CHART}${GLOBALCOPYMAP_ID}"
ENV="${ENV}"
kubectl create namespace ${COPYMAP_NAME} || true
helm upgrade --install -f firestrike-copymap/${ENV}.yaml --namespace ${COPYMAP_NAME} ${COPYMAP_NAME} ${COPYMAP_CHART} \
	--set GlobalcopymapId=${GLOBALCOPYMAP_ID}
