#!/usr/bin/env bash
helm upgrade --install grafana stable/grafana \
	--namespace monitoring -f grafana.yaml
