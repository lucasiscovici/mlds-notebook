#!/bin/bash

if [[ $# -eq 1 ]]; then
	quoi="$1"
	s=$(sed -En "s/^$quoi=(.*)$/\1/p" ../.mldsEnv | sed "/^\s*$/d")
	if [[ -n "$s" ]]; then
		echo $s
	fi
else
	cat ../.mldsEnv
fi