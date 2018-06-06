#!/bin/bash

if [[ $# -eq 2 ]]; then
	quoi="$1"
	with="$2"
	sed -E -i '' "s/^($quoi:).*$/\1$with/" ../.mldsEnv
fi