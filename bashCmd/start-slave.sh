if [[ $# -ne 2 ]]; then
	if [[ -z $MLDS_C_CURR ]]; then
		echo "start-slave.sh container_ID sparkMasterIP"
	else
		exec.sh "$MLDS_C_CURR" 'sudo $SPARK_HOME/sbin/start-slave.sh spark://'$1':7077'
	fi
else
	exec.sh "$1" 'sudo $SPARK_HOME/sbin/start-slave.sh spark://'$2':7077'
fi