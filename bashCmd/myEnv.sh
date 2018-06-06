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
	if  $(./images.sh  -q --filter=reference='$sfm'); then
		echo -n
			exit
	fi
	echo $(./images.sh  --filter=reference='$sfm')
	#--format="{{.Repository}}"	
}
function checkImExist(){
	return [[ -n $(getIm) ]]
}

if [[ $1 == "checkImExist" ]]; then
	#statements
	exit checkImExist
elif [[ $1 == "getEnvIm" ]]; then
	getEnvIm
elif [[ $1 == "getIm" ]]; then
	getIm
elif [[ $1 == "getEnvVol" ]]; then
	echo "custom_$MLDS_C_CURR"
fi