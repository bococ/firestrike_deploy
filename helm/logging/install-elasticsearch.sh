#!/usr/bin/env bash
helm repo add elastic https://helm.elastic.co
helm upgrade --install elasticsearch elastic/elasticsearch --namespace monitoring -f elasticsearch.yaml
