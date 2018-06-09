#!/bin/bash
. ~/.bashrc
if [[ -n `which curl` ]];then
	rm -rf bashCmd.zip && rm -rf bashCmd && curl -s https://raw.githubusercontent.com/luluperet/mlds-notebook/master/bashCmd.zip -o bashCmd.zip && unzip -q bashCmd.zip && rm -rf bashCmd.zip && ( [[ ! -d ~/.mlds || ! -d ~/.mlds/cmd ]] && mkdir -p ~/.mlds/cmd  || true) && mv bashCmd/* ~/.mlds/cmd && mv ~/.mlds/cmd/envStart.sh ~/.mlds/ && ([[ -z "$(which envStart.sh)" ]] && ( echo "PATH=$HOME/.mlds:$PATH" >> ~/.bashrc && export PATH="$HOME/.mlds:$PATH") || true ) &&  rm -rf bashCmd  && echo -e 'BashCmd installed !!!\nFor begin to Work:\n\t$ ./envStart.sh <name_futur_container_u_want>\nFor see help:\n\t$ make or $ make help or $ make mlds help=\n'  || echo "pb"
else
	echo "OU EST CURL !!!"
fi