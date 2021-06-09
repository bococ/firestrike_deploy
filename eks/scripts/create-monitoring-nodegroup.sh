#!/usr/bin/env bash
# Creates the monitoring node group
REGION=$1
CLUSTER_NAME=$2
PUBLIC_SSH_KEY=$3

if eksctl get cluster --region ${REGION} ${CLUSTER_NAME}; then
	eksctl create nodegroup \
		--cluster ${CLUSTER_NAME} \
		--version auto \
		--node-ami "ami-0c133691068e3cf31" \
		--name monitoring \
		--node-type "m5.xlarge" \
		--node-volume-size 80 \
		--node-volume-type "gp2" \
		--nodes 1 \
		--nodes-min 1 \
		--nodes-max 2  \
		--ssh-public-key ${PUBLIC_SSH_KEY} \
		--node-labels name="monitoring",type="m5.xlarge"
fi
