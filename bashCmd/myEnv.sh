#!/bin/bash

function getC(){
	echo "$MLDS_C_CURR"
}
function 	getEnvIm(){
	me="$(getC)"
	echo "mlds_"$(echo $me | tr A-Z a-z)"_env"
}

function checkImExist(){
	sfm="$(getEnvIm)"
	return [[ -n ./images.sh --format="{{.Repository}}" --filter=reference='mlds_$sfm_env' ]]
}
