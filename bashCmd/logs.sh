if [[ $# -eq 1 ]]; then
	 _docker logs "$1" $@
else 
	if [[ -z $MLDS_C_CURR ]]; then
		echo -e "logs.sh container_ID"
	else
		 _docker logs "$MLDS_C_CURR"  $@
	fi
fi