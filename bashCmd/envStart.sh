#!/bin/bash
if [[ -z "$1" ]]; then
	if [[ -n "$OLD_PS1" ]]; then
		echo -e "For Stop The Env\n$ exit"
	fi

else  
	if [[ -n "$OLD_PS1" ]]; then
		echo -e "Only one Env ! Exit for create new one ...\n$ exit"
		exit
	else
		curr=""

		if ./_check.sh "$1"; then
			curr="*"
		fi
		rm .tmpexit &>/dev/null
		shopt -s expand_aliases
		alias _exit="builtin exit"
		alias _docker="docker"
		export _dockerP=$(which docker)
		export PATH="$(pwd):$PATH";
		export OLD_PS1="SETTED";
		export PS1="MLDS-NB-C-CURR->$1$curr):\W\$ " ;
		export MLDS_C_CURR="$1" ;
bash --rcfile <(echo "trap \"./_gb.sh\" exit;shopt -s expand_aliases;alias exit=\"./_exit.sh && _exit\";alias _exit=\"builtin exit\"; function _docker(){ "$_dockerP" \$@;};export -f _docker;function exit(){ ./_exit.sh 0; };function check(){ export PS1=\"MLDS-NB-C-CURR->$MLDS_C_CURR\$(./_check.sh $MLDS_C_CURR && echo '*')):\W$ \"; }; trap 'check' USR1; echo -e \"For Stop The Env\n\t$ exit\";export pidMldsBase=\$$;") || echo "MLDS Env \"$1\" Stopped"
	fi
fi