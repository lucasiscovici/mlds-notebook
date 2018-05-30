if [[ -n `which curl` ]];then
	curl -s https://raw.githubusercontent.com/luluperet/mlds-notebook/master/bashCmd.zip -o bashCmd.zip && unzip -q bashCmd.zip && rm -rf bashCmd.zip && echo -n "BashCmd installed, to continue:\n$ cd bashCmd && make  " 
fi