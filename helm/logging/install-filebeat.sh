#!/usr/bin/env bash
helm upgrade --install filebeat elastic/filebeat --namespace monitoring -f filebeat.yaml
