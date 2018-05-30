if [[ $# -ne 1 ]]; then
	 echo "Usage: ./createVolume.sh"
else 
	 docker volume create $1
fi