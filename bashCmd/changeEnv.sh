if [[ -n "$OLD_PS1" && $# -ge 1 ]]; then
	echo "$1" > .tmpChangeEnv
kill -SIGUSR2 $pidMldsBase 
fi