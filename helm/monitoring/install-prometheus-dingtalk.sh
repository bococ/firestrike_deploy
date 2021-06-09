#!/usr/bin/env bash
kubectl create namespace monitoring || true
helm upgrade --install prometheus-dingtalk prometheus-dingtalk \
	--namespace monitoring -f prometheus-dingtalk/values.yaml
