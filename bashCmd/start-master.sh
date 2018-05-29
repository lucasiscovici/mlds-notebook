if [[ $# -ne 1 ]]; then
	echo "start-master.sh container_ID"
else
	docker exec -ti "$1" bash -c 'sudo $SPARK_HOME/sbin/start-master.sh'
fi