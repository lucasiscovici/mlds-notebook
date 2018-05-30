if [[ -n `which curl` ]];then
	rm -rf bashCmd.zip && rm -rf bashCmd && curl -s https://raw.githubusercontent.com/luluperet/mlds-notebook/master/bashCmd.zip -o bashCmd.zip && unzip -q bashCmd.zip && rm -rf bashCmd.zip && echo -e 'BashCmd installed, to continue:\n$ cd bashCmd && make' 
fi