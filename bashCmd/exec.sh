
function _exec(){
	docker exec -ti "$1" bash -c '$2'
}

if [[ $# -lt 2 ]]; then
	if [[ -z $MLDS_C_CURR ]]; then
		echo "exec.sh container_ID CMD"
	else
		docker exec -ti "$MLDS_C_CURR" bash -c '$2'
	fi
else
	docker exec -ti "$1" bash -c '$2'
fi