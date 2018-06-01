if [[ -n `which curl` ]];then
	rm -rf bashCmd.zip && rm -rf bashCmd && curl -s https://raw.githubusercontent.com/luluperet/mlds-notebook/master/bashCmd.zip -o bashCmd.zip && unzip -q bashCmd.zip && rm -rf bashCmd.zip && echo -e 'BashCmd installed, to continue:\n\t$ cd bashCmd \nmake or make help or make mlds help= For see help\nFor begin:\n\t$ ./setEnv.sh <name_futur_container_u_want>"' 
fi