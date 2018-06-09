#!/bin/bash
# echo $(pwd)
# echo "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
if [[ $# -eq 1 ]]; then
	quoi="$1"
	s=$(sed -En "s/^$quoi=(.*)$/\1/p" ../.mldsEnv | sed "/^\s*$/d")
	if [[ -n "$s" ]]; then
		echo $s
	fi
else
	if [[ -f  .mldsEnv ]]; then
		cat .mldsEnv
	else
		echo "create .mldsEnv"
		>.mldsEnv
	fi
	# cat ../.mldsEnv
fi