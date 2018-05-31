if [[ $# -ne 1 ]]; then
	 echo "Usage: ./attach.sh vol_NAME"
else 
	docker attach $@
fi