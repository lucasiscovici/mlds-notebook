#!/bin/bash

function fnd(){

}

if [[ $1 == "install" && $# -gt 2 ]];then
	if [[ ${2:0:1} == "-" ]];then
		echo "USAGE: pip install packageName opts...."
	else
		what="$2"
		if MLDS_VIMG_CHERCHE "python" what;then
			echo "trouvé"
		else
			echo "pas Touvé-on install"
			MLDS_VIMG_INSTALL "python" what #ON INSTALL DANS L'IMAGE VIMG
			MLDS_VIMG_TMP_INSTALL "python" what
		fi

	fi
else
	_pip $@
fi