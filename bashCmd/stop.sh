if [[ $# -eq 1 ]]; then
	 docker stop "$1" 
else 
	if [[ -z $MLDS_C_CURR ]]; then
		echo -e "stop.sh container_ID_NAME"
	else
		 docker stop "$MLDS_C_CURR" 
		 kill -SIGUSR1 $PPID
	fi
fi