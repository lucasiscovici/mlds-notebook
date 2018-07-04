# ( cp -R ~/.custom/* ~/.customs/ && rm -rf ~/.custom ) &
sudo rstudio-server start &
export JUPYTER_ENABLE_LAB=yes
start-notebook.sh --NotebookApp.token="mlds" $@  

