#!/bin/bash

if [[ $# -eq 2 ]]; then
	quoi="$1"
	with="$2"
	if [[ -z  $(./_getEnv.sh  $quoi) ]]; then
		echo "$quoi:$with" >> ../.mldsEnv
	else
		sed -E -i '' "s/^($quoi:).*$/\1$with/" ../.mldsEnv
	fi
fi