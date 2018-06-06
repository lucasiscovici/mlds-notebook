#!/bin/bash
function bou(){
	if [[ -z "$1" ]]; then
		echo "latest"
	else
		echo "$1"
	fi
}
if [[ -n "$OLD_PS1" ]]; then
	sd="$(./confImgRun.sh)"
	if [[ -z "$sd" ]]; then
		sd="image=luluisco/mlds-notebook:latest"
	fi
	sd=$(sed -En "s/image=(.*)/\1/p" <<<"$sd")
	echo $sd
	_docker history $sd | tail -n +2 | head -n 1 | sed "/^\s*$/d" | tr -s " "
fi