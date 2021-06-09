#!/usr/bin/env bash
set -eux
docker run -it --rm --name fluent-bit \
	-v $(pwd)/application.log:/application.log \
	-v $(pwd)/fluent-bit.conf:/fluent-bit.conf \
	-v $(pwd)/parsers.conf:/parsers.conf \
	fluent/fluent-bit:latest /fluent-bit/bin/fluent-bit -c /fluent-bit.conf
