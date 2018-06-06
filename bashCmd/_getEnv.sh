#!/bin/bash

if [[ $# -eq 1 ]]; then
	quoi="$1"
	echo $(sed -En "s/^$quoi:(.*)$/\1/p" ../.mldsEnv | sed "/^$/d")
fi