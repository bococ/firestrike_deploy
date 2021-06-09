#!/usr/bin/env bash
helm upgrade --dry-run fluent-bit stable/fluent-bit --namespace monitoring -f fluent-bit.yaml
