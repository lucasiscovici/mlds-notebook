#!/bin/bash

if [[ -n "$OLD_PS1" ]]; then
	sd="$(./configImgRun.sh)"
	if [[ -z "$sd" ]]; then
		sd="image=luluisco/mlds-notebook latest=latest"
	fi
	sd=$(sed -En "s/image=(.*) latest=(.*)/\1:\2/p")
	_docker history $sd | tail -n +2 | head -n 1
fi