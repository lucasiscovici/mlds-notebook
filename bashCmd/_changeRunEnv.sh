#!/bin/bash

if [[ $# -ge 1 ]]; then
	quoi="__$1"
	with="$2"
	if [[ $quoi == "__-d" ]]; then
		sed -E -i '' "/^$with=/d" .mldsEnv
		exit
	fi
	if [[ -z  "$(_getEnv.sh  $quoi -q)" ]]; then
		echo "$quoi=$with" >> .mldsEnv
	else
		sed -E -i '' "s/^($quoi=).*$/\1$with/" .mldsEnv
	fi
fi