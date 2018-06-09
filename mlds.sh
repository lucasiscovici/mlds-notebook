# ( cp -R ~/.custom/* ~/.customs/ && rm -rf ~/.custom ) &
sudo rstudio-server start &
start-notebook.sh --NotebookApp.token="mlds" $@  

