#!/bin/bash
function getAC(){
	echo $(sed -En "s/^AC:(.*)$/\1/p" ../.mldsEnv | sed "/^$/d")
}
if [[ -n "$OLD_PS1" ]]; then
	ed=$(getAC)
	if [[ $# -lt 1 ]]; then
		[[ -z $(ed)]] && echo "NO" || echo "YES"
	elif [[ $# -ge 1 ]]; then
		if [[ $1 == "YES" || $1 == "NO"]]; then
			#statements
		./_changeEnv.sh "AU" $1
		else
			# if [[ $1 == "change" ]]; then
			# 	#statements
			# else 
				echo "bad second arg"
			# fi
		fi
	fi
fi