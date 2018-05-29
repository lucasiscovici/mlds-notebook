if [[ $# -ne 2 ]]; then
	echo "start-slave.sh container_ID sparkMasterIP"
else
	docker exec -ti "$1" bash -c 'sudo $SPARK_HOME/sbin/start-slave.sh spark://'$2':7077'
fi