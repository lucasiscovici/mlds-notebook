#!/bin/bash

function getC(){
	echo "$MLDS_C_CURR"
}
function 	getEnvIm(){
	me="$(getC)"
	echo "mlds_"$(echo $me | tr A-Z a-z)"_env"
}

function getIm(){
	sfm="$(getEnvIm)"
	echo ./images.sh  --filter=reference='$sfm'
	#--format="{{.Repository}}"
}
function checkImExist(){
	return [[ -n $(getIm) ]]
}

if [[ $1 == "checkImExist" ]]; then
	#statements
	exit checkImExist
elif [[ $1 == "getEnvIm" ]]; then
	echo $(getEnvIm)
elif [[ $1 == "getIm" ]]; then
	echo $(getIm)
fi