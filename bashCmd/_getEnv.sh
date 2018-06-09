#!/bin/bash
# echo $(pwd)
# echo "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
if [[ $# -ge 1 ]]; then
	quoi="$1"
	if [[ $# -eq 1  ]]; then
		s=$(sed -En "s/^$quoi=(.*)$/\1/p" .mldsEnv | sed "/^\s*$/d")
		if [[ -n "$s" ]]; then
			echo $s
		fi
	elif [[ $# -eq 2 && $2 == "-q" ]]; then
		#statements
		s=$(sed -En "s/^($quoi=.*)$/\1/p" .mldsEnv | sed "/^\s*$/d")
	if [[ -n "$s" ]]; then
		echo $s
	fi
	fi
else
	if [[ -f  .mldsEnv ]]; then
		echo -e ".mldsEnv:\n"
		cat .mldsEnv
	else
		echo "create .mldsEnv"
		>.mldsEnv
	fi
	# cat ../.mldsEnv
fi