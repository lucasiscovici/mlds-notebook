#!/bin/bash
name=$MLDS_C_CURR
ifl="$1"
# commit
# commit caca
# commit image_name mon_container

if [[ "$1" == "-h" || "$1" == "--help" ]]; then
	echo "USAGE: commit.sh [image_name]'"
fi
if [[ -z "$OLD_PS1" ]]; then
	echo -e "MLDS Env Obligatory !!\n\t$ envStart name"
	exit
fi
if ! _check.sh $MLDS_C_CURR;then
	echo "No Container is running ($MLDS_C_CURR)"
	exit
fi
if [[ $# -ge 1 ]]; then
	if [[ $ifl == "-f" ]]; then
		_docker tag $name "tmp$name"
		_docker rmi $name
	else
		name="$1"
		ifl="$2"
			if [[ ($(./_checkImg.sh "$name") && $ifl == "-f" )|| ! $(_checkImg.sh "$name") ]]; then
				_docker tag $name "tmp$name" &>/dev/null
				_docker rmi $name &>/dev/null
				_docker commit "$MLDS_C_CURR" "$name" &>/dev/null
				_docker rmi "tmp$name" &>/dev/null
				exit
			else
				echo "Name if image aleady exist"
				exit
			fi
		
	fi
fi
# nameX="$name"
# i=0
# while ./_checkImg.sh "$nameX"; do
# 	i=$(($i+1))
# 	nameX=$name"_$i"
# done
# echo "name of image $nameX"
# _docker commit "$MLDS_C_CURR" "$nameX"