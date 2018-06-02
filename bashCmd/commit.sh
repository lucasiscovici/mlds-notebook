#!/bin/bash
name=$MLDS_C_CURR
commit
commit caca
commit image_name mon_container

if [[ "$1" == "-h" || "$1" == "--help" ]]; then
	echo "USAGE: commit.sh [image_name]'"
fi
if [[ -z "$OLD_PS1" ]]; then
	echo -e "MLDS Env Obligatory !!\n\t$ ./envStart name"
	exit
fi
if [[ $# -eq 1 ]]; then
	name="$1"
	if _checkImg "$name"; then
		echo "Name if image aleady exist"
		exit
	fi
fi
nameX="$name"
i=0
while _checkImg "$nameX"; do
	i=$(($i+1))
	nameX=$name"_$i"
done
echo "name of image $nameX"
_docker commit "$MLDS_C_CURR" "$name"
