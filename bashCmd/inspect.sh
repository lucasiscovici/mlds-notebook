if [[ $# - 1 ]]; then
	if [[ -z $MLDS_C_CURR ]]; then
	 echo "Usage: inspect.sh id_name_container"
	 exit
	fi
fi 
_docker container inspect $@