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
	if [[ -z $(./images.sh  -q --filter=reference=$sfm) ]]; then
			exit
	fi
	./images.sh  --filter=reference=$sfm $@ | tail -n +2
	#--format="{{.Repository}}"	
}
function getVol(){
	./volumes.sh --filter=name=$(./myEnv.sh getEnvVol) $@  | tail -n +2
}
function checkImExist(){
	return [[ -n $(getIm) ]]
}
ks="$1"
shift
if [[ $ks == "checkImExist" ]]; then
	#statements
	exit checkImExist
elif [[ $ks == "getEnvIm" ]]; then
	getEnvIm $@
elif [[ $ks == "getIm" ]]; then
	getIm $@
elif [[ $ks == "getEnvVol" ]]; then
	echo "custom_$MLDS_C_CURR"
elif [[ $ks == "getVol" ]]; then
	getVol $@
elif [[ $ks == "getAll" ]];then
	echo IMAGE:$(getIm) 
	echo Vol:$(getVol)

else
	echo "checkImExist getEnvIm getIm getEnvVol getVol getAll"
fi

# ./volumes.sh --format='{{.Name}}' --filter=name=$(./myEnv.sh getEnvVol)