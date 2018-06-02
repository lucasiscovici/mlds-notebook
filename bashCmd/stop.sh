if [[ $# -eq 1 ]]; then
	 _docker stop "$1" 
else 
	if [[ -z $MLDS_C_CURR ]]; then
		echo -e "stop.sh container_ID_NAME"
	else
		 _docker stop "$MLDS_C_CURR" && _docker rm "$MLDS_C_CURR" &>/dev/null
		 ./kill.sh
	fi
fi