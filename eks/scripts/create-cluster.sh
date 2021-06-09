#!/usr/bin/env bash
# Creates a cluster if it does not already exist
REGION=$1
AVAILABILITY_ZONES=$2
CLUSTER_NAME=$3
PUBLIC_SSH_KEY=$4

if eksctl get cluster --region ${REGION} ${CLUSTER_NAME}; then
	echo "Cluster $3 already exists"
	exit 0
fi

echo "Creating cluster ${CLUSTER_NAME}..."
eksctl create cluster \
    --region ${REGION} \
    --zones=${AVAILABILITY_ZONES} \
    --name ${CLUSTER_NAME} \
    --nodes 2 \
    --node-type "m5.xlarge" \
		--ssh-public-key ${PUBLIC_SSH_KEY} \
		--node-ami "ami-0c133691068e3cf31"


