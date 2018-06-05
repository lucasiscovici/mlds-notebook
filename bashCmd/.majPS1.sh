#!/bin/bash

s=$(uname)
if [[ $q == "Linux" ]];
	echo "MLDS-NB-C-CURR->$1$2:\w\$ "
elif [[ $q =="Darwin" ]]; then
	echo "MLDS-NB-C-CURR->$1$2):\W\$ "
else
	echo "WINDOWS PBBBBBB"
fi