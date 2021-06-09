#!/usr/bin/env bash
set -eux
WORLD_CHART="firestrike-world"
WORLD_ID="$1"
WORLD_NAME="${WORLD_CHART}${WORLD_ID}"
ENV="${ENV}"
kubectl create namespace ${WORLD_NAME} || true
CMD="helm upgrade --install -f firestrike-world/${ENV}.yaml --namespace ${WORLD_NAME} ${WORLD_NAME} ${WORLD_CHART} \
	--set GameWorldId=${WORLD_ID},GateNodePort=$((30000+${WORLD_ID}))"
if [ "$#" == 2 ]; then
	CMD=${CMD},GlobalcopymapId=$2
fi
${CMD}