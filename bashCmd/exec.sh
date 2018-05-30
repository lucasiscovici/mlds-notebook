
function _exec(){
	if [[ $(docker ps --format="{{.Names}}" | grep -q "$1") ]] && [[ $(docker ps -q | grep -q "$1") ]]; then
		echo "PB $1 n'existe pas"
	else
		# echo -e "PB $1 existe\n"
		# echo -e docker exec $3 "$1" bash -c "$2"
		if [[ -z $3 ]]; then
			docker exec "$1" bash -c "$2"
		else 
			docker exec $3 "$1" bash -c "$2"
		fi
	fi
}

if [[ $# -lt 3 ]]; then
	if [[ $# -eq 2 ]]; then
		if [[ $1 == "ti" || $1=="it" || $1=="-ti"  || $1=="-it" ]]; then
			shift
			if [[ -z $MLDS_C_CURR ]]; then
				echo -e "exec.sh container_ID CMD"
			else
			   _exec "$MLDS_C_CURR" $1 "-ti"
			fi
		fi
	else
		if [[ -z $MLDS_C_CURR ]]; then
			echo -e "exec.sh container_ID CMD"
		else
			 _exec "$MLDS_C_CURR" "$1"
		fi
	fi
else
	 _exec "$1" "$2" "$3"
fi