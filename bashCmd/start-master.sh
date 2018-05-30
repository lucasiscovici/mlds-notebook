
if [[ $# -ne 1 ]]; then
	if [[ -z $MLDS_C_CURR ]]; then
		echo "start-master.sh container_ID"
	else
		./exec.sh "$MLDS_C_CURR" 'sudo $SPARK_HOME/sbin/start-master.sh'
	fi
else
	./exec.sh "$1" 'sudo $SPARK_HOME/sbin/start-master.sh'
fi