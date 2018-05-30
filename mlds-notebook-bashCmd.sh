if [[ -n `which curl` ]];then
	curl -s https://raw.githubusercontent.com/luluperet/mlds-notebook/master/bashCmd.zip -o bashCmd.zip && unzip bashCmd.zip && rm -rf bashCmd.zip && cd bashCmd && ls 
fi