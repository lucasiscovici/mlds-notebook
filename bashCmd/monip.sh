if [[ $# -ne 1 ]]; then
	 echo "Usage: monip.sh l(local)|i(internet)"
else 
	if [[ $1 == "l" ]]; then
		/sbin/ifconfig | grep "inet " | cut -d ' ' -f2
	elif [[ $1 == "i" ]]; then
		curl ifconfig.me
	else
 		echo "Usage: monip.sh l(local)|i(internet)"
	fi
fi