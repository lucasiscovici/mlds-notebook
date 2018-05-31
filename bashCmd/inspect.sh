if [[ $# - 1 ]]; then
	if [[ -z $MLDS_C_CURR ]]; then
	 echo "Usage: ./inspect.sh id_name_container"
	else
		 docker container inspect $1
	fi
else 
	docker container inspect $@
fi