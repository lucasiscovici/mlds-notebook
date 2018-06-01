
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
		export PATH="$(pwd):$PATH";
		export OLD_PS1="SETTED";
		export PS1="MLDS-NB-C-CURR->$1$curr):\W\$ " ;
		export MLDS_C_CURR="$1" ;
bash --rcfile <(echo "function check(){ export PS1=\"MLDS-NB-C-CURR->$MLDS_C_CURR\$(./_check.sh $MLDS_C_CURR && echo '*')):\W$ \"; }; trap 'check' USR1; echo -e \"For Stop The Env\n\t$ exit\";export pidMldsBase=\$$")
	fi
fi