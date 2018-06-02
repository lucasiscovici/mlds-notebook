if [[ $# -lt 1 ]]; then
	 echo "Usage: ./rmVolume.sh"
else 
	 _docker volume rm $@
fi