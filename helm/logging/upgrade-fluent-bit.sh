#!/usr/bin/env bash
helm upgrade fluent-bit stable/fluent-bit --namespace monitoring -f fluent-bit.yaml
