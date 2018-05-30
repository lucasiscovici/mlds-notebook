if [[ $# -ne 1 ]]; then
	 echo "Usage: ./rmVolume.sh"
else 
	 docker volume rm $1
fi