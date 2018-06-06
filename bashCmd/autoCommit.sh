#!/bin/bash
function getAC(){
	echo $(sed -En "s/^AC:(.*)$/\1/p" .mldsEnv | sed "/^$/d")
}
if [[ -n "$OLD_PS1" ]]; then
	ed=$(getAC)
	if [[ $# -lt 1 ]]; then
		[[ -z $(ed)]] && echo "NO" || echo "YES"
	elif [[ $# -ge 1 ]]; then
		if [[ $1 == "YES" || $1 == "NO"]]; then
			#statements
		
		sed -E -i '' "s/^(AU:).*$/\1$1/" .mldsEnv
	else
		echo "bad second arg"
	fi
	fi
fi