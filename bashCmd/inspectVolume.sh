if [[ $# -ne 1 ]]; then
	 echo "Usage: ./inspectVolume.sh vol_NAME"
else 
	docker volume inspect $1
fi