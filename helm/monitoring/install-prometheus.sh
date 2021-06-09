#!/usr/bin/env bash
kubectl create namespace monitoring || true
helm upgrade --install prometheus stable/prometheus \
	--namespace monitoring -f prometheus.yaml
