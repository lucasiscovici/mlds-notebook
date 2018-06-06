#!/bin/bash

if [[ $# -eq 1 ]]; then
	quoi="$1"
	$(sed -En "s/^$quoi:(.*)$/\1/p" ../.mldsEnv | sed "/^$/d")
fi