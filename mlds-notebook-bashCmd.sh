if [[ -n `which curl` ]];then
	rm -rf bashCmd.zip && rm -rf bashCmd && curl -s https://raw.githubusercontent.com/luluperet/mlds-notebook/master/bashCmd.zip -o bashCmd.zip && unzip -q bashCmd.zip && rm -rf bashCmd.zip && ( [[ ! -d "~/.mlds" ]] && mkdir ~/.mlds  || true) && mv bashCmd/* ~/.mlds/ && rm -rf bashCmd  && echo -e 'BashCmd installed !!!\nFor begin to Work:\n\t$ ./envStart.sh <name_futur_container_u_want>\nFor see help:\n\t$ make or $ make help or $ make mlds help=\n'  || echo "pb"
else
	echo "OU EST CURL !!!"
fi