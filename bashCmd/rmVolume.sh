if [[ $# -lt 1 ]]; then
	 echo "Usage: ./rmVolume.sh"
else 
	 docker volume rm $@
fi