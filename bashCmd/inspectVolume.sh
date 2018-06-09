if [[ $# -ne 1 ]]; then
	 echo "Usage: inspectVolume.sh vol_NAME"
else 
	_docker volume inspect $1
fi