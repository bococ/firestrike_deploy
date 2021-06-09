#!/usr/bin/env bash
helm repo add elastic https://helm.elastic.co
helm upgrade --install kibana elastic/kibana --namespace monitoring -f kibana.yaml
